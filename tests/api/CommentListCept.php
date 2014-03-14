<?php

$I = new ApiGuy($scenario);
$I->wantTo("Get comment list");
$I->sendGET("comment/list?nid=33&shownode=true");
$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
// Only node object contains file field
$I->seeResponseContains('file');

