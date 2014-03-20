WallAdminServices.factory( 'StatisticsService', function($http, ROOT) {
    return {
		getChallengeList: function(success) {
            $http.get(ROOT+'/challenge/list',{
				cache: false
			})
            .success(function(data) {
                success(data.data);
            })
            .error(function() {
            });
        },

        getGoodluckCount: function(success) {
            $http.get(ROOT+'/setting/count',{
                cache: false
            })
            .success(function(data) {
                success(data.data);
            })
            .error(function() {
            });
        }
    };
});
