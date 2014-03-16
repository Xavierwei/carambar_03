SGWallAdminServices.factory( 'UserService', function($http, ROOT) {
    var currentUser, isLoggedin;
    return {
        login: function(user, success) {
            $http.post(ROOT+'/user/login',{company_email:user.company_email, password:user.password})
            .success(function(data) {
                currentUser = data.data;
                success();
            })
            .error(function() {
            });
        },

        logout: function(success) {
            $http.get(ROOT+'/user/logout')
            .success(function(data) {
                currentUser = data.data;
                success(data.data);
            })
        },

        getCurrentUser: function(success) {
            if(!currentUser) {
                $http.get(ROOT+'/user/getcurrent')
                .success(function(data) {
                    currentUser = data.data;
                    success(data.data);
                })
            } else {
                success(currentUser);
            }
        },

        getByUid: function(uid, success) {
            $http.get(ROOT+'/user/getbyuid?uid='+uid)
            .success(function(data) {
                success(data.data);
            })
        },

        list: function(success) {
            $http.get(ROOT+'/user/list?orderby=datetime')
            .success(function(data) {
                success(data.data);
            })
            .error(function() {

            });
        },

        save: function(user) {
            $http.post(ROOT+'/user/post',user)
            .success(function(data) {
                console.log(data);
            })
            .error(function() {

            });
        },

        update: function(user) {
            $http.post(ROOT+'/user/put',user)
            .success(function(data) {
                console.log(data);
            })
            .error(function() {

            });
        },

        countryList: function(success){
            $http.get(ROOT+'/../json/country.json')
            .success(function(data) {
                success(data);
            })
            .error(function() {

            });
        }
    };
});
