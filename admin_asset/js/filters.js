'use strict';

/* Filters */

angular.module('WallAdmin.filters', [])
    .filter('interpolate', ['version', function(version) {
    return function(text) {
        return String(text).replace(/\%VERSION\%/mg, version);
    }
    }])
    .filter('nodeStatus', function() {
        return function(input) {
            var output;
            switch(input) {
                case '1':
                    output = 'Published';
                    break;
                case '2':
                    output = 'Unpublished';
                    break;
                case '3':
                    output = 'Blocked';
                    break;
            }
            return output;
        }
    })
    .filter('thumbnail', function(ROOT_FOLDER) {
        return function(input) {
			if(!input) return;
            var output = input;
            if(input.indexOf('mp4') > 0) {
                output = input.replace('.mp4','_400_400.jpg');
            }
            else {
                output = input.replace('.jpg','_400_400.jpg');
            }
            return ROOT_FOLDER + output;
        }
    })
    .filter('originPhoto' , function(ROOT_FOLDER){
        return function(input) {
            return ROOT_FOLDER + input;
        }
    })
    .filter('isset' , function(){
        return function(input) {
            if(input) {
                return true;
            }
            else {
                return false;
            }
        }
    })

	.filter('avatar', function(ROOT_FOLDER) {
		return function(input) {
			if(input) {
				return ROOT_FOLDER + input;
			}
			else {
				return ROOT_FOLDER + '/admin_asset/img/login_avatar.gif';
			}
		}
	})
    .filter('ribbon', function() {
        return function(input) {
            switch(input) {
                case '1':
                    return 'PRESQUE';
                    break;
                case '2':
                    return 'ON L\'A FAIT!';
                    break;
                default:
                    return 'None';
            }

        }
    })
	.filter('videoposition', function() {
		return function(input) {
			switch(input) {
				case '1':
					return 'Top';
					break;
				case '2':
					return 'Video Section';
					break;
			}

		}
	})
    .filter('showtop', function() {
        return function(input) {
            switch(input) {
                case '1':
                    return 'Yes';
                    break;
            }

        }
    })
    .filter('challengeimg', function(ROOT_FOLDER) {
        return function(input) {
            return ROOT_FOLDER + 'pic/challenge' + input + '.jpg';
        }
    })
    .filter('medialink', function() {
        return function(input) {
            switch(input.media) {
                case 'instagram':
                    return input.link;
                    break;
                case 'twitter':
                    return 'https://twitter.com/'+input.screen_name+'/statuses/'+input.mid;
                    break;
                case 'facebook':
                    return 'https://www.facebook.com/'+input.screen_name;
                    break;
            }


        }
    });

