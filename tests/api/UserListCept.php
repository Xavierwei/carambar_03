<?php
$I = new ApiGuy($scenario);
$I->wantTo('Get User List');
$I->sendGet('user/list', array(
    //"role" => 2,
    "orderby" => "datetime"
));
$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains('"success":true');
?>