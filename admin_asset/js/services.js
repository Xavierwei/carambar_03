'use strict';

/* Services */


// Demonstrate how to register services
// In this case it is a simple value service.
var WallAdminServices = angular.module('WallAdmin.services', [])
    .value('ROOT', '/carambar_03')
    .value('ROOT_FOLDER', '/carambar_03/')
	.value('ASSET_FOLDER', '/carambar_03/admin_asset/');
