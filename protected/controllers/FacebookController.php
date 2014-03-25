<?php
class FacebookController extends Controller {

	const MEDIA = 'facebook';

	public $facebook;

	public function __construct()
	{
		$this->facebook = new Facebook(array(
			'appId'  => FB_APPID,
			'secret' => FB_SKEY,
			'allowSignedRequest' => true
		));
	}

	public function actionUser() {
		$access_token = Yii::app()->session['fb_access_token'];
//		echo $access_token;
		$this->facebook->setAccessToken($access_token);
		$user_id = $this->facebook->getUser();
		echo $user_id;
	}

	/**
	 * Get Instagram login URL
	 */
	public function actionLogin() {

		$request = Yii::app()->getRequest();
		$_ = $request->getParam("code");

		if(!$_) {
			$access_token = Drtool::getMyCookie('fb_token');
			$this->facebook->setAccessToken($access_token);
			$user_id = $this->facebook->getUser();
			if(!$user_id) {
				$loginUrl = $this->facebook->getLoginUrl(array('scope' => 'email,publish_actions', 'redirect_uri'=>FB_CALLBACK_URL));
				//echo "<a href='{$loginUrl}'>login</a>";
				return $this->responseJSON($loginUrl, "success");
			}
			else {
				return $this->responseJSON('login', "success");
			}
		}
		else {
			$token_url = "https://graph.facebook.com/oauth/access_token?"
				. "client_id=" . FB_APPID . "&redirect_uri=" . urlencode(FB_CALLBACK_URL).  "&client_secret=" . FB_SKEY . "&code=" . $_;


			$response = @file_get_contents($token_url);
			$params = null;
			parse_str($response, $params);
			//$access_token = $this->facebook->getAccessToken();
			//			echo $access_token;
			//			exit();

//				$graph_url = "https://graph.facebook.com/me?access_token="
//					. $params['access_token'];

			$access_token = Yii::app()->session['fb_access_token'] = $params['access_token'];
			Drtool::setMyCookie('fb_token',$params['access_token'],1);
			$this->facebook->setAccessToken($access_token);
			$user_profile = $this->facebook->api('/me','GET');
			// Create the new user if user doesn't exist in database
			if( !$user = UserAR::model()->findByAttributes(array('name'=>'f_'.$user_profile['username'])) ) {
				$user = UserAR::model()->createSNSLogin('f_'.$user_profile['username'], $user_profile['id'], $user_profile['email'], $user_profile['username']);
			}

			// Identity local site user data
			$userIdentify = new UserIdentity($user->name, md5($user_profile['id']));

			// Save user status in session
			if (!$userIdentify->authenticate()) {
			}
			else {
				Yii::app()->user->login($userIdentify);
				$this->redirect('/index#support-carambar');
			}
		}
	}

	/**
	 * Get Instagram login URL
	 */
	public function actionAdLogin() {

		$request = Yii::app()->getRequest();
		$_ = $request->getParam("code");

		if(!$_) {
			$access_token = Yii::app()->session['fb_access_token'];
			$this->facebook->setAccessToken($access_token);
			echo $access_token;
			$user_id = $this->facebook->getUser();
			if(!$user_id) {
				$loginUrl = $this->facebook->getLoginUrl(array('scope' => 'email,publish_actions', 'redirect_uri'=>FB_CALLBACK_URL2));
				echo "<a href='{$loginUrl}'>login</a>";
				//return $this->responseJSON($loginUrl, "success");
			}
			else {
				return $this->responseJSON('login', "success");
			}
		}
		else {
			$token_url = "https://graph.facebook.com/oauth/access_token?"
				. "client_id=" . FB_APPID . "&redirect_uri=" . urlencode(FB_CALLBACK_URL2).  "&client_secret=" . FB_SKEY . "&code=" . $_;


			$response = @file_get_contents($token_url);
			$params = null;
			parse_str($response, $params);
			$access_token = $this->facebook->getAccessToken();
			$access_token = Yii::app()->session['fb_access_token'] = $params['access_token'];
			echo $access_token;
		}
	}


	/**
	 * Fetch facebook
	 */
	public function actionFetch(){
		$oauth = OauthAR::model()->findByAttributes(array('media'=>$this::MEDIA));
		$oauth_token = $oauth->token;
		$this->facebook->setAccessToken($oauth_token);

		try {
			$results = $this->facebook->api('/search', 'GET',
				array(
					'q' => Yii::app()->params['tag']
				));
		}
		catch(Exception $e) {
		}


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

			if(NodeAR::model()->uniqueMid($snsId)) {
				NodeAR::model()->saveNode($snsVideoLink, $snsPicture, $snsDatetime, $snsDescription, $snsId, $snsScreenName, $snsLocation, $this::MEDIA);
			}
		}
		$this->cleanAllCache();
	}


	/**
	 * POST Facebook
	 */
	public function actionPost(){
		$request = Yii::app()->getRequest();
		$content = htmlspecialchars($request->getPost("content"));
		$img = $request->getPost("img");
		$_x = $request->getPost("x");
		if($img && $_x) {
			$_y = $request->getPost("y");
			$_width = $request->getPost("width");
			$_scale_size = $request->getPost("size");
			$newfile =  NodeAR::model()->cropPhoto($img, $_x, $_y, $_width, $_scale_size);
		}
		else if($img) {
			$newfile = NodeAR::model()->saveBase64Image($img);
		}

		if(strlen($content) == 0) {
			return $this->responseError(702);
		}

		if(strlen($content) > 140) {
			return $this->responseError(703);
		}


		//$access_token = Yii::app()->session['fb_access_token'];
		$access_token = Drtool::getMyCookie('fb_token');
		$this->facebook->setAccessToken($access_token);
		$user_profile = $this->facebook->api('/me','GET');

		if(!empty($newfile)) {
			$type = 'photo';
			$mid = $results = $this->facebook->api('/me/photos', 'POST',
				array(
					'source'=>'multipart/form-data',
					'url'=> Yii::app()->params['siteurl'].$newfile,
					//'url' => 'http://media-cache-ec0.pinimg.com/736x/65/28/16/6528164aaeac05e248f949d6b137750b.jpg',
					'message' => $content
				));
		}
		else {
			$type = 'text';
			$mid = $results = $this->facebook->api('/me/feed', 'POST',
				array(
					'message' => $content
				));
		}


		if($mid) {
			$node = new NodeAR();

			$node->type = $type;
			$node->media = 'facebook';

			$node->mid = isset($mid['post_id']) ? $mid['post_id'] : $mid['id'];
			$node->description = $content;
			$node->screen_name = $user_profile['username'];
			$node->email = $user_profile['email'];
			if(isset($newfile)) {
				$node->file = $newfile;
			}
			$node->datetime = time();
			$node->status = 0;
			if ($node->validate()) {
				$node->save();
				if($node->email) {
					//TODO send
					$emailInfo = Yii::app()->params['email'];
					@Drtool::sendEmail($emailInfo['sendName'], $emailInfo['titleNew'], $emailInfo['contentNew'], $emailInfo['emailList']);
				}
				return $this->responseJSON($node, "success");
			}
		}
		else {
			return $this->responseError(709);
		}



	}
}