SGWallAdminController
    .controller('SettingsCtrList', function($scope, $http, $modal, $log, $routeParams, SettingsService, ASSET_FOLDER) {
        $scope.saved = false;
        SettingsService.getFlagValue(function(data){
            $scope.flagValue = data;
        });

        $scope.save = function(){
            SettingsService.setFlagValue({'value': $scope.flagValue});
            $scope.saved = true;
        }
    })


