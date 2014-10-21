# -*- coding: utf-8 -*-
##############################################################################
#
#    pdi_connector module for OpenERP, Module to manage Pentaho Data Integration
#    Copyright (C) 2010 SYLEAM (<http://www.syleam.fr/>)
#              Christophe CHAUVET <christophe.chauvet@syleam.fr>
#
#    This file is a part of pdi_connector
#
#    pdi_connector is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pdi_connector is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

from osv import osv
from osv import fields
from tools.translate import _
import subprocess
import os
import base64
import thread
import pooler
import netsvc
import tools
import time

logger = netsvc.Logger()

_pdi_version = [
    ('3.2', 'v3.2'),
    ('4.0', 'v4.0'),
    ('4.1', 'v4.1'),
    ('4.2', 'v4.2'),
]

root_install = tools.config.get('pdi_path', '/opt/pdi') or ''
logger.notifyChannel('init:module pdi_connector', netsvc.LOG_INFO, 'PDI Path: %s' % root_install)

try:
    import getpass
    username = getpass.getuser()
except:
    username = 'openerp'


class PdiInstance(osv.osv):
    _name = 'pdi.instance'
    _description = 'Instance of PDI server'

    _columns = {
        'name': fields.char('Name', size=64, ),
        'version': fields.selection(_pdi_version, 'Version', ),
        'trans_ids': fields.one2many('pdi.transformation', 'instance_id', 'Transformations'),
        'task_ids': fields.one2many('pdi.task', 'instance_id', 'Tasks', ),
        'note': fields.text('Note', ),
        'repo_name': fields.char('Name', size=256, help='Enter the name of the repository'),
        'repo_user': fields.char('Username', size=64, help='Enter the username for this repository'),
        'repo_pass': fields.char('Password', size=64, help='Enter the password for this repository'),
        'param_ids': fields.one2many('pdi.instance.parameters', 'instance_id', 'Parameters'),
        'username': fields.char('Username', size=64, help='OpenERP User to connect tools with XMLRPC or NETRPC'),
        'password': fields.char('Password', size=64, help='Password for the OpenERP User'),
    }

    _defaults = {
        'repo_name': lambda *a: '',
        'repo_user': lambda *a: 'admin',
        'repo_pass': lambda *a: 'admin',
    }

PdiInstance()


class PdiInstanceParameters(osv.osv):
    """
    Add parameters for instance, and write then in ~/.kettle/kettle.properties
    """
    _name = 'pdi.instance.parameters'
    _description = 'Parameters for this instance'

    _columns = {
        'instance_id': fields.many2one('pdi.instance', 'Instance'),
        'name': fields.char('Name', size=32, help='Name of the parameters, in upper case', required=True),
        'value': fields.char('Value', size=256, help='Value of the parameter', required=True),
    }

PdiInstanceParameters()


_pdi_status = [
    ('stop', 'Stopped'),
    ('run', 'Running'),
]

_get_level = [
    ('Basic', 'Basic'),
    ('Detailed', 'Detailed'),
    ('Debug', 'Debug'),
    ('Rowlevel', 'Rowlevel'),
    ('Error', 'Error'),
    ('Nothing', 'Nothing'),
]


class PdiTransformation(osv.osv):
    """
    Manage Transformation in the kettle repository
    """
    _name = 'pdi.transformation'
    _description = 'Transformation of a PDI instance'

    _columns = {
        'name': fields.char('Name', size=128, required=True),
        'instance_id': fields.many2one('pdi.instance', 'Instance', required=True),
        'state': fields.selection(_pdi_status, 'Status'),
        'directory': fields.char('Directory', size=256),
        'param_ids': fields.one2many('pdi.trans.param', 'trans_id', 'Parameters'),
        'level': fields.selection(_get_level, 'Level', ),
        'note': fields.text('Note', help='Explain the process for the user'),
        'log_cmd': fields.boolean('Log Command', help='Log command file as info, usefull for debugging'),
        'memory': fields.integer('Memory', help='Custom memory to launch this treament, if 0 use standard'),
    }

    _defaults = {
        'state': lambda *a: 'stop',
        'level': lambda *a: 'Basic',
        'note': lambda *a: False,
        'log_cmd': lambda *a: False,
        'memory': lambda *a: 0,
    }

    def execute_transformation(self, cr, uid, ids, context=None):
        """
        Execute the transformation
        """
        if context is None:
            context = {}

        transf = self.browse(cr, uid, ids[0], context=context)

        if transf.state in ('disable', 'run'):
            # already launched or disable
            return True

        self.write(cr, uid, ids, {'state': 'run'}, context=context)

        pdi = root_install + '/' + transf.instance_id.version
        if not os.path.exists(pdi):
            raise osv.except_osv(_('Error'), _('pdi path does not exist'))

        # If there is a custom memory parameter to launch pan, pass it to the command line
        env = None
        if transf.memory:
            env = os.environ.copy()
            env['JAVAMAXMEM'] = str(transf.memory)

        ctx = context.copy()
        cmd = [
            '%s/pan.sh' % pdi,
            '"-rep=%s"' % transf.instance_id.repo_name,
            '"-user=%s"' % transf.instance_id.repo_user,
            '"-pass=%s"' % transf.instance_id.repo_pass,
            '"-dir=%s"' % transf.directory,
            '"-trans=%s"' % transf.name,
            '"-level=%s"' % transf.level,
            '"-param:%s=/tmp/pan-stdout-%s-%s.log"' % ('PDI_LOG', cr.dbname, str(ids[0])),
            '"-param:%s=%s"' % ('OERP_DB_HOST', bool(tools.config['db_host']) and tools.config['db_host'] or 'localhost'),
            '"-param:%s=%s"' % ('OERP_DB_PORT', bool(tools.config['db_port']) and tools.config['db_port'] or '5432'),
            '"-param:%s=%s"' % ('OERP_DB_NAME', cr.dbname),
            '"-param:%s=%s"' % ('OERP_DB_USER', tools.config['db_user']),
            '"-param:%s=%s"' % ('OERP_DB_PASS', tools.config['db_password']),
            '"-param:%s=%s"' % ('OERP_XMLRPC_PORT', bool(tools.config['port']) and tools.config['port'] or '8069'),
            '"-param:%s=%s"' % ('OERP_USERNAME', transf.instance_id.username or 'admin'),
            '"-param:%s=%s"' % ('OERP_PASSWORD', transf.instance_id.password or 'admin'),
        ]

        # for each param define on this transformation, add it as argument
        d_par = {
            'dbname': cr.dbname,
            'dbuser': tools.config['db_user'],
            'uid': uid,
            'username': username,
        }
        for p in transf.param_ids:
            cmd.append('"-param:%s=%s"' % (p.name.upper(), p.value % d_par))

        def thread_transformation(cr, uid, ids, cmd, path, env=None, context=None):
            """
            Execute the transformation in a thread
            """
            cr = pooler.get_db(cr.dbname).cursor()
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(trans) Thread start')

            out_filename = '/tmp/pan-stdout-%s-%s.log' % (cr.dbname, str(ids[0]))
            outfp = open(out_filename, 'w')

            err_filename = '/tmp/pan-stderr-%s-%s.log' % (cr.dbname, str(ids[0]))
            errfp = open(err_filename, 'w')
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(trans) Call process')
            retcode = subprocess.call(' '.join(cmd), 0, None, None, outfp, errfp, shell=True, env=env, cwd=path)
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(trans) End call process (return code: %s)' % str(retcode))
            outfp.close()
            errfp.close()

            note = False
            prefix = "[ERROR]"
            if retcode == 0:
                prefix = "[SUCCESS]"
            elif retcode == 1:
                note = _('(1) Errors occurred during processing')
            elif retcode == 2:
                note = _('(2) An unexpected error occurred during loading / running of the transformation')
            elif retcode == 3:
                note = _('(3) Unable to prepare and initialize this transformation')
            elif retcode == 7:
                note = _("(7) The transformation couldn't be loaded from XML or the Repository")
            elif retcode == 8:
                note = _('(8) Error loading steps or plugins (error in loading one of the plugins mostly)')
            elif retcode == 9:
                note = _('(9) Command line usage printing')
            else:
                note = _('(%s) Unknown error') % str(retcode)

            vals = {
                'datas': base64.encodestring(open(out_filename, 'rb').read()),
                'datas_fname': out_filename,
                'name': prefix + ' ' + transf.name + ' [' +  time.strftime('%Y%m%d%H%M%S') + ']',
                'res_model': 'pdi.transformation',
                'res_id': ids[0],
                'description': note,
            }
            try:
                self.pool.get('ir.attachment').create(cr, uid, vals, context=context)
            except Exception, e:
                logger.notifyChannel('pdi_connector', netsvc.LOG_INFO, 'Error when attach file on the transformation\n%s' % str(e))

            self.write(cr, uid, ids, {'state': 'stop'}, context=context)
            cr.commit()
            cr.close()
            return True

        if transf.log_cmd:
            logger.notifyChannel('pdi_connector', netsvc.LOG_INFO, '(trans) Compose thread with %s' % ' '.join(cmd))
        else:
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(trans) Compose thread with %s' % ' '.join(cmd))

        thread.start_new_thread(thread_transformation, (cr, uid, ids, cmd, pdi, env, ctx))
        return True

PdiTransformation()


class PdiTransParam(osv.osv):
    _name = 'pdi.trans.param'
    _description = 'Parameter to launch transformation'

    _columns = {
        'name': fields.char('Name', size=64, required=True),
        'value': fields.char('Value', size=256, required=True),
        'trans_id': fields.many2one('pdi.transformation', 'Transformation'),
    }

PdiTransParam()


class PdiTask(osv.osv):
    """
    Manage Task in the kettle repository
    """
    _name = 'pdi.task'
    _description = 'Task of a PDI instance'

    _columns = {
        'name': fields.char('Name', size=128, required=True),
        'instance_id': fields.many2one('pdi.instance', 'Instance', required=True),
        'state': fields.selection(_pdi_status, 'Status', ),
        'directory': fields.char('Directory', size=256),
        'param_ids': fields.one2many('pdi.task.param', 'trans_id', 'Parameters'),
        'level': fields.selection(_get_level, 'Level', ),
        'note': fields.text('Note', help='Explain the process for the user'),
        'log_cmd': fields.boolean('Log Command', help='Log command file as info, usefull for debugging'),
        'memory': fields.integer('Memory', help='Custom memory to launch this treament, if 0 use standard'),
    }

    _defaults = {
        'state': lambda *a: 'stop',
        'level': lambda *a: 'Basic',
        'note': lambda *a: False,
        'memory': lambda *a: 0,
    }

    def execute_task(self, cr, uid, ids, context=None):
        """
        Execute the task
        """
        if context is None:
            context = {}

        task = self.browse(cr, uid, ids[0], context=context)

        if task.state in ('disable', 'run'):
            # already launched or disable
            return True

        self.write(cr, uid, ids, {'state': 'run'}, context=context)

        pdi = root_install + '/' + task.instance_id.version
        if not os.path.exists(pdi):
            raise osv.except_osv(_('Error'), _('pdi path does not exist'))

        # If there is a custom memory parameter to launch pan, pass it to the command line
        env = None
        if task.memory:
            env = os.environ.copy()
            env['JAVAMAXMEM'] = str(task.memory)

        ctx = context.copy()
        cmd = [
            '%s/kitchen.sh' % pdi,
            '"-rep=%s"' % task.instance_id.repo_name,
            '"-user=%s"' % task.instance_id.repo_user,
            '"-pass=%s"' % task.instance_id.repo_pass,
            '"-dir=%s"' % task.directory,
            '"-job=%s"' % task.name,
            '"-level=%s"' % task.level,
            '"-param:%s=/tmp/kitchen-stdout-%s-%s.log"' % ('PDI_LOG', cr.dbname, str(ids[0])),
            '"-param:%s=%s"' % ('OERP_DB_HOST', bool(tools.config['db_host']) and tools.config['db_host'] or 'localhost'),
            '"-param:%s=%s"' % ('OERP_DB_PORT', bool(tools.config['db_port']) and tools.config['db_port'] or '5432'),
            '"-param:%s=%s"' % ('OERP_DB_NAME', cr.dbname),
            '"-param:%s=%s"' % ('OERP_DB_USER', tools.config['db_user']),
            '"-param:%s=%s"' % ('OERP_DB_PASS', tools.config['db_password']),
            '"-param:%s=%s"' % ('OERP_XMLRPC_PORT', bool(tools.config['port']) and tools.config['port'] or '8069'),
            '"-param:%s=%s"' % ('OERP_USERNAME', task.instance_id.username or 'admin'),
            '"-param:%s=%s"' % ('OERP_PASSWORD', task.instance_id.password or 'admin'),
        ]

        # for each param define on this task, add it as argument
        d_par = {
            'dbname': cr.dbname,
            'dbuser': tools.config['db_user'],
            'uid': uid,
            'username': username,
        }
        for p in task.param_ids:
            cmd.append('"-param:%s=%s"' % (p.name.upper(), p.value % d_par))

        def thread_task(cr, uid, ids, cmd, path, env=None, context=None):
            """
            Execute the transformation in a thread
            """
            cr = pooler.get_db(cr.dbname).cursor()
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(task) Thread start')

            out_filename = '/tmp/kitchen-stdout-%s-%s.log' % (cr.dbname, str(ids[0]))
            outfp = open(out_filename, 'w')

            err_filename = '/tmp/kitchen-stderr-%s-%s.log' % (cr.dbname, str(ids[0]))
            errfp = open(err_filename, 'w')
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(task) Call process')
            retcode = subprocess.call(' '.join(cmd), 0, None, None, outfp, errfp, shell=True, env=env, cwd=path)
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(task) End call process (return code: %s)' % str(retcode))
            outfp.close()
            errfp.close()

            note = False
            prefix = "[ERROR]"
            if retcode == 0:
                prefix = "[SUCCESS]"
            elif retcode == 1:
                note = _('(1) Errors occurred during processing')
            elif retcode == 2:
                note = _('(2) An unexpected error occurred during loading / running of the task')
            elif retcode == 7:
                note = _("(7) The task couldn't be loaded from XML or the Repository")
            elif retcode == 8:
                note = _('(8) Error loading steps or plugins (error in loading one of the plugins mostly)')
            elif retcode == 9:
                note = _('(9) Command line usage printing')
            else:
                note = _('(%s) Unknown error') % str(retcode)

            vals = {
                'datas': base64.encodestring(open(out_filename, 'rb').read()),
                'datas_fname': out_filename,
                'name': prefix + ' ' + task.name + ' [' +  time.strftime('%Y%m%d%H%M%S') + ']',
                'res_model': 'pdi.task',
                'res_id': ids[0],
                'description': note,
            }
            try:
                self.pool.get('ir.attachment').create(cr, uid, vals, context=context)
            except Exception, e:
                logger.notifyChannel('pdi_connector', netsvc.LOG_INFO, 'Error when attach file on the task\n%s' % str(e))

            self.write(cr, uid, ids, {'state': 'stop'}, context=context)
            cr.commit()
            cr.close()
            return True

        if task.log_cmd:
            logger.notifyChannel('pdi_connector', netsvc.LOG_INFO, '(task) Compose thread with %s' % ' '.join(cmd))
        else:
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(task) Compose thread with %s' % ' '.join(cmd))
        thread.start_new_thread(thread_task, (cr, uid, ids, cmd, pdi, env, ctx))
        return True

PdiTask()


class PdiTaskParam(osv.osv):
    _name = 'pdi.task.param'
    _description = 'Parameter to launch task'

    _columns = {
        'name': fields.char('Name', size=64, required=True),
        'value': fields.char('Value', size=256, required=True),
        'trans_id': fields.many2one('pdi.task', 'Task'),
    }

PdiTaskParam()

# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
