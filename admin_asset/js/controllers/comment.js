SGWallAdminController
    .controller('CommentCtrList', function($scope, CommentService, $routeParams, $modal ,ASSET_FOLDER, $log, FlagService) {
        var params = {};
        var flagged = $routeParams.flagged;
        if(flagged) {
            params.flagged = true;
        }
        else {
            delete params.flagged;
        }
		$scope.hideList = '';
		$scope.noResult = false;
        $scope.end = true;
        $scope.filter.status = 'all';
		$scope.page = 1;
        params.shownode = true;
        params.showall = true;
        params.order = 'DESC';
		params.pagenum = 16;
        params.cache = new Date().getTime();

        // paging
        $scope.noOfPages = 0;
        $scope.currentPage = 1;
        $scope.itemsPerPage = 20;
        $scope.maxSize = 5;
        $scope.numPages = 20;

        $scope.$watch('filter.status', function() {
            $scope.currentPage = 1;
            $('.pagination li').removeClass('active');
            $('.pagination li').eq(2).addClass('active');
        });

        $scope.$watch('filter.status + currentPage', function() {
            if($scope.filter.status != 'all') {
                params.status = $scope.filter.status;
                delete params.showall;
            }
            else {
                params.showall = true;
                delete params.status;
            }

            params.page = $scope.currentPage;
            params.cache = new Date().getTime();
			loadComment(params);
        });

        $scope.pageChanged = function(page){
            $scope.currentPage = page;
        }


        $scope.search = function() {
            if($scope.filter.status != 'all') {
                params.status = $scope.filter.status;
            }
            else {
                delete params.status;
            }
            params.keyword = $scope.filter.keyword;
            params.email = $scope.filter.email;
            $scope.page = 1;
            params.page = $scope.page;
            loadComment(params);
        }

        // Switch node status
        $scope.updateStatus = function(comment) {
            if($routeParams.flagged) {
                if(comment.status == 0) {
                    var modalInstance = $modal.open({
                        templateUrl: ASSET_FOLDER + 'tmp/dialog/unflag.html',
                        controller: ConfirmModalCtrl
                    });
                    modalInstance.result.then(function () {
                        var newComment = angular.copy(comment);
                        if(comment.status == 0) {
                            newComment.status = 1;
                        }
                        else {
                            newComment.status = 0;
                        }
                        CommentService.update(newComment,function(){
                            comment.status = newComment.status;
                            comment.flagcount = 0;
                        });
                    }, function () {
                    });
                }
                else {
                    var newComment = angular.copy(comment);
                    if(comment.status == 0) {
                        newComment.status = 1;
                    }
                    else {
                        newComment.status = 0;
                    }
                    CommentService.update(newComment,function(){
                        comment.status = newComment.status;
                    });
                }
            }

            else {
                var newComment = angular.copy(comment);
                if(comment.status == 0) {
                    newComment.status = 1;
                }
                else {
                    newComment.status = 0;
                }
                CommentService.update(newComment,function(data){
                    comment.status = newComment.status;
                });
            }

        }


		$scope.nextPage = function() {
			$scope.page ++;
			$scope.first = false;
		}

		$scope.prevPage = function() {
			$scope.page --;
			$scope.end = false;
		}


		function loadComment(params) {
			$scope.hideList = 'hide-list';
			CommentService.list(params, function(data){
                $scope.bigTotalItems = parseInt(data.message.total);
                if($scope.currentPage == 1) {
                    setTimeout(function(){
                        $('.pagination li').removeClass('active');
                        $('.pagination li').eq(2).addClass('active');
                    }, 1000);
                }
				$scope.hideList = '';
				if(data.data.length == 0) {
					$scope.noResult = true;
				}
				else {
					$scope.noResult = false;
				}
				$scope.comments = data.data;
			});
		}

        $scope.reset = function() {
            $scope.filter.status = 'all';
            $scope.filter.keyword = '';
            $scope.filter.email = '';
        }
    })




