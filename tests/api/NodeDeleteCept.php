<?php
$I = new ApiGuy($scenario);
$I->wantTo("Delete one node");
$I->sendPost("node/delete", array(
    "nid" => 61
));

//$I->seeResponseCodeIs(200);
//$I->seeResponseIsJson();
$I->seeResponseContains('"success":true');


?>