# -*- coding: utf-8 -*-
##############################################################################
#
#    pdi_connector module for OpenERP, Module to manage Pentaho Data Integration
#    Copyright (C) 2010-2013 SYLEAM (<http://www.syleam.fr/>)
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
    'name': 'Pentaho Data Integration Connector',
    'version': '1.6',
    'category': 'Tools',
    'description': """Module to manage Pentaho Data Integration
    - Start task or transformation define on the repository
    - Schedule a task

    On the configuration file add new parameters to defined:

    - pdi_path: Folder where PDI is installed, default /opt/pdi
    - pdi_dbuser: Dedicate PostgreSQL user for PDI, default 'kettle'
    - pdi_dbpass: Password of the dedicate PostgreSQL user, default 'secret'

    """,
    'author': 'SYLEAM',
    'website': 'http://www.syleam.fr/',
    'depends': [
        'base_setup',
        'knowledge',
        'web',
    ],
    'data': [
        'security/groups.xml',
        'security/menus.xml',
        'security/ir.model.access.csv',
        'pdi_view.xml',
        'settings_view.xml',
    ],
    'demo': [],
    'installable': True,
    'active': False,
    'license': 'AGPL-3',
    'application': True,
    'complexity': "expert",
}

# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
