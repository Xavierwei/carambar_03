SGWallAdminController
    .controller('UserCtrList', function($scope, UserService, $modal, $log) {
        UserService.list(function(data){
            $scope.users = data;
        });

        $scope.switchStatus = function(uid) {
            alert(uid);
        }

        // Delete node
        $scope.delete = function(user) {
            var modalInstance = $modal.open({
                templateUrl: 'tmp/dialog/delete.html',
                controller: ConfirmModalCtrl
            });

            modalInstance.result.then(function () {
                $scope.users.splice($scope.users.indexOf(user), 1);
                UserService.delete(user);
                $log.info('Modal confirmed at: ' + new Date());
            }, function () {
                $log.info('Modal dismissed at: ' + new Date());
            });

        }
    })

    .controller('UserCtrEdit', function($scope, $http, $routeParams, UserService) {
        UserService.getByUid($routeParams.uid, function(data) {
            $scope.user = data;
        });

        // Update node
        $scope.update = function(user) {
            delete user.country;
            delete user.company_email;
            UserService.update(user, function(data) {
                console.log(data);
            });
        }

        // Delete node
        $scope.delete = function(user) {
            UserService.delete(user, function(data) {
                console.log(data);
            });
        }
    })

    .controller('UserCtrCreate', function($scope, UserService) {
        // save user
        $scope.save = function(user) {
            UserService.save(user);
        }
    })

    .controller('UserCtrCurrent', function($scope, UserService) {
        // get current user
        UserService.getCurrentUser(function(data){
            $scope.user = data;
        });
    })

    .controller('UserCtrLogin', function($scope, UserService, $location) {
        // login
        $scope.login = function(user) {
            UserService.login(user,function(){
                console.log('logined');
                $location.path('/node');
            });
        }
    })

    .controller('UserCtrLogout', function($scope, UserService, $location) {
        // login
        UserService.logout();
    })

    .controller('UserCtrInfo', function($scope, $http, UserService) {
        // login
        $scope.user = UserService.info();
    })