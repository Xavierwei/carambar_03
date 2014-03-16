<?php

class CountryController extends Controller {
  
  public function actionList() {
    $request = Yii::app()->getRequest();

    $query = new CDbCriteria();
    $query->order = 'country_name';
    $countryAr = new CountryAR();
    $list = $countryAr->findAll($query);
    
    $retdata = array();
    foreach ($list as $country) {
      $retdata[] = $country->attributes;
    }

//		foreach($retdata as $country) {
//			echo 'msgid "'.str_replace(' ','_',strtoupper($country['country_name'])).'"<br/>';
//			echo 'msgstr "'.$country['country_name'].'"<br/><br/>';
//		}

    $this->responseJSON($retdata, "success");
  }
  
  public function actionPost() {
    $request = Yii::app()->getRequest();
    
    if (!$request->isPostRequest) {
      $this->responseError("http error");
    }
    
    if (!Yii::app()->user->checkAccess("addCountry")) {
      return $this->responseError("permission deny");
    }
    
    $countryAr = new CountryAR();
    
    $country_id = $countryAr->postNewCountry();
    
    if ($country_id) {
      $country = CountryAR::model()->findByPk($country_id);
      $this->responseJSON($country->attributes, "success");
    }
    else {
      $errors = $countryAr->getErrors();
      $this->responseError("invalid error: ". print_r($errors, TRUE));
    }
  }
  
  public function actionPut() {
    $request = Yii::app()->getRequest();
    
    if (!$request->isPostRequest) {
      $this->responseError("http error");
    }
    
    if (!Yii::app()->user->checkAccess("updateCountry")) {
      return $this->responseError("permission deny");
    }
    
    $countryAr = new CountryAR();
    $country_id = $request->getPost("country_id");
    
    if (!$country_id) {
      $this->responseError("invalid params");
    }
    
    $country = CountryAR::model()->findByPk($country_id);
    
    if (!$country) {
      $this->responseError("invalid params");
    }
    foreach ($_POST as $key => $value) {
      $country->{$key} = $value;
    }
    CountryAR::model()->updateByPk($country_id, $country->attributes);
    
    $this->responseJSON($country->attributes, "success");
  }
  
  public function actionDelete() {
    $request = Yii::app()->getRequest();
    
    if (!$request->isPostRequest) {
      $this->responseError("http error");
    }
    
    if (!Yii::app()->user->checkAccess("deleteCountry")) {
      return $this->responseError("permission deny");
    }
    
    $country_id = $request->getPost("country_id");
    
    if (!$country_id) {
      $this->responseError("invalid params");
    }
    
    $country = CountryAR::model()->findByPk($country_id);
    if (!$country) {
      $this->responseError("not found country");
    }
    
    CountryAR::model()->deleteByPk($country_id);
    
    $this->responseJSON($country->attributes, "success");
  }

	public function actionImport() {
		$string = '[ { "country_id": 1, "country": "South Africa" }, { "country_id": 2, "country": "Albania" }, { "country_id": 3, "country": "Algeria" }, { "country_id": 4, "country": "Germany" }, { "country_id": 5, "country": "Saudi" }, { "country_id": 6, "country": "Arabia" }, { "country_id": 7, "country": "Argentina" }, { "country_id": 8, "country": "Australia" }, { "country_id": 9, "country": "Austria" }, { "country_id": 10, "country": "Bahamas" }, { "country_id": 11, "country": "Belgium" }, { "country_id": 12, "country": "Benin" }, { "country_id": 13, "country": "Brazil" }, { "country_id": 14, "country": "Bulgaria" }, { "country_id": 15, "country": "Burkina Faso" }, { "country_id": 16, "country": "Canada" }, { "country_id": 17, "country": "Chile" }, { "country_id": 18, "country": "China" }, { "country_id": 19, "country": "Cyprus" }, { "country_id": 20, "country": "Korea" }, { "country_id": 21, "country": "Republic of Ivory Coast" }, { "country_id": 22, "country": "Croatia" }, { "country_id": 23, "country": "Denmark" }, { "country_id": 24, "country": "Egypt" }, { "country_id": 25, "country": "United Arab Emirates" }, { "country_id": 26, "country": "Spain" }, { "country_id": 27, "country": "Estonia" }, { "country_id": 28, "country": "USA" }, { "country_id": 29, "country": "Finland" }, { "country_id": 30, "country": "France" }, { "country_id": 31, "country": "Georgia" }, { "country_id": 32, "country": "Ghana" }, { "country_id": 33, "country": "Greece" }, { "country_id": 34, "country": "Guinea" }, { "country_id": 35, "country": "Equatorial Guinea" }, { "country_id": 36, "country": "Hungary" }, { "country_id": 37, "country": "India" }, { "country_id": 38, "country": "Ireland" }, { "country_id": 39, "country": "Italy" }, { "country_id": 40, "country": "Japan" }, { "country_id": 41, "country": "Jordan" }, { "country_id": 42, "country": "Latvia" }, { "country_id": 43, "country": "Lebanon" }, { "country_id": 44, "country": "Lithuania" }, { "country_id": 45, "country": "Luxembourg" }, { "country_id": 46, "country": "Macedonia" }, { "country_id": 47, "country": "Madagascar" }, { "country_id": 48, "country": "Morocco" }, { "country_id": 49, "country": "Mauritania" }, { "country_id": 50, "country": "Mexico" }, { "country_id": 51, "country": "Moldova" }, { "country_id": 52, "country": "Republic of Montenegro" }, { "country_id": 53, "country": "Norway" }, { "country_id": 54, "country": "New Caledonia" }, { "country_id": 55, "country": "Panama" }, { "country_id": 56, "country": "Netherlands" }, { "country_id": 57, "country": "Peru" }, { "country_id": 58, "country": "Poland" }, { "country_id": 59, "country": "Portugal" }, { "country_id": 60, "country": "Reunion" }, { "country_id": 61, "country": "Romania" }, { "country_id": 62, "country": "UK" }, { "country_id": 63, "country": "Russian Federation" }, { "country_id": 64, "country": "Senegal" }, { "country_id": 65, "country": "Serbia" }, { "country_id": 66, "country": "Singapore" }, { "country_id": 67, "country": "Slovakia" }, { "country_id": 68, "country": "Slovenia" }, { "country_id": 69, "country": "Sweden" }, { "country_id": 70, "country": "Switzerland" }, { "country_id": 71, "country": "Chad" }, { "country_id": 72, "country": "Czech Republic" }, { "country_id": 73, "country": "Tunisia" }, { "country_id": 74, "country": "Turkey" }, { "country_id": 75, "country": "Ukraine" }, { "country_id": 76, "country": "Uruguay" }, { "country_id": 77, "country": "Vietnam" } ]';
		$countrylist = json_decode($string);
		foreach($countrylist as $country) {
			$countryAr = new CountryAR();
			$countryAr->attributes = array(
				"country_name" => $country->country,
				"code" => strtolower($country->country),
				"flag_icon" => strtolower($country->country)
			);
			$country_id = $countryAr->save();
		}
	}
}

