<?php
$I = new ApiGuy($scenario);
$I->wantTo('User Login');
$I->sendPost('user/loginform',array(
    "LoginForm[company_email]" => "testguy@mail.com",
    "LoginForm[password]" => "admin"
));
$I->haveHttpHeader("Content-Type" ,"application/x-www-form-urlencoded");
$I->seeResponseIsJson();
$I->seeCookie("PHPSESSID");
$I->seeResponseContains('not support yet');

// 登陆后 测试当前用户
$I = new ApiGuy($scenario);
$I->wantTo("Get current user");
$I->sendGet("user/getCurrent");
$I->seeResponseCodeIs(200);
$I->seeResponseContains('firstname');
$I->seeResponseIsJson();

?>