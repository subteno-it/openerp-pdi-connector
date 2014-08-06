# -*- coding: utf-8 -*-
##############################################################################
#
#    pdi_connector module for OpenERP, Module to manage Pentaho Data Integration
#    Copyright (C) 2013-2014 MIROUNGA (<http://www.mirounga.fr>)
#              Christophe CHAUVET <christophe.chauvet@gmail.com>
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

PDI_VERSION = [
    ('3.2', 'v3.2'),
    ('4.0', 'v4.0'),
    ('4.1', 'v4.1'),
    ('4.2', 'v4.2'),
    ('4.3', 'v4.3'),
    ('4.4', 'v4.4'),
    ('5.0', 'v5.0'),
]


PDI_STATUS = [
    ('stop', 'Stopped'),
    ('run', 'Running'),
]

GET_LEVEL = [
    ('Basic', 'Basic'),
    ('Detailed', 'Detailed'),
    ('Debug', 'Debug'),
    ('Rowlevel', 'Rowlevel'),
    ('Error', 'Error'),
    ('Nothing', 'Nothing'),
]

# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
