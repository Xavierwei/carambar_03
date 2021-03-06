WallAdminServices.factory( 'NodeService', function($http, ROOT) {
    return {
        list: function(param, success) {
            $http.get(ROOT+'/node/list',{
				params: param,
				cache: false
			})
            .success(function(data) {
                success(data);
            })
            .error(function() {
            });
        },

        getFlaggedNodes: function(param, success) {
            $http.get(ROOT+'/flag/getFlaggedNodes',{
                params: param,
                cache: false
            })
            .success(function(data) {
                success(data.data);
            })
            .error(function() {
            });
        },


        getById: function(nid, success) {
            $http.get(ROOT+'/node/getById?nid='+nid)
                .success(function(data) {
                    success(data.data);
                })
                .error(function() {
                });
        },

        update: function(node, success) {
            $http.post(ROOT+'/node/put',node)
            .success(function(data) {
                if(data.success == true) {
                    success();
                }
            })
            .error(function() {

            });
        },
        cropPhoto: function( param , success ){
            $http.post(ROOT+'/node/crop',param)
                .success(function(data) {
                    if(data.success == true) {
                        success(data.data);
                    }
                })
                .error(function() {

                });
        },

		reward: function(node, success) {
			$http.post(ROOT+'/node/reward',node)
				.success(function(data) {
					if(data.success == true) {
						success();
					}
				})
				.error(function() {

				});
		}
    };
});
