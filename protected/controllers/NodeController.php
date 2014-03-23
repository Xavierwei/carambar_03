<?php

class NodeController extends Controller {

	/**
	 * Post new node (photo/video)
	 */
	public function actionPost() {
		$uid = Yii::app()->user->getId();
		$user = UserAR::model()->findByPk($uid);

		if (!Yii::app()->user->checkAccess("addNode")) {
			return $this->responseError(602);
		}

		if ($user) {
			$country_id = $user->country_id;

			$request = Yii::app()->getRequest();
			if (!$request->isPostRequest) {
				$this->responseError("http error");
			}
			$type = htmlspecialchars($request->getPost("type"));
			$isIframe = htmlspecialchars($request->getPost("iframe"));
			$isFlash = htmlspecialchars($request->getPost("flash"));

			$nodeAr = new NodeAR();
			if($isIframe || $isFlash) {
				$fileUpload = CUploadedFile::getInstanceByName("file");
				$validateUpload = $nodeAr->validateUpload($fileUpload, $type);
				if($validateUpload !== true) {
					if($isIframe){
						$this->render('post', array(
							'code'=>$validateUpload
						));
						return;
					}
					else {
						return $this->responseError($validateUpload);
					}
				}
			}
			$nodeAr->description = htmlspecialchars($request->getPost("description"));
			$nodeAr->type = $type;
			if($isIframe || $isFlash) {
				$nodeAr->file = $nodeAr->saveUploadedFile($fileUpload);
			}
			else {
				$file = $request->getPost("file");
				if(!file_exists(ROOT.$file)) {
					exit();
				}
				$_x = $request->getPost("x");
				if($_x && $type == 'photo') {
					$_y = $request->getPost("y");
					$_width = $request->getPost("width");
					$_scale_size = $request->getPost("size");
					$nodeAr->file = $nodeAr->cropPhoto($file, $_x, $_y, $_width, $_scale_size);
				}
		        else {
		          $nodeAr->file = $file;
		        }
			}

			$nodeAr->uid = $uid;
			$nodeAr->country_id = $country_id;
			if ($nodeAr->validate()) {
				$success = $nodeAr->save();
				if (!$success) {
				    $this->responseError("exception happended");
				}
				$retdata = $nodeAr->attributes;
				$retdata['user'] = $nodeAr->user->attributes;
				$retdata['country'] = $nodeAr->country->attributes;


				$this->cleanCache("node_")
					->cleanCache("comment_");
				
				if($isIframe){
					$this->render('post', array(
						'code'=>1
					));
					return;
				} else {
					$this->responseJSON($retdata, "success");
				}

			}
			else {
				$this->responseError($nodeAr->getErrors());
			}
		}
		else {
			$this->responseError("unknown error");
		}
	}

	/**
	 * Crop photo
	 */
	public function actionCrop() {
		$request = Yii::app()->getRequest();
		if (!$request->isPostRequest) {
			$this->responseError(1001);
		}
		$nid = $request->getPost("nid");
		$_x = $request->getPost("x");
		$_y = $request->getPost("y");
		$_width = $request->getPost("width");
		$_scale_size = $request->getPost("size");
		$file = $request->getPost("path");

		$node = NodeAR::model()->findByPk($nid);
		if($node) {
			$node->file = $node->cropPhoto($file, $_x, $_y, $_width, $_scale_size);
			$node->save();
			//delete thumbnail
			@unlink(ROOT.str_replace('.jpg','_640_640.jpg',$file));
			@unlink(ROOT.str_replace('.jpg','_400_400.jpg',$file));
			@unlink(ROOT.str_replace('.jpg','_126_126.jpg',$file));
			$node->makeImageThumbnail(ROOT.$file, ROOT.str_replace('.jpg', '_400_400.jpg', $file), 400, 400, false);
			$node->makeImageThumbnail(ROOT.$file, ROOT.str_replace('.jpg', '_640_640.jpg', $file), 640, 640, false);
			$this->responseJSON($node->attributes, "success");
		}
	}

	/**
	 * Update node
	 */
	public function actionPut() {
		$request = Yii::app()->getRequest();
		if (!$request->isPostRequest) {
			$this->responseError(101);
		}

		$nid = $request->getPost("nid");
		if (!$nid) {
			$this->responseError(101);
		}

		if (!Yii::app()->user->checkAccess("updateNode")) {
			return $this->responseError(602);
		}

		$node = NodeAR::model()->findByPk($nid);
      
		if ($node) {
			$description = $request->getPost("description");
			if (isset($status)) {
				$node->description =  $description;
			}

			$status = $request->getPost("status");


			if (isset($status)) {
				$node->status = $status;
				if($status == 1) {
					if($node->email) {
						$emailInfo = Yii::app()->params['email'];
						@Drtool::sendEmail($emailInfo['sendName'], $emailInfo['titleApprove'], $emailInfo['contentApprove'], $node->email);
					}
				}
			}

			if ($node->validate()) {
				$node->beforeSave();

				$ret = $node->updateByPk($node->nid, array("status" => $node->status));
				$this->cleanCache("node_")
					->cleanCache("comment_");
				$this->responseJSON($node->attributes, "success");
			}
			else {
				$this->responseError(current(array_shift($node->getErrors())));
			}
		}
		else {
			$this->responseError(101);
		}
	}

	public function actionReward() {
		$request = Yii::app()->getRequest();
		if (!$request->isPostRequest) {
			$this->responseError(101);
		}

		$nid = $request->getPost("nid");
		if (!$nid) {
			$this->responseError(101);
		}

		if (!Yii::app()->user->checkAccess("updateNode")) {
			return $this->responseError(602);
		}

		$node = NodeAR::model()->findByPk($nid);

		if ($node) {
			$reward = $request->getPost("reward");
			if (isset($reward)) {
				$node->reward = $reward;
			}

			if ($node->validate()) {
				$node->beforeSave();
				$ret = $node->updateByPk($node->nid, array("reward" => $node->reward));
				$this->cleanCache("node_")
					->cleanCache("comment_");
				if($node->reward == 1 && $node->email) {
					$emailInfo = Yii::app()->params['email'];
					@Drtool::sendEmail($emailInfo['sendName'], $emailInfo['titleAward'], $emailInfo['contentAward'], $node->email);
				}
				$this->responseJSON($node->attributes, "success");
			}
			else {
				$this->responseError(current(array_shift($node->getErrors())));
			}
		}
		else {
			$this->responseError(101);
		}
	}

	/*
	 * Delete content
	*/
	public function actionDelete() {
		$request = Yii::app()->getRequest();

		if (!$request->isPostRequest) {
		  $this->responseError(101);
		}

		$nid = $request->getPost("nid");

		if (!$nid) {
		  $this->responseError(101);
		}

		$nodeAr = NodeAR::model()->findByPk($nid);
		if(!$nodeAr) {
		  return $this->responseError(102);
		}

		if(!Yii::app()->user->checkAccess("deleteOwnNode", array("uid" => $nodeAr->uid))) {
			return $this->responseError(602);
		}

		$nodeAr->deleteByPk($nodeAr->nid);
		$nodeAr->deleteRelatedData($nodeAr->nid);
		// update hashtag counts
		$hashtags =$nodeAr->attributes['hashtag'];
		foreach($hashtags as $tag) {
		  TagAR::model()->minusTagCount($tag);
		}
		// update top contents
		LikeAR::model()->saveTopOfDay($nodeAr);
		LikeAR::model()->saveTopOfMonth($nodeAr);

		$this->cleanCache("node_")
			->cleanCache("comment_");
		return $this->responseJSON($nodeAr->attributes, "success");
	}

	/**
	 * Get the page num by nid
	 */
	public function actionGetPageByNid(){
		$request = Yii::app()->getRequest();
		$nid = $request->getParam("nid");
		$pagenum = $request->getParam("pagenum");
		$page = NodeAR::model()->getPageByNid($nid, $pagenum);
		$this->responseJSON($page, "success");
	}

	/**
	 * Get Node by nid
	 */
	public function actionGetByNid() {
		if(Yii::app()->user->checkAccess("isAdmin")) {
			$request = Yii::app()->getRequest();
			$nid = $request->getParam("nid");
			$node = NodeAR::model()->findByPk($nid);
			$data = $node->attributes;
			$this->responseJSON($data, "success");
		}
	}

	/**
	 * Get node list
	 */
	public function actionList() {
		$request= Yii::app()->getRequest();

		$token      = $request->getParam("token");
		$type		= $request->getParam("type");
		$country_id	= $request->getParam("country_id");
		$uid		= $request->getParam("uid");
		$mycomment	= $request->getParam("mycomment");
		$mylike		= $request->getParam("mylike");
		$topday		= $request->getParam("topday");
		$topmonth	= $request->getParam("topmonth");
		$page		= $request->getParam("page");
		$pagenum	= $request->getParam("pagenum");
		$start		= $request->getParam("start");
		$end		= $request->getParam("end");
		$orderby 	= $request->getParam("orderby");
		$status 	= $request->getParam("status");
		$keyword 	= $request->getParam("keyword");
		$email 		= $request->getParam("email");
		$flagged	= $request->getParam("flagged");
		$reward		= $request->getParam("reward");

		if (!$page) {
			$page = 1;
		}

		if (!$pagenum) {
			$pagenum = 10;
		}


		$user = UserAR::model()->findByPk(Yii::app()->user->getId());

//		$session_token =  Yii::app()->session['token'];
//		if($token != $session_token) {
//			$this->responseError(102);
//		}

		// Build Query
		$query = new CDbCriteria();
		$nodeAr = new NodeAR();
		$params = &$query->params;

		if ($type) {
			$query->addCondition("type=:type", "AND");
			$params[":type"] = $type;
		}

		if ($country_id) {
			$query->addCondition("country.country_id = :country_id", "AND");
			$params[":country_id"] = $country_id;
		}

		if ($uid) {
			if($mycomment) { // filter my commented contents
				$query->addCondition("comment.uid=:uid", "AND");
				$params[":uid"] = $uid;
			}
			else if($mylike) { // filter my liked contents
				$query->addCondition("like.uid=:uid", "AND");
				$params[":uid"] = $uid;
			}
			else {  // filter my posted contents
				$query->addCondition($nodeAr->getTableAlias().".uid=:uid", "AND");
				$params[":uid"] = $uid;
			}
		}

		if ($start) {
			$start = strtotime($start);
			$params[":start"] = $start;
			$query->addCondition($nodeAr->getTableAlias().".datetime >= :start", "AND");
		}
		if ($end) {
			$end = strtotime($end);
			$params[":end"] = $end;
			$query->addCondition($nodeAr->getTableAlias().".datetime<= :end", "AND");
		}



		// search by user email
		if (Yii::app()->user->checkAccess("isAdmin") && $email) {
			$query->addSearchCondition("email", $email);
		}

		if (Yii::app()->user->checkAccess("isAdmin") && $status == 'all') {
			if ($user->role == UserAR::ROLE_ADMIN) {
				$query->addCondition($nodeAr->getTableAlias().".status != 2", "AND");
			}
			else if ($user->role == UserAR::ROLE_COUNTRY_MANAGER) {
				$query->addCondition("country_id = :country_id");
				$query->params[':country_id'] = $user->country_id;
			}
		}
		elseif (Yii::app()->user->checkAccess("isAdmin") && isset($status)) {
			$query->addCondition($nodeAr->getTableAlias().".status = :status", "AND");
			$params[":status"] = $status;
		}
		else {
			$status = NodeAR::PUBLICHSED;
			$query->addCondition($nodeAr->getTableAlias().".status = :status", "AND");
			$params[":status"] = $status;
		}

		if($reward) {
			$query->addCondition($nodeAr->getTableAlias().".reward = :reward", "AND");
			$params[":reward"] = 1;
		}

		// Get like count
		$query->select = "*". ", count(like_id) AS likecount". ",topday_id AS topday" . ",topmonth_id AS topmonth";
		$query->join = 'left join `like` '.' on '. '`like`' .".nid = ". $nodeAr->getTableAlias().".nid";
		$query->join .= ' left join `topday` '.' on '. '`topday`' .".nid = ". $nodeAr->getTableAlias().".nid";
		$query->join .= ' left join `topmonth` '.' on '. '`topmonth`' .".nid = ". $nodeAr->getTableAlias().".nid";
		$query->group = $nodeAr->getTableAlias().".nid";

		// Get content of the day
		if($topday) {
			$query->select = "*". ",topday_id AS topday";
			$query->join = 'right join `topday` '.' on '. '`topday`' .".nid = ". $nodeAr->getTableAlias().".nid";
		}

		// Get contents of the month
		if($topmonth) {
			$query->select = "*". ",topmonth_id AS topmonth";
			$query->join = 'right join `topmonth` '.' on '. '`topmonth`' .".nid = ". $nodeAr->getTableAlias().".nid";
		}

		// Get the content I commented
		if($mycomment) {
			$query->select = "*";
			$query->join = 'right join `comment` on `comment`.nid = '.$nodeAr->getTableAlias().'.nid';
		}

		// Get the content I liked
		if($mylike) {
			$query->select = "*";
			$query->join = 'right join `like` on `like`.nid = '.$nodeAr->getTableAlias().'.nid';
		}

		if($flagged) {
			$query->select = "*";
			$query->join = 'right join `flag` on `flag`.nid = '.$nodeAr->getTableAlias().'.nid';
		}

		$order = "";
		if ($orderby == "datetime") {
			$order .= " ".$nodeAr->getTableAlias().".datetime DESC";
			$query->order = $order;
		}
		else if ($orderby == "like") {
			$order .= "`likecount` DESC";
			$query->order = $order;
		}
		else if ($orderby == "random") {
			$page = 1;
			$sql = "SELECT max(nid) as max, min(nid) as min FROM node";
			$ret = Yii::app()->db->createCommand($sql);
			$row = $ret->queryRow();
			$nids = array();
			$max_run = 0;
			while (count($nids) < $pagenum && $max_run < $pagenum * 10) {
				$max_run ++;
				$nid = mt_rand($row["min"], $row["max"]);
				if (!isset($nids[$nid])) {
					$cond = array();
					foreach ($params as $k => $v) {
						$cond[str_replace(":", "", $k)] = $v;
					}
					$node = NodeAR::model()->findByPk($nid);

					if (!$node) {
						continue;
					}

					$isNotWeWant = FALSE;
					foreach ($cond as $k => $v) {
						if($node->{$k} != $v) {
							$isNotWeWant = TRUE;
							break;
						}
					}
					if ($isNotWeWant) {
						continue;
					}
					$nids[$nid] = $nid;
				}
			}
			$query->addInCondition($nodeAr->getTableAlias().".nid", $nids, "AND");
		}


		// Search by keyword
		if ($keyword) {
			$query->addSearchCondition("description", $keyword);
		}

		// Search by hashtag
		$hashtag = $request->getParam("hashtag");
		if ($hashtag) {
			$query->addSearchCondition("hashtag", $hashtag);
		}

		$count = NodeAR::model()->with("user", "country")->count($query);

		$query->limit = $pagenum;
		$query->offset = ($page - 1 ) * $pagenum;
		$query->with = array("user", "country");

		$res = NodeAR::model()->with("user", "country")->findAll($query);

		$retdata = array();
		$commentAr = new CommentAR();
		foreach ($res as $node) {
			$data = $node->attributes;
			$data["description"]    = $node->description;
			$data["likecount"]      = $node->likecount;
			$data["commentcount"]   = $commentAr->totalCommentsByNode($node->nid);
			$data["user"]           = $node->user ? $node->user->attributes : array();
			$data["country"]        = $node->country ? $node->country->attributes: array();
			$data["user_liked"]     = $node->user_liked;
			$data["user_flagged"]   = $node->user_flagged;
			$data["embed"]			= $node->getEmbedUrl($node->url, $node->from);
			if($uid && isset($node->user['uid']) && Yii::app()->user->getId() == $node->user['uid']) {
				$data["mynode"] = TRUE;
			}
			//$data["like"] = $node->like;
			if($node->topday) {
				$data["topday"] = TRUE;
			}
			if($node->topmonth) {
				$data["topmonth"] = TRUE;
			}
			$retdata[] = $data;
		}

		if(Yii::app()->user->checkAccess("isAdmin")) {
			$this->responseJSON($retdata, array('total'=>$count));
		}
		else {
			$this->responseJSON($retdata, "success");
		}

	}

	// count the unapproved node
	public function actionCountNode() {
		$counts = NodeAR::model()->countByAttributes(array('status'=>0));
		if($counts > 0) {
			$emailInfo = Yii::app()->params['email'];
			@Drtool::sendEmail($emailInfo['sendName'], 'Good Luck Carambar : Posts en attente de publication',
				'Bonjour, <br/><br/>Et ouais mec, '.$counts.' posts sont en attente de validation dans le back-office. Connecte-toi sur l\'interface administrateur pour gerer ces contenus : http://www.goodluckcarambar.com/admin La bise',
				$emailInfo['emailList']);
		}
	}
}

