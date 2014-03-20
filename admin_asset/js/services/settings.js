WallAdminServices.factory( 'SettingsService', function($http, ROOT) {
    return {
		getSetting: function(param, success) {
            $http.get(ROOT+'/setting/getSetting',{
				params: param,
				cache: false
			})
            .success(function(data) {
                success(data.data);
            })
            .error(function() {
            });
        },

		setSetting: function(param, success) {
            $http.post(ROOT+'/setting/setSetting', param)
            .success(function(data) {
				success(data);
            })
            .error(function() {

            });
        }
    };
});
