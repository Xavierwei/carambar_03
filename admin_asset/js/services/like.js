SGWallAdminServices.factory( 'LikeService', function($http, ROOT) {
    return {
        post: function(nid, success) {
            $http.post(ROOT+'/like/post',{nid:nid})
            .success(function(data) {
                success(data);
            })
            .error(function() {

            });
        }
    };
});
