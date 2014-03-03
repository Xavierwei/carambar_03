<?php
class TwitterController extends Controller {

	const MEDIA = 'twitter';

	/**
	 * Get Instagram login URL
	 */
	public function actionLogin() {
		$twitter = new TwitterOAuth(TWITTER_AKEY, TWITTER_SKEY);
		$temporary_credentials = $twitter->getRequestToken(TWITTER_CALLBACK_URL);
		$_SESSION['oauth_token'] = $temporary_credentials['oauth_token'];
		$_SESSION['oauth_token_secret'] = $temporary_credentials['oauth_token_secret'];
		$redirect_url = $this->twitter->getAuthorizeURL($temporary_credentials);
		echo "<a href='{$redirect_url}'>Login with Twitter</a>";
	}


	/**
	 * Store the account OAuthToken
	 */
	public function actionCallback() {
		$twitter = new TwitterOAuth(TWITTER_AKEY, TWITTER_SKEY, $_SESSION['oauth_token'],$_SESSION['oauth_token_secret']);
		$token_credentials = $twitter->getAccessToken($_REQUEST['oauth_verifier']);
		$oauth = OauthAR::model()->findByAttributes(array('media'=>$this::MEDIA));
		if(!$oauth) {
			$oauth = new OauthAR();
		}
		$oauth->media = $this::MEDIA;
		$oauth->username = $token_credentials['screen_name'];
		$oauth->token = $token_credentials['oauth_token'];
		$oauth->token_secret = $token_credentials['oauth_token_secret'];
		if($oauth->save()) {
			echo 'success';
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
		$results = $twitter->get('search/tweets', array('q'=>'dailymotion', 'count'=>100, 'result_type'=>'recent'));
		foreach($results->statuses as $item) {
			if(isset($item->entities->urls[0]->expanded_url)) {
				$url = $item->entities->urls[0]->expanded_url;
				$media = NodeAR::model()->getVideoSource($url);
				if($media) {
					$imageUrl = NodeAR::model()->getVideoThumbnail($url, $media);
					echo "<img src='{$imageUrl}' />";
				}
			}
		}
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


}