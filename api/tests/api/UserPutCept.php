<?php
$I = new ApiGuy($scenario);
$I->wantTo('Post User');
$I->sendPost('user/put',array(
    "name" => "admin123",
    "country_id" => 1,
));
$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains('admin123');
?>
