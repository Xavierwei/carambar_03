<?php

$http = "http://bankapi.local/index.php/comment/searchByKeyword";
$req = curl_init();

curl_setopt($req, CURLOPT_POST, TRUE);
curl_setopt($req, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($req, CURLOPT_URL, $http);
curl_setopt($req, CURLOPT_POSTFIELDS, array(
    "keyword" => "Shanghai",
    "page" => 1,
    "pagenum" => 10,
    "orderby" => "datetime"
));

//curl_setopt($req, CURLOPT_HTTPHEADER, array("Content-Type: image/png"));
$res = curl_exec($req);

echo $res;

