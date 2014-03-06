<?php
class FacebookController extends Controller {

	const MEDIA = 'facebook';

	public $facebook;

	public function __construct()
	{
		$this->facebook = new Facebook(array(
			'appId'  => FB_APPID,
			'secret' => FB_SKEY,
			'allowSignedRequest' => false
		));
	}

	/**
	 * Get Instagram login URL
	 */
	public function actionLogin() {
		$user = $this->facebook->getUser();
		print_r($user);
		if(!$user) {
			$loginUrl = $this->facebook->getLoginUrl();
			echo "<a href='{$loginUrl}'>Login with Facebook</a>";
		}
		else {
			$user_profile = $this->facebook->api('/me');
			print_r($user_profile);
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


	/**
	 * POST twitter
	 */
	public function actionPost(){
		$ret_obj = $this->facebook->api('/me/feed', 'POST',
			array(
				'link' => 'www.example.com',
				'message' => 'Posting with the PHP SDK!'
			));

		print_r($ret_obj);
	}


}