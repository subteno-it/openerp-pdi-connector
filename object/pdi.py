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

PdiInstance()

_pdi_status = [
    ('stop', 'Stopped'),
    ('run', 'Running'),
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

    }

    _defaults = {
         'state': lambda *a: 'stop',
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
            #'-listdir',
        ]

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
                note = _("The transformation couldn't be loaded from XML or the Repository'")
            elif retcode == 8:
                note = _('Error loading steps or plugins (error in loading one of the plugins mostly)')
            elif retcode == 9:
                note = _('Command line usage printing')
            else:
                note = _('Unknown error %s') % retcode

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
    }

    _defaults = {
         'state': lambda *a: 'stop',
    }

    def execute_task(self, cr, uid, ids, context=None):
        """
        Execute the task
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
            '%s/kitchen.sh' % pdi,
            '-rep=%s' % transf.instance_id.repo_name,
            '-user=%s' % transf.instance_id.repo_user,
            '-pass=%s' % transf.instance_id.repo_pass,
            '-dir=%s' % transf.directory,
            '-job=%s' % transf.name,
            #'-listdir',
        ]

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
                note = _("The task couldn't be loaded from XML or the Repository'")
            elif retcode == 8:
                note = _('Error loading steps or plugins (error in loading one of the plugins mostly)')
            elif retcode == 9:
                note = _('Command line usage printing')
            else:
                note = _('Unknown error %s') % retcode

            vals = {
                'datas': base64.encodestring(open(out_filename, 'rb').read()),
                'datas_fname': out_filename,
                'name': prefix + ' ' + transf.name,
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

# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
