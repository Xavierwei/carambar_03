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
		if(!$user) {
			$loginUrl = $this->facebook->getLoginUrl();
			return $this->responseJSON($loginUrl, "success");
		}
		else {
			return $this->responseJSON('login', "success");
		}

	}


	/**
	 * Fetch facebook
	 */
	public function actionFetch(){
		$oauth = OauthAR::model()->findByAttributes(array('media'=>$this::MEDIA));
		$oauth_token = $oauth->token;
		$this->facebook->setAccessToken($oauth_token);
		$results = $this->facebook->api('/search', 'GET',
			array(
				'q' => 'snow'
			));


		foreach($results['data'] as $item) {
			$snsVideoLink = $snsPicture = $snsDatetime = $snsDescription = $snsId = $snsLocation = $snsScreenName = NULL;
			if(isset($item['link'])) {
				$snsVideoLink = $item['link'];
			}

			if(isset($item['picture'])) {
				$snsPicture = $item['picture'];
			}

			if(isset($item['created_time'])) {
				$snsDatetime = strtotime($item['created_time']);
			}

			if(isset($item['story']) || isset($item['message'])) {
				$snsDescription = isset($item['story']) ? $item['story'] : $item['message'];
			}

			if(isset($item['id'])) {
				$snsId = $item['id'];
			}

			if(isset($item['from']['name'])) {
				$snsScreenName = $item['from']['name'];
			}

			NodeAR::model()->saveNode($snsVideoLink, $snsPicture, $snsDatetime, $snsDescription, $snsId, $snsScreenName, $snsLocation, $this::MEDIA);
		}
		$this->cleanAllCache();
	}


	/**
	 * POST Facebook
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
		$results = $this->facebook->api('/me/feed', 'POST',
			array(
				'message' => $content
			));

		return $this->responseJSON($results, "success");
	}
}