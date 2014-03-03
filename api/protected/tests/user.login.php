<?php

$http = "http://bankapi.local/index.php/user/login";
$req = curl_init();

curl_setopt($req, CURLOPT_POST, TRUE);
curl_setopt($req, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($req, CURLOPT_URL, $http);
curl_setopt($req, CURLOPT_POSTFIELDS, array(
    "password" => "admin",
    "company_email" => "jziwenchen@gmail.com",
));

$res = curl_exec($req);

echo $res;