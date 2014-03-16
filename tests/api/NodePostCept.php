<?php
$I = new ApiGuy($scenario);
$I->wantTo('Post Photo');
$I->sendPost('node/post', array(
    "description" => "I am from test",
    "photo" => "@/home/jackey/Pictures/test.png"
));
$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains('"success":true');
$I->seeResponseContains("nid");

$I = new ApiGuy($scenario);
$I->wantTo("Post Video");
$I->sendPost("node/post", array(
    "description" => "I am video from #shanghai",
    "video" => "@/home/jackey/Videos/t2.avi",
));

$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains('"success":true');
$I->seeResponseContains("nid");

?>