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
    $user = UserAR::model()->findByAttributes(array("name" => $this->username));
    if (!$user) {
      $this->errorCode = self::ERROR_USERNAME_INVALID;
    }
    else if ($user->sso_id != $this->password) {
      $this->errorCode = self::ERROR_PASSWORD_INVALID;
    }
    else {
		$this->_id = $user->uid;
		$this->setState("name", $user->name);
		$this->setState("role", $user->role);
		$this->setState("screen_name", $user->screen_name);
		$this->setState("personal_email", $user->personal_email);

		$this->errorCode = self::ERROR_NONE;
    }
    return !$this->errorCode;
  }

  public function getId() {
    return $this->_id;
  }
}