<?php

/**
 * @author Jackey <jziwenchen@gmail.com>
 */
class CidExist extends CValidator {
  
  public function validateAttribute($object, $attribute) {
    $cid = $object->{$attribute};
    // 只有在cid 设置了情况下 进行检验
    if (!$cid) return;
    
    $comment = CommentAR::model()->findByPk($cid);
    
    if (!$comment) {
      $this->addError($object, $attribute, Yii::t("strings", "comment is not exist"));
    }
  }
}

