<?php

$uid = 10;
$I = new ApiGuy($scenario);
$I->wantTo("Delete user with ud");
$I->sendPOST("user/delete", array(
    "uid" => 34
));
$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains('"success":true');

