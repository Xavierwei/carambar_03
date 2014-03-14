<?php
$I = new ApiGuy($scenario);
$I->wantTo('Delete Country');
$I->sendPost('country/delete',array(
    "country_id" => "4",
));
$I->seeResponseCodeIs(200);
$I->seeResponseIsJson();
$I->seeResponseContains('"success":true');
?>
