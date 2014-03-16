<?php

$I = new ApiGuy($scenario);
$I->wantTo("delete node flag");
$I->sendPOST("flag/deleteall", array(
    "nid" => 63
));

$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains("true");

