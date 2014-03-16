SGWallAdminController
    .controller('NodeCtrList', function($scope, $http, $modal, $log, $routeParams, NodeService, LikeService, FlagService, ASSET_FOLDER) {
        var params = {};
        var flagged = $routeParams.flagged;
        var prevbigTotalItems = 0;
        if(flagged) {
            params.flagged = true;
        }
        else {
            delete params.flagged;
        }
		$scope.hideList = '';
		$scope.noResult = false;
        $scope.end = true;
        // Get node list by recent
        $scope.filter.status = 'all';
        $scope.filter.country = {};
        $scope.filter.country.country_name = 'All Country';
		$scope.page = 1;
		params.orderby = "datetime";
		params.pagenum = 20;
        params.cache = new Date().getTime();

        // paging
        $scope.noOfPages = 0;
        $scope.currentPage = 1;
        $scope.itemsPerPage = 20;
        $scope.maxSize = 5;
        $scope.numPages = 20;

        $scope.$watch('filter.type + filter.country_id + filter.status + filter.country.country_id', function() {
            $scope.currentPage = 1;
            $('.pagination li').removeClass('active');
            $('.pagination li').eq(2).addClass('active');
        });

		$scope.$watch('filter.type + filter.country_id + filter.status + filter.country.country_id + currentPage', function() {
            params.type = $scope.filter.type;
			if($scope.filter.type == 'all') {
				delete params.type;
			}

            if($scope.filter.status != 'all') {
                params.status = $scope.filter.status;
            }
            else {
                delete params.status;
            }

            params.country_id = $scope.filter.country.country_id;

			if($scope.filter.status != undefined) {
				params.status = $scope.filter.status;
			}

			params.page = $scope.currentPage;
            params.cache = new Date().getTime();
			loadNodes(params);
		});


        $scope.pageChanged = function(page){
            $scope.currentPage = page;
        }
//		$scope.$watch('currentPage', function() {
//			params.page = $scope.page;
//			if($scope.page == 1) {
//				$scope.first = true;
//			}
//            params.cache = new Date().getTime();
//			loadNodes(params);
//		});


        // Switch node status
        $scope.updateStatus = function(node, status) {
            if($routeParams.flagged) {
                if(node.status == 0) {
                    var modalInstance = $modal.open({
                        templateUrl: ASSET_FOLDER + 'tmp/dialog/unflag.html',
                        controller: ConfirmModalCtrl
                    });
                    modalInstance.result.then(function () {
                        var newNode = angular.copy(node);
                        if(node.status == 0) {
                            newNode.status = 1;
                        }
                        else {
                            newNode.status = 0;
                        }
                        NodeService.update(newNode,function(){
                            node.status = newNode.status;
                            node.flagcount = 0;
                        });
                    }, function () {
                    });
                }
                else {
                    var newNode = angular.copy(node);
                    if(node.status == 0) {
                        newNode.status = 1;
                    }
                    else {
                        newNode.status = 0;
                    }
                    node.itemLoading = true;
                    NodeService.update(newNode,function(){
                        node.itemLoading = false;
                        node.status = newNode.status;
                    });
                }
            }
            else {
                var newNode = angular.copy(node);
                if(node.status == 0) {
                    newNode.status = 1;
                }
                else {
                    newNode.status = 0;
                }
                node.itemLoading = true;
                NodeService.update(newNode,function(data){
                    node.itemLoading = false;
                    node.status = newNode.status;
                });
            }
        }


        $scope.search = function() {
            if($scope.filter.status != 'all') {
                params.status = $scope.filter.status;
            }
            else {
                delete params.status;
            }
            params.hashtag = $scope.filter.hashtag.replace('#','');
			params.email = $scope.filter.email;
			$scope.page = 1;
			params.page = $scope.page;
			loadNodes(params);
        }


        $scope.filterCountry = function(country) {
            $scope.filter.country = country;
        }

		$scope.reset = function() {
			$scope.filter.type = 'all';
			$scope.filter.status = 'all';
			$scope.filter.hashtag = '';
			$scope.filter.email = '';
			$scope.filter.country = {country_name:'All Country', country_id:''};
		}



		function loadNodes(params) {
			$scope.hideList = 'hide-list';
			NodeService.list(params, function(data){
                $scope.bigTotalItems = parseInt(data.message.total);
                if($scope.currentPage == 1) {
                    setTimeout(function(){
                        $('.pagination li').removeClass('active');
                        $('.pagination li').eq(2).addClass('active');
                    }, 1000);
                }
				$scope.hideList = '';
				if (data.data.length == 0 && $scope.currentPage == 1) {
					$scope.noResult = true;
				}
				else {
					$scope.noResult = false;
				}
				$scope.nodes = data.data;
			});
		}

    })



