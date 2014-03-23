WallAdminController
    .controller('VideoCtrList', function($scope, $http, $modal, $log, $routeParams,VideoService, NodeService,  ASSET_FOLDER) {
		VideoService.list({},function(data){
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
                VideoService.delete({vid:video.vid});
            }, function () {
            });

        }

    })

    .controller('VideoCtrCreate', function($scope, $http, $modal, $log, $routeParams,VideoService, $location, ASSET_FOLDER) {
        $scope.save = function(video) {
            VideoService.post(video, function(data){
				$location.path("video");
            });
        }
    })

    .controller('VideoCtrEdit', function($scope, $http, $modal, $log, $routeParams,VideoService, $location,  ASSET_FOLDER) {
		VideoService.getById($routeParams.vid, function(data){
			$scope.video = data.data;
		});

		$scope.save = function(video) {
            video.del = 0;
			VideoService.update(video, function(data){
                $location.path("video");
			});
		}
	})


	.controller('VideoCtrPhase', function($scope, $http, $modal, $log, $routeParams,VideoService, ASSET_FOLDER) {
        $scope.phase = $routeParams.phaseid;

		$scope.videoranks = [
			{'title':1},
			{'title':2},
			{'title':3},
			{'title':4},
			{'title':5},
			{'title':6}
		];

		VideoService.list({phase:$routeParams.phaseid},function(data){
			if(data.data) {
				$scope.videos = data.data;
				angular.forEach($scope.videos, function(item, key){
					item.rank = $scope.videoranks[item.rank-1];
				});
			}
			else {
				$scope.videos = [];
			}

		});

        VideoService.list({},function(data){
            $scope.allvideos = data.data;
        });

		$scope.saveRank = function(video) {
			video.del = 0;
			video.rank = video.rank.title;
			VideoService.update(video, function(data){
				video.rank = $scope.videoranks[video.rank-1];
			});
		}

		$scope.save = function(video) {
			$scope.errorDuplicate = false;
            if(!video) {
                return;
            }
			// check duplicate
			angular.forEach($scope.videos, function(item, key){
				if(item.vid == video.vid) {
					$scope.errorDuplicate = true;
					return;
				}
			});
			if($scope.errorDuplicate) {
				return;
			}

			// check max video section
			var videoSectionCount = 0;
			angular.forEach($scope.videos, function(item, key){
				if(item.position == 2) {
					videoSectionCount ++;
				}
			});
			if(videoSectionCount >= 6) {
				$scope.errorMaxVideoSection = true;
				return;
			}
            video.phase = $routeParams.phaseid;
            video.del = 0;
			VideoService.update(video, function(data){
				video.rank = $scope.videoranks[video.rank-1];
                $scope.videos.push(video);
			});
		}

        $scope.remove = function(video) {
			var data = {};
			data.phase = $routeParams.phaseid;
			data.del = 1;
			data.vid = video.vid;
			VideoService.update(data, function(data){
                $scope.videos.splice($scope.videos.indexOf(video), 1);
            });
        }
	})



