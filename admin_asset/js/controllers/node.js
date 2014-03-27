WallAdminController
    .controller('NodeCtrList', function($scope, $http, $modal, $log, $routeParams, NodeService, ASSET_FOLDER) {
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
        $scope.filter.reward = 'all';
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

		$scope.$watch('filter.type + filter.status + filter.reward + currentPage', function() {
            params.type = $scope.filter.type;
            params.reward = $scope.filter.reward;
			if($scope.filter.type == 'all') {
				delete params.type;
			}
            if($scope.filter.reward == 'all') {
                delete params.reward;
            }
            if($scope.filter.status != 'all') {
                params.status = $scope.filter.status;
            }
            else {
                delete params.status;
            }


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

		$scope.updateReward = function(node, status) {
			var newNode = angular.copy(node);
			if(node.reward == 0) {
				newNode.reward = 1;
			}
			else {
				newNode.reward = 0;
			}
			node.itemLoading = true;
			NodeService.reward(newNode,function(data){
				node.itemLoading = false;
				node.reward = newNode.reward;
			});
		}


        $scope.search = function() {
            params.status = $scope.filter.status;
			params.email = $scope.filter.email;
            params.name = $scope.filter.name;
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
			$scope.filter.email = '';
            $scope.filter.name = '';
		}

        $scope.delete = function() {
            angular.forEach($scope.nodes, function(node, key){
                if(node.del) {
                    var newNode = angular.copy(node);
                    newNode.status = 2;
                    node.itemLoading = true;
                    NodeService.update(newNode,function(){
                        node.itemLoading = false;
                        $scope.nodes.splice($scope.nodes.indexOf(node), 1);
                    });
                }
            });

        }

        $scope.editPhoto = function(node){
            var modalInstance = $modal.open({
                templateUrl: ASSET_FOLDER + '/tmp/node/photo-edit.html',
                controller: function ($scope, $modalInstance) {
                    $scope.node = node;

                    $scope.submit = function () {
                        var param = transformMgr.result();
                        param.path = node.file;
                        param.nid = node.nid;
                        param.size = 200;
                        NodeService.cropPhoto( param , function( data ){
                            node.file = data.file + '?_t=' + new Date().getTime();
                            $modalInstance.dismiss('cancel');
                        } );
                    }
                    $scope.cancel = function () {
                        $modalInstance.dismiss('cancel');
                    }
                }
            });

            modalInstance.result.then(function () {
                $scope.users.splice($scope.users.indexOf(user), 1);
                UserService.delete(user);
                $log.info('Modal confirmed at: ' + new Date());
            }, function () {
                $log.info('Modal dismissed at: ' + new Date());
            });
            //transformMgr.
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



