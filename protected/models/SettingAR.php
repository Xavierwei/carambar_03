<?php

class SettingAR extends CActiveRecord{


	public function tableName() {
		return "setting";
	}

	public function primaryKey() {
		return "sid";
	}

	public static function model($class = __CLASS__) {
		return parent::model($class);
	}

	// Validation rules
	public function rules() {
		return array(
			array("setting_key, setting_value", 'required'),
		);
	}


	public function getValue($key) {

		$query = new CDbCriteria();
		$query->addCondition('setting_key=:setting_key');
		$query->params[':setting_key'] = $key;
		$res = $this->find($query);

		return $res->setting_value;
	}

    public function setValue($key,$val){
        $query = new CDbCriteria();
        $query->addCondition('setting_key=:setting_key');
        $query->params[':setting_key'] = $key;
        $res = $this->find($query);

        $res->setting_value=$val;
        if($res->save())
            return $res->setting_value;
        else
            return false;
    }

}
