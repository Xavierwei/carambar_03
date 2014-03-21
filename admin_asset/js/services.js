'use strict';

/* Services */


// Demonstrate how to register services
// In this case it is a simple value service.
var WallAdminServices = angular.module('WallAdmin.services', [])
    .value('ROOT', '/carambar')
    .value('ROOT_FOLDER', '/carambar/')
	.value('ASSET_FOLDER', '/carambar/admin_asset/');
