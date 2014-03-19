SGWallAdminController
    .controller('VideoCtrList', function($scope, $http, $modal, $log, $routeParams,VideoService, NodeService, LikeService, FlagService, ASSET_FOLDER) {
		VideoService.list(function(data){
			$scope.videos = data.data;
		});

        // Delete node
        $scope.delete = function(video) {
            var modalInstance = $modal.open({
                templateUrl: ASSET_FOLDER+'tmp/dialog/delete.html',
                controller: ConfirmModalCtrl
            });

            modalInstance.result.then(function () {
                $scope.videos.splice($scope.videos.indexOf(video), 1);
                VideoService.update({vid:video.vid, status:0});
            }, function () {
            });

        }

    })

    .controller('VideoCtrCreate', function($scope, $http, $modal, $log, $routeParams,VideoService, NodeService, LikeService, FlagService, ASSET_FOLDER) {
        $scope.save = function(video) {
            VideoService.post(video, function(data){
            console.log(data);
            });
        }
    })

    .controller('VideoCtrEdit', function($scope, $http, $modal, $log, $routeParams,VideoService, NodeService, LikeService, FlagService, ASSET_FOLDER) {
		VideoService.getById($routeParams.vid, function(data){
			$scope.video = data.data;
		});

		$scope.save = function(video) {
			VideoService.update(video, function(data){
				console.log(data);
			});
		}
	})


	.controller('VideoCtrPhase', function($scope, $http, $modal, $log, $routeParams,VideoService, NodeService, LikeService, FlagService, ASSET_FOLDER) {
		VideoService.list(function(data){
			$scope.videos = data.data;
		});

		$scope.save = function(video) {
			VideoService.update(video, function(data){
				console.log(data);
			});
		}
	})



