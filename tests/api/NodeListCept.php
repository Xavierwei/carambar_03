<?php
$I = new ApiGuy($scenario);
$I->wantTo('Get node photo/video');
$I->sendGet('node/list?type=photo');
$I->seeResponseCodeIs(200);;
$I->seeResponseIsJson();
$I->seeResponseContains('"success":true');

$I->sendGet('node/list?type=video');
$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains('"success":true');
?>