<?php
class TwitterController extends Controller {

	const MEDIA = 'twitter';

	/**
	 * Get Instagram login URL
	 */
	public function actionLogin() {
		if(!isset(Yii::app()->session['oauth_token'])) {
			$twitter = new TwitterOAuth(TWITTER_AKEY, TWITTER_SKEY);
			$temporary_credentials = $twitter->getRequestToken(TWITTER_CALLBACK_URL);
			Yii::app()->session['tmp_oauth_token'] = $temporary_credentials['oauth_token'];
			Yii::app()->session['tmp_oauth_token_secret'] = $temporary_credentials['oauth_token_secret'];
			$redirect_url = $twitter->getAuthorizeURL($temporary_credentials);
			return $this->responseJSON($redirect_url, "success");
		}
		else {
			return $this->responseJSON('login', "success");
		}
	}


	/**
	 * Store the account OAuthToken
	 */
	public function actionCallback() {
		$twitter = new TwitterOAuth(TWITTER_AKEY, TWITTER_SKEY, Yii::app()->session['tmp_oauth_token'], Yii::app()->session['tmp_oauth_token_secret']);
		$token_credentials = $twitter->getAccessToken($_REQUEST['oauth_verifier']);
		// if the account is in oauth table, update the token
		$oauth = OauthAR::model()->findByAttributes(array('media'=>$this::MEDIA, 'username'=>$token_credentials['screen_name']));
		if($oauth) {
			$oauth->media = $this::MEDIA;
			$oauth->username = $token_credentials['screen_name'];
			$oauth->token = $token_credentials['oauth_token'];
			$oauth->token_secret = $token_credentials['oauth_token_secret'];
			$oauth->save();
		}
		Yii::app()->session['oauth_token'] = $token_credentials['oauth_token'];
		Yii::app()->session['oauth_token_secret'] = $token_credentials['oauth_token_secret'];


		// Create the new user if user doesn't exist in database
		if( !$user = UserAR::model()->findByAttributes(array('name'=>'t_'.$token_credentials['screen_name'])) ) {
			$user = UserAR::model()->createSNSLogin('t_'.$token_credentials['screen_name'], $token_credentials['user_id']);
		}

		// Identity local site user data
		$userIdentify = new UserIdentity($user->name, md5($token_credentials['user_id']));

		// Save user status in session
		if (!$userIdentify->authenticate()) {
		}
		else {
			Yii::app()->user->login($userIdentify);
			$this->redirect('../index');
		}
	}


	/**
	 * Fetch the media
	 */
	public function actionFetch(){
		$oauth = OauthAR::model()->findByAttributes(array('media'=>$this::MEDIA));
		$oauth_token = $oauth->token;
		$oauth_token_secret = $oauth->token_secret;
		$twitter = new TwitterOAuth(TWITTER_AKEY, TWITTER_SKEY, $oauth_token, $oauth_token_secret);
		$results = $twitter->get('search/tweets', array('q'=>Yii::app()->params['tag'], 'count'=>50, 'result_type'=>'recent'));

		foreach($results->statuses as $item) {
			$snsVideoLink = $snsPicture = $snsDatetime = $snsDescription = $snsId = $snsLocation = $snsScreenName = NULL;
			if(isset($item->entities->urls[0]->expanded_url)) {
				$snsVideoLink = $item->entities->urls[0]->expanded_url;
			}

			if(isset($item->entities->media[0]->media_url)) {
				$snsPicture =$item->entities->media[0]->media_url;
			}

			if(isset($item->created_at)) {
				$snsDatetime = strtotime($item->created_at);
			}

			if(isset($item->text)) {
				$snsDescription = $item->text;
			}

			if(isset($item->id)) {
				$snsId = $item->id;
			}

			if(isset($item->user->location)) {
				$snsLocation = $item->user->location;
			}

			if(isset($item->user->screen_name)) {
				$snsScreenName = $item->user->screen_name;
			}

			if(NodeAR::model()->uniqueMid($snsId)) {
				NodeAR::model()->saveNode($snsVideoLink, $snsPicture, $snsDatetime, $snsDescription, $snsId, $snsScreenName, $snsLocation, $this::MEDIA);
			}
		}
		$this->cleanAllCache();
	}


	public function actionCheckVideo(){
		$url = 'https://www.youtube.com/watch?v=iQQ35CiF1vk&feature=youtu.be';
		$media = NodeAR::model()->getVideoSource($url);
		print $media;
	}

	public function actionGetThumbnail(){
		$url = 'https://www.youtube.com/watch?v=iQQ35CiF1vk&feature=youtu.be';
		$media = NodeAR::model()->getVideoThumbnail($url, 'youtube');
		print $media;
	}


	/**
	 * POST twitter
	 */
	public function actionPost(){
		$request = Yii::app()->getRequest();
		$content = htmlspecialchars($request->getPost("content"));
		if(strlen($content) == 0) {
			return $this->responseError(702);
		}

		if(strlen($content) > 140) {
			return $this->responseError(703);
		}

		$oauth_token = Yii::app()->session['oauth_token'];
		$oauth_token_secret = Yii::app()->session['oauth_token_secret'];
		$twitter = new TwitterOAuth(TWITTER_AKEY, TWITTER_SKEY, $oauth_token, $oauth_token_secret);
		$results = $twitter->post('statuses/update', array('status'=>$content));

		return $this->responseJSON($results, "success");
	}


}