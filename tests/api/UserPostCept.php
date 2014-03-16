<?php
$I = new ApiGuy($scenario);
$I->wantTo('Post User');
$I->sendPost('user/post',array(
    "name" => "admin",
    "personal_email" => "test@gmail.com",
    "company_email" => "test@gmail.com",
    "password" => "admin",
    "firstname" => "test",
    "lastname" => "try",
    "country_id" => 1
));
$I->seeResponseIsJson();
$I->seeResponseContains('test@gmail.com');
?>
