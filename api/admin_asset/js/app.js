'use strict';


// Declare app level module which depends on filters, and services
var SGWallAdmin = angular.module('SGWallAdmin', [
  'ui.bootstrap',
  'ngRoute',
  'SGWallAdmin.filters',
  'SGWallAdmin.services',
  'myApp.directives',
  'SGWallAdmin.controllers'
]).
config(function($routeProvider,$httpProvider) {
	var ROOT = '/bank_wall/api/admin_asset/';
    $routeProvider.when('/node', {templateUrl: ROOT +'tmp/node/list.html', controller: 'NodeCtrList'});
    $routeProvider.when('/node/:flagged', {templateUrl: ROOT +'tmp/node/list.html', controller: 'NodeCtrList'});
    $routeProvider.when('/comment', {templateUrl: ROOT +'tmp/comment/list.html', controller: 'CommentCtrList'});
    $routeProvider.when('/settings', {templateUrl: ROOT +'tmp/settings/list.html', controller: 'SettingsCtrList'});
    $routeProvider.when('/comment/:flagged', {templateUrl: ROOT +'tmp/comment/list.html', controller: 'CommentCtrList'});
    $routeProvider.otherwise({redirectTo: '/node'});

    $httpProvider.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";
    $httpProvider.defaults.transformRequest = [function(data)
    {
        var param = function(obj)
        {
            var query = '';
            var name, value, fullSubName, subName, subValue, innerObj, i;

            for(name in obj)
            {
                value = obj[name];

                if(value instanceof Array)
                {
                    for(i=0; i<value.length; ++i)
                    {
                        subValue = value[i];
                        fullSubName = name + '[' + i + ']';
                        innerObj = {};
                        innerObj[fullSubName] = subValue;
                        query += param(innerObj) + '&';
                    }
                }
                else if(value instanceof Object)
                {
                    for(subName in value)
                    {
                        subValue = value[subName];
                        fullSubName = name + '[' + subName + ']';
                        innerObj = {};
                        innerObj[fullSubName] = subValue;
                        query += param(innerObj) + '&';
                    }
                }
                else if(value !== undefined && value !== null)
                {
                    query += encodeURIComponent(name) + '=' + encodeURIComponent(value) + '&';
                }
            }

            return query.length ? query.substr(0, query.length - 1) : query;
        };

        return angular.isObject(data) && String(data) !== '[object File]' ? param(data) : data;
    }];
});

