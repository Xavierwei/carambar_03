<?php

$I = new ApiGuy($scenario);
$I->wantTo("Update comment ");
$I->sendPost("comment/put", array(
    "cid" => 4,
    "content" => "from update from own of comment"
));
$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains('true');

