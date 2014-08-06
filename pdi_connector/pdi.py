# -*- coding: utf-8 -*-
##############################################################################
#
#    pdi_connector module for OpenERP, Module to manage Pentaho Data
#                                      Integration
#    Copyright (C) 2010 SYLEAM (<http://www.syleam.fr/>)
#                  2013-2014 MIROUNGA (<http://www.mirounga.fr>)
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

from openerp.osv import orm
from openerp.osv import fields
from openerp.tools import config
from openerp.tools.translate import _
from openerp.modules import get_module_path
from openerp.addons.pdi_connector.common import PDI_VERSION, PDI_STATUS, GET_LEVEL  # noqa

import openerp
import subprocess
import os
import base64
import thread
import pooler
import openerp.tools as tools
import time
import logging
import tempfile
import glob

from datetime import datetime, timedelta

_logger = logging.getLogger(__name__)

root_install = tools.config.get('pdi_path', '/opt/pdi') or '/opt/pdi'
_logger.info('PDI Path: %s' % root_install)

exec_shell = tools.config.get('pdi_shell', '/bin/bash') or '/bin/bash'
_logger.info('Shell use to execute pan and kitchen: %s' % exec_shell)

try:
    import getpass
    username = getpass.getuser()
except:
    username = 'openerp'


class PdiInstance(orm.Model):
    _name = 'pdi.instance'
    _description = 'Instance of PDI server'

    _columns = {
        'name': fields.char('Name', size=64, required=True),
        'version': fields.selection(PDI_VERSION, 'Version', required=True,),
        'trans_ids': fields.one2many('pdi.transformation', 'instance_id',
                                     'Transformations'),
        'task_ids': fields.one2many('pdi.task', 'instance_id', 'Tasks', ),
        'note': fields.text('Note', ),
        'repo_name': fields.char('Name', size=256, required=True,
                                 help='Enter the name of the repository'),
        'repo_user': fields.char('Username', size=64, required=True,
                                 help='Enter the username for this repository'),  # noqa
        'repo_pass': fields.char('Password', size=64, required=True,
                                 help='Enter the password for this repository'),  # noqa
        'param_ids': fields.one2many('pdi.instance.parameters', 'instance_id',
                                     'Parameters'),
        'username': fields.char('Username', size=64,
                                help='OpenERP User to connect tools with XMLRPC or NETRPC'),  # noqa
        'password': fields.char('Password', size=64,
                                help='Password for the OpenERP User'),
    }

    _defaults = {
        'repo_name': '',
        'repo_user': 'admin',
        'repo_pass': 'admin',
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
                _logger.info('Import schema have been created !')
                cr.execute("""CREATE SCHEMA import;
        COMMENT ON SCHEMA import
        IS 'Schema use to store table to import data for PDI treatement';""")

            cr.execute("""SELECT count(*)
                          FROM   pg_namespace
                          WHERE  nspname='export'""")
            if not cr.fetchone()[0]:
                _logger.info('Export schema have been created !')
                cr.execute("""CREATE SCHEMA export;
        COMMENT ON SCHEMA export
        IS 'Schema use to store table to export data for PDI treatement';""")

            # To continue correctly, we check if we have admin privilege
            # in these database server
            admin_privilege = False
            cr.execute("""SELECT count(*) from pg_roles
                           WHERE rolname=%s and rolcanlogin=false;
                       """, (config.get('db_admin', 'oerpadmin'),))
            if cr.fetchone()[0]:
                admin_privilege = True

            # Check if kettle PostgreSQL user exists, if yes:
            pdi_user_exists = False
            cr.execute("""SELECT count(*) from pg_roles
                       WHERE rolname=%s and rolcanlogin=True;
                       """, (config.get('pdi_dbuser', 'kettle'),))
            if cr.fetchone()[0]:
                pdi_user_exists = True
            else:
                # If kettle user doesn't exist,
                # check if we have role with SUPERUSER rights
                if admin_privilege:
                    cr.execute("""SET ROLE %s""", (config.get('db_admin', 'oerpadmin'),))  # noqa
                    cr.execute("""CREATE ROLE """ + config.get('pdi_dbuser', 'kettle') + """ LOGIN ENCRYPTED PASSWORD %s
                        NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;""", (config.get('pdi_dbpass', 'secret'),))  # noqa

                    cr.execute("""ALTER ROLE """ + config.get('pdi_dbuser', 'kettle') + """ SET search_path=kettle;""")  # noqa
                    cr.execute("""COMMENT ON ROLE """ + config.get('pdi_dbuser', 'kettle') + """ IS 'User for pentaho data integration';""")  # noqa
                    cr.commit()
                    cr.execute("""RESET ROLE;""")
                    pdi_user_exists = True

            # Check if kettle schema have been created, if not log a warning
            cr.execute("""SELECT count(*) FROM pg_namespace
                           WHERE  nspname='kettle'""")
            if not cr.fetchone()[0]:
                if pdi_user_exists and admin_privilege:
                    cr.execute("""SET ROLE %s""", (config.get('db_admin', 'oerpadmin'),))  # noqa
                    _logger.warn('Kettle schema does not exits, we create it automatically')  # noqa
                    cr.execute("""CREATE SCHEMA kettle AUTHORIZATION """ + config.get('pdi_dbuser', 'kettle') + ";")  # noqa
                    cr.execute("""COMMENT ON SCHEMA kettle IS 'Schema pour Pentaho Data Integration';""")  # noqa

                    # After create the schema,
                    # we initialize the repository with a SQL file
                    fct_file = openerp.tools.misc.file_open(
                        os.path.join(get_module_path('pdi_connector'),
                                     'sql', 'repository44.sql'))
                    try:
                        query = fct_file.read() % {
                            'db_user': config.get('pdi_dbuser', 'kettle')}
                        cr.execute(query)
                        cr.commit()
                    finally:
                        fct_file.close()

                    cr.execute("""RESET ROLE;""")
                else:
                    _logger.warn('Kettle schema does not exits, create it before use kettle! or define an PostgreSQL Admin user')  # noqa

            # Check if all table in schema kettle is owned by kettle user
            if pdi_user_exists and admin_privilege:
                cr.execute("""SET ROLE %s""", (
                    config.get('db_admin', 'oerpadmin'),))
                # First we always affect owner kettle to the schema kettle
                cr.execute("""ALTER SCHEMA kettle OWNER TO """ + config.get('pdi_dbuser', 'kettle') + """;""")  # noqa
                cr.execute("""SELECT schemaname, tablename
                                FROM pg_tables
                               WHERE schemaname='""" + config.get('pdi_dbuser', 'kettle') + """'
                                 AND tableowner != '""" + config.get('pdi_dbuser', 'kettle') + """';""")  # noqa
                for tbl in cr.fetchall():
                    _logger.warn("Table %s.%s does not have the good right" % (tbl[0], tbl[1]))  # noqa
                    cr.execute("""ALTER TABLE """ + tbl[0] + """.""" + tbl[1] + """ OWNER TO """ + config.get('pdi_dbuser', 'kettle') + """;""")  # noqa
                # Do the same for sequence
                cr.execute("""SELECT schemaname, relname
                                FROM pg_statio_all_sequences
                               WHERE schemaname='""" + config.get('pdi_dbuser', 'kettle') + """';""")  # noqa
                for seq in cr.fetchall():
                    cr.execute("""ALTER SEQUENCE """ + seq[0] + """.""" + seq[1] + """ OWNER TO """ + config.get('pdi_dbuser', 'kettle') + """;""")  # noqa

        # Update ir_config_parameter for using with PL/Python
        config_obj = pool.get('ir.config_parameter')
        user = pool.get('res.users').browse(cr, 1, 1)
        config_obj.set_param(
            cr, 1, 'extlib.host',
            tools.config.get('netrpc_interface', 'localhost') or 'localhost')
        config_obj.set_param(
            cr, 1, 'extlib.port', tools.config.get('netrpc_port', 'localhost'))
        config_obj.set_param(cr, 1, 'extlib.user', user.login)
        config_obj.set_param(cr, 1, 'extlib.pass', user.password)

        super(PdiInstance, self).__init__(pool, cr)


class PdiInstanceParameters(orm.Model):
    """
    Add parameters for instance, and write then in ~/.kettle/kettle.properties
    """
    _name = 'pdi.instance.parameters'
    _description = 'Parameters for this instance'

    _columns = {
        'instance_id': fields.many2one('pdi.instance', 'Instance'),
        'name': fields.char('Name', size=32, required=True,
                            help='Name of the parameters, in upper case',),
        'value': fields.char('Value', size=256, required=True,
                             help='Use [[ ]] to eval, time, datetime, timedelta is available'),  # noqa
    }


class PdiTransformation(orm.Model):
    """
    Manage Transformation in the kettle repository
    """
    _name = 'pdi.transformation'
    _description = 'Transformation of a PDI instance'

    _columns = {
        'name': fields.char('Name', size=128, required=True),
        'instance_id': fields.many2one('pdi.instance', 'Instance',
                                       required=True),
        'state': fields.selection(PDI_STATUS, 'Status'),
        'directory': fields.char('Directory', size=256),
        'param_ids': fields.one2many('pdi.trans.param', 'trans_id',
                                     'Parameters'),
        'level': fields.selection(GET_LEVEL, 'Level', ),
        'note': fields.text('Note', help='Explain the process for the user'),
        'log_cmd': fields.boolean('Log Command',
                                  help='Log command file as info, usefull for debugging'),  # noqa
        'memory': fields.integer('Memory',
                                 help='Custom memory to launch this treament, if 0 use standard'),  # noqa
        'cron_id': fields.many2one('ir.cron', 'Cron',
                                   help='If fill, this transformation is schedule'),  # noqa
    }

    _defaults = {
        'state': 'stop',
        'level': 'Basic',
        'note': False,
        'log_cmd': False,
        'memory': 0,
    }

    def execute_transformation(self, cr, uid, ids, context=None):
        """
        Execute the transformation
        """
        if context is None:
            context = {}

        if context.get('nopdi'):
            _logger.info('Execute transformation abort by nopdi in context')
            return True

        transf = self.browse(cr, uid, ids[0], context=context)

        if transf.state in ('disable', 'run'):
            # already launched or disable
            return True

        self.write(cr, uid, ids, {'state': 'run'}, context=context)

        pdi = root_install + '/' + transf.instance_id.version
        if not os.path.exists(pdi):
            raise orm.except_orm(_('Error'), _('pdi path does not exist'))

        # If there is a custom memory parameter to launch pan, pass it
        # to the command line
        env = None
        if transf.memory:
            env = os.environ.copy()
            env['JAVAMAXMEM'] = str(transf.memory)

        # We create a new parameter OERP_EXPORT_EXPORT to store all files
        # produce by this transformation
        # and for each files, we create an attachment in OpenERP
        tmpdir = tempfile.mkdtemp(prefix='oerp', suffix='trans')

        ctx = context.copy()
        cmd = [
            '%s/pan.sh' % pdi,
            '"-rep=%s"' % transf.instance_id.repo_name,
            '"-user=%s"' % transf.instance_id.repo_user,
            '"-pass=%s"' % transf.instance_id.repo_pass,
            '"-dir=%s"' % transf.directory,
            '"-trans=%s"' % transf.name,
            '"-level=%s"' % transf.level,
            '"-param:%s=/tmp/pan-stdout-%s-%s.log"' % ('PDI_LOG', cr.dbname, str(ids[0])),  # noqa
            '"-param:%s=%s"' % ('OERP_DB_HOST', bool(tools.config.get('db_host', False)) and tools.config['db_host'] or 'localhost'),  # noqa
            '"-param:%s=%s"' % ('OERP_DB_PORT', bool(tools.config.get('db_port', False)) and tools.config['db_port'] or '5432'),  # noqa
            '"-param:%s=%s"' % ('OERP_DB_NAME', cr.dbname),
            '"-param:%s=%s"' % ('OERP_DB_USER', tools.config.get('db_user', 'openerp')),  # noqa
            '"-param:%s=%s"' % ('OERP_DB_PASS', tools.config.get('db_password', 'openerp')),  # noqa
            '"-param:%s=%s"' % ('OERP_XMLRPC_PORT', bool(tools.config.get('xmlrpc_port', False)) and tools.config['xmlrpc_port'] or '8069'),  # noqa
            '"-param:%s=%s"' % ('OERP_USERNAME', transf.instance_id.username or 'admin'),  # noqa
            '"-param:%s=%s"' % ('OERP_PASSWORD', transf.instance_id.password or 'admin'),  # noqa
            '"-param:%s=%s"' % ('OERP_SMTP_HOST', bool(tools.config.get('smtp_server', False)) and tools.config['smtp_server'] or 'localhost'),  # noqa
            '"-param:%s=%s"' % ('OERP_SMTP_PORT', bool(tools.config.get('smtp_port', False)) and tools.config['smtp_port'] or '25'),  # noqa
            '"-param:%s=%s"' % ('OERP_SMTP_USER', bool(tools.config.get('smtp_user', False)) and tools.config['smtp_user'] or username),  # noqa
            '"-param:%s=%s"' % ('OERP_SMTP_PASS', bool(tools.config.get('smtp_password', False)) and tools.config['smtp_password'] or ''),  # noqa
            '"-param:%s=%s"' % ('OERP_EXPORT_PATH', tmpdir),
        ]

        # for each param define on this transformation, add it as argument
        d_par = {
            'dbname': cr.dbname,
            'dbuser': tools.config['db_user'],
            'uid': uid,
            'username': username,
        }

        def convert_param(parameter, additional_dict=None):
            """
            If parameter starts with [[ we evaluate the content
            """
            if additional_dict is None:
                additional_dict = {}

            if parameter and parameter.startswith('[['):
                return eval(parameter.replace('[[', '').replace(']]', ''), {
                    'time': time, 'datetime': datetime,
                    'timedelta': timedelta}) or ''
            return parameter % additional_dict

        additionnal_params = {}
        # First we add global parameters come from INSTANCE declaration
        for p in transf.instance_id.param_ids:
            additionnal_params[p.name.upper()] = convert_param(p.value, d_par)

        # Add new parameters or override the global defined
        for p in transf.param_ids:
            additionnal_params[p.name.upper()] = convert_param(p.value, d_par)

        # Add all new parameters on the command line
        for k, v in additionnal_params.items():
            cmd.append('"-param:%s=%s"' % (k, v))

        def thread_transformation(cr, uid, ids, cmd, path, env=None,
                                  exportfiledir='/tmp', context=None):
            """
            Execute the transformation in a thread
            """
            cr = pooler.get_db(cr.dbname).cursor()
            _logger.debug('(trans) Thread start')

            out_filename = '/tmp/pan-stdout-%s-%s.log' % (cr.dbname,
                                                          str(ids[0]))
            outfp = open(out_filename, 'w')

            err_filename = '/tmp/pan-stderr-%s-%s.log' % (cr.dbname,
                                                          str(ids[0]))
            errfp = open(err_filename, 'w')
            _logger.debug('(trans) Call process')
            retcode = subprocess.call(' '.join(cmd), 0, exec_shell, None,
                                      outfp, errfp, shell=True, env=env,
                                      cwd=path)
            _logger.debug('(trans) End call process (return code: %s)' % str(retcode))  # noqa
            outfp.close()
            errfp.close()

            note = False
            prefix = "E"
            if retcode == 0:
                prefix = "S"
            elif retcode == 1:
                note = _('(1) Errors occurred during processing')
            elif retcode == 2:
                note = _('(2) An unexpected error occurred during loading / running of the transformation')  # noqa
            elif retcode == 3:
                note = _('(3) Unable to prepare and initialize this transformation')  # noqa
            elif retcode == 7:
                note = _("(7) The transformation couldn't be loaded from XML or the Repository")  # noqa
            elif retcode == 8:
                note = _('(8) Error loading steps or plugins (error in loading one of the plugins mostly)')  # noqa
            elif retcode == 9:
                note = _('(9) Command line usage printing')
            else:
                note = _('(%s) Unknown error') % str(retcode)

            def add_attachment(filename, title=None, replace=False,
                               res_model='pdi.transformation', res_id=ids[0]):
                if title is None:
                    title = prefix + '-' + transf.name.replace(' ', '-') + \
                        '-' + time.strftime('%Y%m%d%H%M%S') + '.log'

                if transf.log_cmd:
                    _logger.info('Save filed %s (%s) [%s:: %d]' % (title, filename, res_model, int(res_id)))  # noqa
                else:
                    _logger.debug('Save filed %s (%s) [%s:: %d]' % (title, filename, res_model, int(res_id)))  # noqa

                fp = open(filename, 'rb')
                vals = {
                    'datas': base64.encodestring(fp.read()),
                    'datas_fname': filename,
                    'name': title,
                    'res_model': res_model,
                    'res_id': int(res_id),
                    'description': note,
                }
                fp.close()
                try:
                    self.pool.get('ir.attachment').create(
                        cr, uid, vals, context=context)
                except Exception, e:
                    _logger.error('Save filed failed! %s (%s) [%s:: %d]' % (title, filename, res_model, int(res_id)))  # noqa
                    _logger.error(str(e))

            # We save the logfile
            add_attachment(out_filename)

            # For each file, we must save it as attachment
            for tname in glob.glob(exportfiledir + '/*'):
                # Check the name of the file, if it containt and @
                # left part containt object name and id and right part
                # containt name of the file and extension
                # like sale.order-10@filename.ods
                filename = tname.split('/')[-1]
                if len(filename.split('@')) == 1:
                    # This is a normal file, attach it to the transformation
                    add_attachment(tname, filename)
                elif len(filename.split('@')) == 2:
                    (record, fname) = filename.split('@')
                    record = record.split('-')
                    if len(record) == 2:
                        add_attachment(tname, fname, res_model=record[0],
                                       res_id=record[1])
                    else:
                        note += _('\nBE CAREFULL, record are incorrect for %s') % record  # noqa
                        add_attachment(tname, fname)

                # Remove the file, becacuse removedirs() cannot delete
                # directory if there are files inside
                os.remove(tname)

            # We must remove the temporary directory
            os.removedirs(exportfiledir)

            # Now we stop the transformation
            self.write(cr, uid, ids, {'state': 'stop'}, context=context)
            cr.commit()
            cr.close()

            return True

        if transf.log_cmd:
            _logger.info('(trans) Compose thread with %s' % ' '.join(cmd))
        else:
            _logger.debug('(trans) Compose thread with %s' % ' '.join(cmd))

        thread.start_new_thread(thread_transformation, (cr, uid, ids, cmd,
                                                        pdi, env, tmpdir, ctx))
        return True

    def run_scheduler(self, cr, uid, transformation_id=False, context=None):
        """
        Run a transformation launch by a scheduler
        """
        if not transformation_id:
            return False

        _logger.info('Launch transformation %d' % (transformation_id,))
        return self.execute_transformation(cr, uid, [transformation_id],
                                           context=context)

    def install_cron(self, cr, uid, ids, context=None):
        """
        When Install button is clicked, we add new entry on ir.cron
        for this transformation
        """
        trs = self.browse(cr, uid, ids[0], context=context)
        cron_id = self.pool.get('ir.cron').create(cr, uid, {
            'name': '%s (%d)' % (trs.name, ids[0]),
            'active': False,
            'user_id': uid,
            'interval_number': 1,
            'interval_type': 'days',
            'numbercall': -1,
            'doall': False,
            'model': 'pdi.transformation',
            'function': 'run_scheduler',
            'args': '(%d,)' % ids[0],
        }, context=context)
        return self.write(cr, uid, ids, {'cron_id': cron_id}, context=context)

    def uninstall_cron(self, cr, uid, ids, context=None):
        """
        When Install button is clicked, we add new entry on ir.cron
        for this transformation
        """
        trs = self.browse(cr, uid, ids[0], context=context)
        self.pool.get('ir.cron').unlink(cr, uid, [trs.cron_id.id],
                                        context=context)
        return self.write(cr, uid, ids, {'cron_id': False}, context=context)


class PdiTransParam(orm.Model):
    _name = 'pdi.trans.param'
    _description = 'Parameter to launch transformation'

    _columns = {
        'name': fields.char('Name', size=64, required=True),
        'value': fields.char('Value', size=256, required=True,
                             help='Use [[ ]] to eval, time, datetime, timedelta is available'),  # noqa
        'trans_id': fields.many2one('pdi.transformation', 'Transformation'),
    }


class PdiTask(orm.Model):
    """
    Manage Task in the kettle repository
    """
    _name = 'pdi.task'
    _description = 'Task of a PDI instance'

    _columns = {
        'name': fields.char('Name', size=128, required=True),
        'instance_id': fields.many2one('pdi.instance', 'Instance',
                                       required=True),
        'state': fields.selection(PDI_STATUS, 'Status', ),
        'directory': fields.char('Directory', size=256),
        'param_ids': fields.one2many('pdi.task.param', 'trans_id',
                                     'Parameters'),
        'level': fields.selection(GET_LEVEL, 'Level', ),
        'note': fields.text('Note', help='Explain the process for the user'),
        'log_cmd': fields.boolean('Log Command',
                                  help='Log command file as info, usefull for debugging'),  # noqa
        'memory': fields.integer('Memory',
                                 help='Custom memory to launch this treament, if 0 use standard'),  # noqa
    }

    _defaults = {
        'state': 'stop',
        'level': 'Basic',
        'note': False,
        'memory': 0,
    }

    def execute_task(self, cr, uid, ids, context=None):
        """
        Execute the task
        """
        if context is None:
            context = {}

        if context.get('nopdi'):
            _logger.info('Execute task abort by nopdi in context')
            return True

        task = self.browse(cr, uid, ids[0], context=context)

        if task.state in ('disable', 'run'):
            # already launched or disable
            return True

        self.write(cr, uid, ids, {'state': 'run'}, context=context)

        pdi = root_install + '/' + task.instance_id.version
        if not os.path.exists(pdi):
            raise orm.except_orm(_('Error'), _('pdi path does not exist'))

        # If there is a custom memory parameter to launch pan, pass it
        # to the command line
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
            '"-param:%s=/tmp/kitchen-stdout-%s-%s.log"' % ('PDI_LOG', cr.dbname, str(ids[0])),  # noqa
            '"-param:%s=%s"' % ('OERP_DB_HOST', bool(tools.config.get('db_host', False)) and tools.config['db_host'] or 'localhost'),  # noqa
            '"-param:%s=%s"' % ('OERP_DB_PORT', bool(tools.config.get('db_port', False)) and tools.config['db_port'] or '5432'),  # noqa
            '"-param:%s=%s"' % ('OERP_DB_NAME', cr.dbname),
            '"-param:%s=%s"' % ('OERP_DB_USER', tools.config.get('db_user', 'openerp')),  # noqa
            '"-param:%s=%s"' % ('OERP_DB_PASS', tools.config.get('db_password', 'openerp')),  # noqa
            '"-param:%s=%s"' % ('OERP_XMLRPC_PORT', bool(tools.config.get('xmlrpc_port', False)) and tools.config['xmlrpc_port'] or '8069'),  # noqa
            '"-param:%s=%s"' % ('OERP_USERNAME', task.instance_id.username or 'admin'),  # noqa
            '"-param:%s=%s"' % ('OERP_PASSWORD', task.instance_id.password or 'admin'),  # noqa
            '"-param:%s=%s"' % ('OERP_SMTP_HOST', bool(tools.config.get('smtp_server', False)) and tools.config['smtp_server'] or 'localhost'),  # noqa
            '"-param:%s=%s"' % ('OERP_SMTP_PORT', bool(tools.config.get('smtp_port', False)) and tools.config['smtp_port'] or '25'),  # noqa
            '"-param:%s=%s"' % ('OERP_SMTP_USER', bool(tools.config.get('smtp_user', False)) and tools.config['smtp_user'] or username),  # noqa
            '"-param:%s=%s"' % ('OERP_SMTP_PASS', bool(tools.config.get('smtp_password', False)) and tools.config['smtp_password'] or ''),  # noqa
        ]

        # for each param define on this task, add it as argument
        d_par = {
            'dbname': cr.dbname,
            'dbuser': tools.config['db_user'],
            'uid': uid,
            'username': username,
        }

        def convert_param(parameter, additional_dict=None):
            """
            If parameter starts with [[ we evaluate the content
            """
            if additional_dict is None:
                additional_dict = {}

            if parameter and parameter.startswith('[['):
                return eval(parameter.replace('[[', '').replace(']]', ''),
                            {'time': time, 'datetime': datetime,
                             'timedelta': timedelta}) or ''
            return parameter % additional_dict

        additionnal_params = {}
        # First we add global parameters come from INSTANCE declaration
        for p in task.instance_id.param_ids:
            additionnal_params[p.name.upper()] = convert_param(p.value, d_par)

        # Add new parameters or override the global defined
        for p in task.param_ids:
            additionnal_params[p.name.upper()] = convert_param(p.value, d_par)

        # Add all new parameters on the command line
        for k, v in additionnal_params.items():
            cmd.append('"-param:%s=%s"' % (k, v))

        def thread_task(cr, uid, ids, cmd, path, env=None, context=None):
            """
            Execute the transformation in a thread
            """
            cr = pooler.get_db(cr.dbname).cursor()
            _logger.debug('(task) Thread start')

            out_filename = '/tmp/kitchen-stdout-%s-%s.log' % (cr.dbname,
                                                              str(ids[0]))
            outfp = open(out_filename, 'w')

            err_filename = '/tmp/kitchen-stderr-%s-%s.log' % (cr.dbname,
                                                              str(ids[0]))
            errfp = open(err_filename, 'w')
            _logger.debug('(task) Call process')
            retcode = subprocess.call(' '.join(cmd), 0, exec_shell, None,
                                      outfp, errfp, shell=True, env=env,
                                      cwd=path)
            _logger.debug('(task) End call process (return code: %s)' % str(retcode))  # noqa
            outfp.close()
            errfp.close()

            note = False
            prefix = "E"
            if retcode == 0:
                prefix = "S"
            elif retcode == 1:
                note = _('(1) Errors occurred during processing')
            elif retcode == 2:
                note = _('(2) An unexpected error occurred during loading / running of the task')  # noqa
            elif retcode == 7:
                note = _("(7) The task couldn't be loaded from XML or the Repository")  # noqa
            elif retcode == 8:
                note = _('(8) Error loading steps or plugins (error in loading one of the plugins mostly)')  # noqa
            elif retcode == 9:
                note = _('(9) Command line usage printing')
            else:
                note = _('(%s) Unknown error') % str(retcode)

            vals = {
                'datas': base64.encodestring(open(out_filename, 'rb').read()),
                'datas_fname': out_filename,
                'name': prefix + '-' + task.name.replace(' ', '-') + '-' + time.strftime('%Y%m%d%H%M%S') + '.log',  # noqa
                'res_model': 'pdi.task',
                'res_id': ids[0],
                'description': note,
            }
            self.pool.get('ir.attachment').create(cr, uid, vals,
                                                  context=context)

            self.write(cr, uid, ids, {'state': 'stop'}, context=context)
            cr.commit()
            cr.close()
            return True

        if task.log_cmd:
            _logger.info('(task) Compose thread with %s' % ' '.join(cmd))
        else:
            _logger.debug('(task) Compose thread with %s' % ' '.join(cmd))
        thread.start_new_thread(thread_task, (cr, uid, ids, cmd, pdi, env, ctx))  # noqa
        return True


class PdiTaskParam(orm.Model):
    _name = 'pdi.task.param'
    _description = 'Parameter to launch task'

    _columns = {
        'name': fields.char('Name', size=64, required=True),
        'value': fields.char('Value', size=256, required=True,
                             help='Use [[ ]] to eval, time, datetime, timedelta is available',),  # noqa
        'trans_id': fields.many2one('pdi.task', 'Task'),
    }

# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
