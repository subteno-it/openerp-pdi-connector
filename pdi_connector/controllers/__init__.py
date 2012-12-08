# -*- coding: utf-8 -*-
##############################################################################
#
#    pdi_connector module for OpenERP, Pentaho Data Integration Connector
#    Copyright (C) 2012 SYLEAM (<http://www.syleam.fr/>)
#              Christophe CHAUVET <christophe.chauvet@syleam.fr>
#
#    This file is a part of pdi_connector
#
#    pdi_connector is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pdi_connector is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

try:
    import openerp.addons.web.common.http as openerpweb
except ImportError:
    import web.common.http as openerpweb

import werkzeug.wrappers


class PdiImport(openerpweb.Controller):
    _cp_path = "/pdi"

    @openerpweb.httprequest
    def test(self, request, **args):
        """
        You can test this, with wget
        wget -q -O- http://localhost:8069/pdi/test
        """
        if 'token' not in args:
            return werkzeug.wrappers.Response('Missing token', status=400)

        return werkzeug.wrappers.Response('PDI Connector is installed', status=200)


# vim:expandtab:smartindent:tabstop=4:softtabstop=4:shiftwidth=4:
