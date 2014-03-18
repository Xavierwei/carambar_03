SGWallAdminController
    .controller('VideoCtrList', function($scope, $http, $modal, $log, $routeParams,VideoService, NodeService, LikeService, FlagService, ASSET_FOLDER) {
		VideoService.list(function(data){
			$scope.videos = data.data;
		});

    })



