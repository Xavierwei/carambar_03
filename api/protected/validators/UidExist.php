<?php

/**
 * @author Jackey <jziwenchen@gmail.com>
 */
class UidExist extends CValidator {
  
  public function validateAttribute($object, $attribute) {
    $uid = $object->{$attribute};
    
    $user = UserAR::model()->findByPk($uid);
    
    if (!$user) {
      $this->addError($object, $attribute, Yii::t("strings", "user is not exist"));
    }
  }
}

