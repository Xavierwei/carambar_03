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

        update: function(video, success) {
            $http.post(ROOT+'/video/update',video)
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