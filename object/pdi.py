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

logger = netsvc.Logger()

_pdi_version = [
    ('3.2', 'v3.2'),
    ('4.0', 'v4.0'),
    ('4.1', 'v4.1'),
]

root_install = '/opt/pdi'


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
    }

    _defaults = {
        'repo_name': lambda *a: '',
        'repo_user': lambda *a: 'admin',
        'repo_pass': lambda *a: 'admin',
    }

    def __init__(self, pool, cr):
        """
        Check if import and export schema exists, if not create them
        """
        cr.execute("""show server_version""")
        pg_version = cr.fetchone()[0].split('.')
        pg_version = tuple([int(x) for x in pg_version])
        if pg_version >= (8, 3, 0):
            cr.execute("""SELECT count(*)
                          FROM   pg_namespace
                          WHERE  nspname='import'""")
            if not cr.fetchone()[0]:
                logger.notifyChannel('pdi_connector', netsvc.LOG_INFO, 'Import schema have been created !')
                cr.execute("""CREATE SCHEMA import;
                       COMMENT ON SCHEMA import
                       IS 'Schema use to store table for PDI treatement';""")

            cr.execute("""SELECT count(*)
                          FROM   pg_namespace
                          WHERE  nspname='export'""")
            if not cr.fetchone()[0]:
                logger.notifyChannel('pdi_connector', netsvc.LOG_INFO, 'Export schema have been created !')
                cr.execute("""CREATE SCHEMA export;
                       COMMENT ON SCHEMA export
                       IS 'Schema use to store table for PDI treatement';""")

            # Check if kettle schema have been created, if not log a warning
            cr.execute("""SELECT count(*)
                          FROM   pg_namespace
                          WHERE  nspname='kettle'""")
            if not cr.fetchone()[0]:
                logger.notifyChannel('pdi_connector', netsvc.LOG_WARNING, 'Kettle schema does not exits, create it before use kettle!')
                raise osv.except_osv(_('Error'), _('Kettle schema does not exist, create it before install this module'))

        super(PdiInstance, self).__init__(pool, cr)

PdiInstance()

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
    }

    _defaults = {
        'state': lambda *a: 'stop',
        'level': lambda *a: 'Basic',
        'note': lambda *a: False,
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

        cmd = [
            '%s/pan.sh' % pdi,
            '-rep=%s' % transf.instance_id.repo_name,
            '-user=%s' % transf.instance_id.repo_user,
            '-pass=%s' % transf.instance_id.repo_pass,
            '-dir=%s' % transf.directory,
            '-trans=%s' % transf.name,
            '-level=%s' % transf.level,
            '-param:%s=/tmp/pan-stdout-%s.log' % ('PDI_LOG', str(ids[0])),
            '-param:%s=%s' % ('OERP_DB_HOST', bool(tools.config['db_host']) and tools.config['db_host'] or 'localhost'),
            '-param:%s=%s' % ('OERP_DB_PORT', bool(tools.config['db_port']) and tools.config['db_port'] or '5432'),
            '-param:%s=%s' % ('OERP_DB_NAME', cr.dbname),
            '-param:%s=%s' % ('OERP_DB_USER', tools.config['db_user']),
            '-param:%s=%s' % ('OERP_DB_USER', tools.config['db_password']),
        ]

        # for each param define on this transformation, add it as argument
        for p in transf.param_ids:
            cmd.append('-param:%s=%s' % (p.name.upper(), p.value))

        def thread_transformation(cr, uid, ids, cmd, path, context):
            """
            Execute the transformation in a thread
            """
            cr = pooler.get_db(cr.dbname).cursor()
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(trans) Thread start')

            out_filename = '/tmp/pan-stdout-%s.log' % str(ids[0])
            outfp = open(out_filename, 'w')

            err_filename = '/tmp/pan-stderr-%s.log' % str(ids[0])
            errfp = open(err_filename, 'w')
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(trans) Call process')
            retcode = subprocess.call(' '.join(cmd), 0, None, None, outfp, errfp, shell=True, cwd=path)
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
                'name': prefix + ' ' + transf.name,
                'res_model': 'pdi.transformation',
                'res_id': ids[0],
                'description': note,
            }
            self.pool.get('ir.attachment').create(cr, uid, vals, context=context)

            self.write(cr, uid, ids, {'state': 'stop'}, context=context)
            cr.commit()
            cr.close()
            return True

        logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(trans) Compose thread with %s' % ' '.join(cmd))
        thread.start_new_thread(thread_transformation, (cr, uid, ids, cmd, pdi, context))
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
    }

    _defaults = {
        'state': lambda *a: 'stop',
        'level': lambda *a: 'Basic',
        'note': lambda *a: False,
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

        cmd = [
            '%s/kitchen.sh' % pdi,
            '-rep=%s' % task.instance_id.repo_name,
            '-user=%s' % task.instance_id.repo_user,
            '-pass=%s' % task.instance_id.repo_pass,
            '-dir=%s' % task.directory,
            '-job=%s' % task.name,
            '-level=%s' % task.level,
            '-param:%s=/tmp/kitchen-stdout-%s.log' % ('PDI_LOG', str(ids[0])),
            '-param:%s=%s' % ('OERP_DB_HOST', bool(tools.config['db_host']) and tools.config['db_host'] or 'localhost'),
            '-param:%s=%s' % ('OERP_DB_PORT', bool(tools.config['db_port']) and tools.config['db_port'] or '5432'),
            '-param:%s=%s' % ('OERP_DB_NAME', cr.dbname),
            '-param:%s=%s' % ('OERP_DB_USER', tools.config['db_user']),
            '-param:%s=%s' % ('OERP_DB_USER', tools.config['db_password']),
        ]

        # for each param define on this task, add it as argument
        for p in task.param_ids:
            cmd.append('-param:%s=%s' % (p.name.upper(), p.value))

        def thread_task(cr, uid, ids, cmd, path, context):
            """
            Execute the transformation in a thread
            """
            cr = pooler.get_db(cr.dbname).cursor()
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(task) Thread start')

            out_filename = '/tmp/kitchen-stdout-%s.log' % str(ids[0])
            outfp = open(out_filename, 'w')

            err_filename = '/tmp/kitchen-stderr-%s.log' % str(ids[0])
            errfp = open(err_filename, 'w')
            logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(task) Call process')
            retcode = subprocess.call(' '.join(cmd), 0, None, None, outfp, errfp, shell=True, cwd=path)
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
                'name': prefix + ' ' + task.name,
                'res_model': 'pdi.task',
                'res_id': ids[0],
                'description': note,
            }
            self.pool.get('ir.attachment').create(cr, uid, vals, context=context)

            self.write(cr, uid, ids, {'state': 'stop'}, context=context)
            cr.commit()
            cr.close()
            return True

        logger.notifyChannel('pdi_connector', netsvc.LOG_DEBUG, '(task) Compose thread with %s' % ' '.join(cmd))
        thread.start_new_thread(thread_task, (cr, uid, ids, cmd, pdi, context))
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
