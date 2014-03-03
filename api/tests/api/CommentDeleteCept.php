<?php

$I = new ApiGuy($scenario);
$I->wantTo("Delete comment list");
$I->sendPost("comment/delete", array(
    "cid" => 3
));
$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains('true');

