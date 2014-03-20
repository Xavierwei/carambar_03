SGWallAdminController
    .controller('StatisticsCtrList', function($scope, $http, $modal, $log, $routeParams, StatisticsService, $filter,ASSET_FOLDER) {
        StatisticsService.getChallengeList(function(data){
            $scope.challenges = data;
        });

        StatisticsService.getGoodluckCount(function(data){
            $scope.goodluck = data;
        });
    })


