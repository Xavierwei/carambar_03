'use strict';

/* Controllers */

var WallAdminController = angular.module('WallAdmin.controllers', []);

WallAdminController
	.controller('CtrGlobal', function($scope, $http, $modal, $log, $routeParams, NodeService,  ASSET_FOLDER) {
		$scope.filter = {};
		$scope.filter.type = 'all';

        // UserService.countryList(function(data){
        //     $scope.countries = data;
        // });

	})