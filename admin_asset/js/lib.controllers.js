var StatusDropdownCtrl = function ($scope) {
    $scope.items = ['1','2','3'];
}

var ConfirmModalCtrl = function ($scope, $modalInstance) {
    $scope.ok = function () {
        $modalInstance.close(true);
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
};