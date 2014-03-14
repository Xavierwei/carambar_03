'use strict';

/* Services */


// Demonstrate how to register services
// In this case it is a simple value service.
var SGWallAdminServices = angular.module('SGWallAdmin.services', [])
    .value('ROOT', '/bank_wall/api')
    .value('ROOT_FOLDER', '/bank_wall/api/')
	.value('ASSET_FOLDER', '/bank_wall/api/admin_asset/');
