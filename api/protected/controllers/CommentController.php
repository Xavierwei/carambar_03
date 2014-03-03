<?php

class CommentController extends Controller {
  
	public function actionIndex() {
		$this->responseError(101);
	}

	/**
	 * Post new comment
	 */
	public function actionPost() {
		$request = Yii::app()->getRequest();

		if (!$request->isPostRequest) {
			$this->responseError(101);
		}

		$nid        = $request->getPost("nid");
		$content    = htmlspecialchars($request->getPost("content"));

		if(Yii::app()->user->isGuest) {
			return $this->responseError(601);
		}

		$uid = Yii::app()->user->getId();
//		if (Yii::app()->user->checkAccess("postComment")) {
//			return $this->responseError(602);
//		}

		if(empty($content)) {
			return $this->responseError(701);
		}

		if(strlen($content) > 140) {
			return $this->responseError(702);
		}


		$commentAr = new CommentAR();
		$commentAr->attributes = array(
		    "uid" => $uid,
		    "nid" => $nid,
		    "content" => $content,
		    "status" => 1
		);

		if ($commentAr->validate()) {
			$commentAr->save();
			$this->cleanCache("node_")
				->cleanCache("comment_");
			return $this->responseJSON($commentAr->attributes, "success");
		}
		else {
			$this->responseError(current(array_shift($commentAr->getErrors())));
		}
	}


	/**
	 * Update comment
	 */
	public function actionPut() {
		$request = Yii::app()->getRequest();

		if (!$request->isPostRequest) {
			$this->responseError(101);
		}

		$cid = (int)$request->getPost("cid");
		if (!$cid || !is_numeric($cid)) {
			$this->responseError(101);
		}

		$comment = CommentAR::model()->with("node")->findByPk($cid);
		if (!$comment) {
			$this->responseError(101);
		}

		$node = $comment->node;
		if (!Yii::app()->user->checkAccess("updateAnyComment", array("country_id" => $node->country_id))) {
			return $this->responseError(601);
		}

		$status = (int)$request->getPost("status");
		if (!isset($status) || !is_numeric($status)) {
			$this->responseError(101);
		}

		if (isset($status)) {
			if($status == 1) {
				FlagAR::model()->deleteCommentFlag($comment->cid);
			}
		}

		$comment->status = $status;

		if ($comment->validate()) {
			$this->cleanCache("node_")
				->cleanCache("comment_");
			$comment->updateByPk((int)$comment->cid, array("status" => (int)$comment->status));
			$this->responseJSON($comment->attributes, "success");
		}
		else {
			$this->responseError(current(array_shift($comment->getErrors())));
		}
	}


	/**
	 * Delete comment
	 */
	public function actionDelete() {
		$request = Yii::app()->getRequest();

		if (!$request->isPostRequest) {
			$this->responseError(101);
		}
		$cid = $request->getPost("cid");
		if (!$cid) {
			$this->responseError(101);
		}

		$comment = CommentAR::model()->with("node")->findByPk($cid);
		if (!$comment) {
			$this->responseError(101);
		}
		$node = $comment->node;
		if (!Yii::app()->user->checkAccess("deleteAnyComment", array("country_id" => $node->country_id))
		        && !Yii::app()->user->checkAccess("deleteOwnComment", array("uid" => $comment->uid))) {
			return $this->responseError(601);
		}

		$cid = (int)$request->getPost("cid");
		if ($cid) {
			$commentAr = new CommentAR();
			$commentAr->deleteByPk((int)$cid);
			$this->cleanCache("node_")
				->cleanCache("comment_");
			return $this->responseJSON(array(), "success");
		}
		else {
			return $this->responseError(601);
		}
	}

	public function actionList() {
		$request = Yii::app()->getRequest();

		$nid        = (int)$request->getParam("nid");
		$shownode   = $request->getParam("shownode");
		$status     = $request->getParam("status");
		$keyword    = $request->getParam("keyword");
		$email   	= $request->getParam("email");
		$flagged   	= $request->getParam("flagged");

		$page = $request->getParam("page");
		if (!$page) {
			$page = 1;
		}
		$pagenum = $request->getParam("pagenum");
		if (!$pagenum) {
			$pagenum = 10;
		}

		$orderby = "datetime";

		$order = $request->getParam("order");
		if (!$order) {
			$order = "ASC";
		}
		if (strtoupper($order) != "DESC" && strtoupper($order) != "ASC") {
		  	$order = "ASC";
		}

		$query = new CDbCriteria();
		if ($nid) {
			$query->addCondition("nid=:nid");
			$query->params[":nid"] = $nid;
		}


		if(Yii::app()->user->checkAccess("isAdmin") && isset($status)) {
			$query->addCondition(CommentAR::model()->getTableAlias().".status=:status");
			$query->params[":status"] = $status;
		}
		elseif(Yii::app()->user->checkAccess("isAdmin")) {
			//show all
		}
		else {
			$query->addCondition(CommentAR::model()->getTableAlias().".status=:status");
			$query->params[":status"] = 1;
		}

		// search by keyword
		if (Yii::app()->user->checkAccess("isAdmin") && isset($keyword)) {
			$query->addSearchCondition("content", $keyword);
		}

		// search by user email
		if (Yii::app()->user->checkAccess("isAdmin") && $email) {
			$queryUser = new CDbCriteria();
			$queryUser->addSearchCondition("company_email", $email, true);
			$queryUser->addSearchCondition("personal_email", $email, true, 'OR');
			$users = UserAR::model()->findAll($queryUser);
			if(count($users) > 0) {
				foreach($users as $user) {
					$usersList[] = $user->uid;
				}
				$strUsersList = implode(',', $usersList);
				$query->addCondition(CommentAR::model()->getTableAlias().".uid in (".$strUsersList.")", "AND");
			}
			else {
				$this->responseJSON(array(), "success");
			}
		}

		if($flagged) {
			$query->select = "*";
			$query->join = 'right join `flag` on `flag`.cid = '.CommentAR::model()->getTableAlias().'.cid';
		}

		$query->order = CommentAR::model()->getTableAlias().".$orderby $order";
		$query->with = array("user");

		$count = CommentAR::model()->count($query);
		$query->limit = $pagenum;
		$query->offset = ($page - 1 ) * $pagenum;
		$comments = CommentAR::model()->findAll($query);

		$retdata = array();
		foreach ($comments as $comment) {
			$commentdata            = $comment->attributes;
			$commentdata['content'] = htmlentities($commentdata['content']);
			$country                = $comment->user? $comment->user->country: NULL;
			$user                   = $comment->user? $comment->user->attributes: NULL;
			$user["country"]        = $country ? $country->attributes: NULL;
			$commentdata["user"]    = $comment->user? $comment->user->getOutputRecordInArray($user): NULL;
			if ($shownode) {
				$commentdata['node'] = NodeAR::model()->findByPk($comment->attributes['nid']);
			}
			if(isset($user['uid']) && Yii::app()->user->getId() == $user['uid']) {
				$commentdata["mycomment"] = TRUE;
			}
			$commentdata['flagcount'] = FlagAR::model()->flagCountInComment($comment->cid);
			$retdata[] = $commentdata;
		}

		if(Yii::app()->user->checkAccess("isAdmin")) {
			$this->responseJSON($retdata, array('total'=>$count));
		}
		else {
			$this->responseJSON($retdata, "success");
		}
	}




	/**
	 * Get comment by cid (disabled)

	public function actionGetbyid() {
		$request = Yii::app()->getRequest();

		$cid = $request->getParam("cid");
		if (!$cid) {
		  return $this->responseError("invalid params");
		}

		$comment = CommentAR::model()->with(array("user", "node"))->findByPk($cid);
		if (!$comment) {
		  return $this->responseError("invalid params");
		}

		$retdata = $comment->attributes;
		if ($comment->user) {
		  $user = $comment->user;
		  $country = $user->country;
		  $retdata["user"] = $user->getOutputRecordInArray(array("country" => $country->attributes) + $user->attributes);
		}
		if ($comment->node) {
		  $retdata["node"] = $comment->node->attributes;
		}

		$this->responseJSON($retdata, "success");

	}
	*/


	/***
	 * Get flagged comments
	 */
	public function actionFlaggedCommentsList() {
		$request = Yii::app()->getRequest();
		$nid = $request->getParam("nid");
		$retdata = CommentAR::model()->flaggedCommentsList($nid);
		$this->responseJSON($retdata, "success");
	}

}

