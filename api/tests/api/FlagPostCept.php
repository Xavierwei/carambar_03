<?php

$I = new ApiGuy($scenario);
$I->wantTo("flag node");
$I->sendPOST("flag/post", array(
    "nid" => 63
));

$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains("true");

$I->wantTo("flag node");
$I->sendPOST("flag/post", array(
    "nid" => 63
));

$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains("flagged");

