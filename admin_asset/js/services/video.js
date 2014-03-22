WallAdminServices.factory( 'VideoService', function($http, ROOT) {
    return {
        post: function(video, success) {
            $http.post(ROOT+'/video/create',video)
            .success(function(data) {
                success(data);
            })
            .error(function() {

            });
        },

        update: function(video, success) {
            $http.post(ROOT+'/video/update',video)
                .success(function(data) {
                    success(data);
                })
                .error(function() {

                });
        },

        'delete': function( id, success) {
            $http.post(ROOT+'/video/delete',{vid:id})
            .success(function(data) {
                success(data);
            })
            .error(function() {

            });
        },

		list: function(params, success) {
            params._t = new Date().getTime();
			$http.get(ROOT+'/video/list',{
				cache: false,
                params: params
			})
            .success(function(data) {
                success(data);
            })
            .error(function() {
            });
		},

        getById: function(vid, success) {
            console.log(vid);
            $http.get(ROOT+'/video/view',{
                cache: false,
                params: {vid: vid}
            })
            .success(function(data) {
                success(data);
            })
            .error(function() {
            });
        }


    };
});