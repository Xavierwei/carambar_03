SGWallAdminServices.factory( 'VideoService', function($http, ROOT) {
    return {
        post: function(video, success) {
            $http.post(ROOT+'/video/create',video)
            .success(function(data) {
                success(data);
            })
            .error(function() {

            });
        },

        'delete': function(type, id, success) {
            if(type == 'node') {
                $http.post(ROOT+'/flag/deleteAll',{nid:id})
                .success(function(data) {
                    success(data);
                })
                .error(function() {

                });
            }
            else {
                $http.post(ROOT+'/flag/deleteAll',{cid:id})
                .success(function(data) {
                    success(data);
                })
                .error(function() {

                });
            }
        },

		list: function(success) {
			$http.get(ROOT+'/video/list',{
				cache: false
			})
				.success(function(data) {
					success(data);
				})
				.error(function() {
				});
		}


    };
});