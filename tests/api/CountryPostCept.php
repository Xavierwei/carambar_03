<?php
$I = new ApiGuy($scenario);
$I->wantTo('Post Country');
$I->sendPost('country/post',array(
    "country_name" => "French",
    "code" => "fr",
    "flag_icon"=> "flag",
));
$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains('"success":true');
?>
