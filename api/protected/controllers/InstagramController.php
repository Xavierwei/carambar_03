<?php
class InstagramController extends Controller {

	const MEDIA = 'instagram';

	private $instagram;

	public function __construct()
	{
		$this->instagram = new Instagram(array(
			'apiKey'      => INSTAGRAM_AKEY,
			'apiSecret'   => INSTAGRAM_SKEY,
			'apiCallback' => INSTAGRAM_CALLBACK_URL
		));
	}

	/**
	 * Get Instagram login URL
	 */
	public function actionLogin() {
		echo "<a href='{$this->instagram->getLoginUrl()}'>Login with Instagram</a>";
	}


	/**
	 * Store the account OAuthToken
	 */
	public function actionCallback() {
		$code = $_GET['code'];
		$data = $this->instagram->getOAuthToken($code);
		if(!isset($data->user)) {
			return;
		}

		$oauth = OauthAR::model()->findByAttributes(array('media'=>$this::MEDIA));
		if(!$oauth) {
			$oauth = new OauthAR();
		}
		$oauth->media = $this::MEDIA;
		$oauth->username = $data->user->username;
		$oauth->token = $data->access_token;
		if($oauth->save()) {
			echo 'success';
		}
	}


	/**
	 * Fetch the media
	 */
	public function actionFetch(){
		$oauth = OauthAR::model()->findByAttributes(array('media'=>$this::MEDIA));
		$oauthData = new stdClass();
		$oauthData->access_token = $oauth->token;
		$this->instagram->setAccessToken($oauthData);

		$tag = Yii::app()->params['tag'];
		$media = $this->instagram->getTagMedia($tag);
		foreach ($media->data as $entry) {
			echo "<img src=\"{$entry->images->thumbnail->url}\">";
		}
	}


}