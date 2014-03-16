<?php

$I = new ApiGuy($scenario);
$I->wantTo("Register new account when has login");
$I->sendPost("user/post", array(
    "firstname" => "Test guy",
    "lastname" => " name",
    "password" => "admin",
    "company_email" => "testguy1@mail.com",
    "personal_email" => "testguy1@mail.com",
    "country_id" => "1",
    "avatar" => "path/to/file.png"
));
$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains('"success":true');
$I->seeResponseContains("uid");



