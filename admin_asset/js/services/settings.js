SGWallAdminServices.factory( 'SettingsService', function($http, ROOT) {
    return {
        getFlagValue: function(success) {
            $http.get(ROOT+'/flag/getSetting',{
				cache: false
			})
            .success(function(data) {
                success(data);
            })
            .error(function() {
            });
        },

        setFlagValue: function(param) {
            $http.post(ROOT+'/flag/setSetting', param)
            .success(function() {
            })
            .error(function() {

            });
        }
    };
});
