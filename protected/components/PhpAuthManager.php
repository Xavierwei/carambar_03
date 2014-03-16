<?php

class PhpAuthManager extends CPhpAuthManager{
  
  public $role = 0;
  
  public $country_id = 0;
  
  public function init() {
    parent::init();
    
    // 删除任意node
    $bizrule = 'return Yii::app()->user->role == UserAR::ROLE_ADMIN ? TRUE : Yii::app()->user->role == UserAR::ROLE_COUNTRY_MANAGER && Yii::app()->user->country_id == $params["country_id"] ? TRUE : FALSE;';
    $this->createOperation("deleteAnyNode", "delete one node", $bizrule);
    
    // 禁用掉 node
    $this->createOperation("blockNode", "block one node");
    
    // 添加node
    $this->createOperation("addNode", "add new node");
    
    // 
    $this->createOperation("unpublishNode", "unpublish one node");
    
    // 
    $this->createOperation("publichsNode", "publish one node");

	//
	$bizrule = 'return Yii::app()->user->role == UserAR::ROLE_ADMIN ? TRUE : Yii::app()->user->role == UserAR::ROLE_COUNTRY_MANAGER && Yii::app()->user->country_id == $params["country_id"] ? TRUE : FALSE;';
	$this->createOperation("updateNode", "update one node", $bizrule);
    
    //修改自己的node
    $bizrule = 'return Yii::app()->user->getId() == $params["uid"];';
    $this->createOperation("updateOwnNode", "update Own node", $bizrule);
    
    // 删除自己的node
    $bizrule = 'return Yii::app()->user->getId() == $params["uid"];';
    $this->createOperation("deleteOwnNode", "delete own node", $bizrule);


    
    
    // 首先检查用户角色，用户如果是country 管理员，只能修改自己国家的media; 如果是admin 就没有权限
    // 直接返回 TRUE
	$bizrule = 'return Yii::app()->user->role == UserAR::ROLE_ADMIN;';
	$this->createOperation("isAdmin", "check is admin", $bizrule);

    $bizrule = 'return Yii::app()->user->role == UserAR::ROLE_ADMIN ? TRUE : Yii::app()->user->role == UserAR::ROLE_COUNTRY_MANAGER && Yii::app()->user->country_id == $params["country_id"] ? TRUE : FALSE;';
    $this->createOperation("updateNodeMedia", "update node media", $bizrule);
    
    $bizrule = 'return Yii::app()->user->country_id == $params["country_id"]';
    $this->createOperation('updateCountryNode', "update node in special country");
    
    $this->createOperation("likeNode", "like one node");
    
    $bizrule = 'return Yii::app()->user->getId() == $params["uid"];';
    $this->createOperation("cancelOwnLike", "Cancel like of node", $bizrule);
    
    $this->createOperation("flagNode", "flag one node");
    
    $bizrule = 'return Yii::app()->user->role == UserAR::ROLE_ADMIN ? TRUE : Yii::app()->user->country_id == $params["country_id"] ? TRUE: FALSE;';
    $this->createOperation("removeFlag", "remove flag from one node", $bizrule);
    
    $this->createOperation("listFlagedNode", "get list of flaged nodes");
    
    $this->createOperation("listFlagedComment", "get list of flaged comments");
    
    $bizrule = "return Yii::app()->user->getId()";
    $this->createOperation("postComment", "post comment for node", $bizrule);
    
    $bizrule = 'return Yii::app()->user->getId() == $params["uid"];';
    $this->createOperation("updateOwnComment", "update own comment", $bizrule);
    
    $bizrule = 'return Yii::app()->user->getId() == $params["uid"];';
    $this->createOperation("deleteOwnComment", "delete own comment", $bizrule);
    
    $bizrule = 'return Yii::app()->user->role == UserAR::ROLE_ADMIN ? TRUE : Yii::app()->user->role == UserAR::ROLE_COUNTRY_MANAGER && Yii::app()->user->country_id == $params["country_id"] ? TRUE : FALSE;';
    $this->createOperation("deleteAnyComment", "remove comment of node", $bizrule);
    
    $bizrule = 'return Yii::app()->user->role == UserAR::ROLE_ADMIN ? TRUE : Yii::app()->user->role == UserAR::ROLE_COUNTRY_MANAGER && Yii::app()->user->country_id == $params["country_id"] ? TRUE : FALSE;';
    $this->createOperation("updateAnyComment", "update any comment", $bizrule);
    
    $bizrule = 'return Yii::app()->user->getId() == $params["uid"];';
    $this->createOperation("updateOwnAccount", "update own account", $bizrule);
    
    $bizrule = 'return Yii::app()->user->role == UserAR::ROLE_ADMIN ? TRUE: Yii::app()->user->role == UserAR::ROLE_COUNTRY_MANAGER  && Yii::app()->user->country_id == $params["country_id"]? TRUE : FALSE; ';
    $this->createOperation("deleteAnyAccount", "delete any account", $bizrule);
    
    $bizrule = 'return Yii::app()->user->role == UserAR::ROLE_ADMIN ? TRUE: Yii::app()->user->role == UserAR::ROLE_COUNTRY_MANAGER  && Yii::app()->user->country_id == $params["country_id"]? TRUE : FALSE; ';
    $this->createOperation("updateAnyAccount", "update any account");
    
    // 列出所有的用户
    $bizrule = 'return Yii::app()->user->role == UserAR::ROLE_ADMIN ? TRUE: Yii::app()->user->role == UserAR::ROLE_COUNTRY_MANAGER  ? TRUE : FALSE; ';
    $this->createOperation("listAllAccount", "list all user", $bizrule);
    
    $this->createOperation("addCountry", "add new country");
    $this->createOperation("updateCountry", "update country");
    $this->createOperation("deleteCountry", "delete country");
    
    
    // admin role
    $admin = $this->createRole("admin");
	$admin->addChild("isAdmin");
    $admin->addChild("deleteAnyNode");
    $admin->addChild("blockNode");
    $admin->addChild("unpublishNode");
    $admin->addChild("publichsNode");
    $admin->addChild("updateNodeMedia");
    $admin->addChild("updateOwnNode");
    $admin->addChild("updateAnyAccount");
    $admin->addChild("deleteAnyAccount");
    $admin->addChild("listAllAccount");
    $admin->addChild("postComment");
    $admin->addChild("deleteAnyComment");
    $admin->addChild("updateAnyComment");
    $admin->addChild("flagNode");
    $admin->addChild("listFlagedNode");
    $admin->addChild("listFlagedComment");
    $admin->addChild("addCountry");
    $admin->addChild("updateCountry");
    $admin->addChild("deleteCountry");
    $admin->addChild("addNode");
    $admin->addChild("updateOwnAccount");
    $admin->addChild("updateOwnComment");
    $admin->addChild("deleteOwnComment");
    $admin->addChild("removeFlag");
    $admin->addChild("deleteOwnNode");
	$admin->addChild("updateNode");
    
    // country manager
    $countryManager = $this->createRole("countryManager");
    $countryManager->addChild("updateNodeMedia");
    $countryManager->addChild("updateOwnNode");
    $countryManager->addChild("deleteAnyNode");
    $countryManager->addChild("updateAnyAccount");
    $countryManager->addChild("deleteAnyAccount");
    $countryManager->addChild("listAllAccount");
    $countryManager->addChild("postComment");
    $countryManager->addChild("deleteAnyComment");
    $countryManager->addChild("updateAnyComment");
    $countryManager->addChild("flagNode");
    $countryManager->addChild("listFlagedNode");
    $countryManager->addChild("listFlagedComment");
    $countryManager->addChild("addNode");
    $countryManager->addChild("updateOwnAccount");
    $countryManager->addChild("updateOwnComment");
    $countryManager->addChild("deleteOwnComment");
    $countryManager->addChild("removeFlag");
    $countryManager->addChild("deleteOwnNode");
    
    // auth role
    $auth = $this->createRole("auth");
    $auth->addChild("likeNode");
    $auth->addChild("flagNode");
    $auth->addChild("updateOwnNode");
    $auth->addChild("postComment");
    $auth->addChild("addNode");
    $auth->addChild("updateOwnAccount");
    $auth->addChild("updateOwnComment");
    $auth->addChild("deleteOwnComment");
    $auth->addChild("deleteOwnNode");
    
    // guest role
    $guest = $this->createRole("guest");
    
    $uid = Yii::app()->user->id;
    if ($uid) {
      // 设置 用户角色给权限系统
      $user = UserAR::model()->findByPk($uid);
      if ($user && $user->role == UserAR::ROLE_ADMIN) {
        $this->assign("admin", $uid);
      }
      else if ($user && $user->role == UserAR::ROLE_COUNTRY_MANAGER) {
        $this->assign("countryManager", $uid);
      }
      else if ($user && $user->role == UserAR::ROLE_AUTHEN) {
        $this->assign("auth", $uid);
      }
    }
    
  }
  
}
