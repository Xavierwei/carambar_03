<?php

/**
 * UserIdentity represents the data needed to identity a user.
 * It contains the authentication method that checks if the provided
 * data can identity the user.
 */
class UserIdentity extends CUserIdentity
{
  private $_id = NULL;
  
  public function authenticate()
  {
    $user = UserAR::model()->findByAttributes(array("company_email" => $this->username));
    if (!$user) {
      $this->errorCode = self::ERROR_USERNAME_INVALID;
    }
    else if ($user->sso_id != md5($this->password)) {
      $this->errorCode = self::ERROR_PASSWORD_INVALID;
    }
    else {
      $this->_id = $user->uid;
      $this->setState("name", $user->name);
      $this->setState("country_id", $user->country_id);
      $this->setState("role", $user->role);
      
      $this->errorCode = self::ERROR_NONE;
    }
    return !$this->errorCode;
  }

  public function getId() {
    return $this->_id;
  }
}