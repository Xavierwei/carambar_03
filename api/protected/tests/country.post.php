<?php

$http = "http://bankapi.local/index.php/country/post";
$req = curl_init();

curl_setopt($req, CURLOPT_POST, TRUE);
curl_setopt($req, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($req, CURLOPT_URL, $http);
curl_setopt($req, CURLOPT_POSTFIELDS, array(
    "country_name" => "Japan",
    "code" => "ja",
    "flag_icon"=> "flag",
));

$res = curl_exec($req);

echo $res;

