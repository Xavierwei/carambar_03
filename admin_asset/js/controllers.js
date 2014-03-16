'use strict';

/* Controllers */

var SGWallAdminController = angular.module('SGWallAdmin.controllers', []);

SGWallAdminController
	.controller('CtrGlobal', function($scope, $http, $modal, $log, $routeParams, UserService, NodeService, LikeService, FlagService, ASSET_FOLDER) {
		$scope.filter = {};
		$scope.filter.type = 'all';

        UserService.countryList(function(data){
            $scope.countries = data;
        });

	})