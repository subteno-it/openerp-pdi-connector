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

{
    'name': 'PDI Connector',
    'version': '1.3.1',
    'category': 'Custom',
    'description': """Module to manage Pentaho Data Integration
    - Start task or transformation define on the repository
    - Schedule a task
    """,
    'author': 'SYLEAM',
    'website': 'http://www.syleam.fr/',
    'depends': [
        'base',
        'import_export',
    ],
    'init_xml': [],
    'update_xml': [
        'security/groups.xml',
        'security/menus.xml',
        'security/ir.model.access.csv',
        'view/menu.xml',
        'view/pdi.xml',
        #'wizard/wizard.xml',
        #'report/report.xml',
    ],
    'demo_xml': [],
    'installable': True,
    'active': False,
    'license': 'GPL-3',
}


# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
