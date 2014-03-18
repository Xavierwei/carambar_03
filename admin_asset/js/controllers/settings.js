SGWallAdminController
    .controller('SettingsCtrList', function($scope, $http, $modal, $log, $routeParams, SettingsService, $filter,ASSET_FOLDER) {
        $scope.saved = false;
		$scope.phaseList = [
			{phase:'1'},
			{phase:'2'},
			{phase:'3'},
			{phase:'4'},
			{phase:'5'}
		];


		SettingsService.getSetting({'key':'phase'}, function(data){
			$scope.phaseValue = $scope.phaseList[data-1];
		});

        SettingsService.getSetting({'key':'answer'}, function(data){
            $scope.answerValue = data;
        });

		SettingsService.getSetting({'key':'countdown'}, function(data){
			$scope.countdownValue = $filter('date')(data*1000, 'MMM d, y HH:mm a');
		});

        $scope.save = function(key, value){
			if(key == 'countdown') {
				value = new Date(value).getTime()/1000;
			}
			if(key == 'phase') {
				value = value.phase;
			}
            SettingsService.setSetting({'key':key, 'value':value}, function(data){
				if(data.success) {
					$scope[key+'Saved'] = true;
				}
			});

        }
    })


