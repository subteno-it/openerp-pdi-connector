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
    ('disable', 'Disable'),
    ('stop', 'Stopped'),
    ('run', 'Running'),
]


class PdiTransformation(osv.osv):
    _name = 'pdi.transformation'
    _description = 'Transformation of a PDI instance'

    _columns = {
        'name': fields.char('Name', size=128, ),
        'instance_id': fields.many2one('pdi.instance', 'Instance', ),
        'state': fields.selection(_pdi_status, 'Status', ),
    }

PdiTransformation()


class PdiTask(osv.osv):
    _name = 'pdi.task'
    _description = 'Task of a PDI instance'

    _columns = {
        'name': fields.char('Name', size=128, ),
        'instance_id': fields.many2one('pdi.instance', 'Instance', ),
        'state': fields.selection(_pdi_status, 'Status', ),
    }

PdiTask()

# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
