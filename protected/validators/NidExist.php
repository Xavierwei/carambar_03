<?php

/**
 * @author Jackey <jziwenchen@gmail.com>
 */
class NidExist extends CValidator {
  
  public function validateAttribute($object, $attribute) {
    $nid = $object->{$attribute};
    if (!$nid) return;
    
    $node = NodeAR::model()->findByPk($nid);
    
    if (!$node) {
      $this->addError($object, $attribute, Yii::t("strings", "node is not exist"));
    }
  }
}

