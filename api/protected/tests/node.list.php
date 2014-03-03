<?php

$http = "http://bankapi.local/index.php/node/list";

$params = array(
    "type" => "photo",
    "orderby" => 'random'
);
$http .= '?'.http_build_query($params);

print $http;

die();
$req = curl_init();

curl_setopt($req, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($req, CURLOPT_URL, $http);

//curl_setopt($req, CURLOPT_HTTPHEADER, array("Content-Type: image/png"));
$res = curl_exec($req);

echo $res;

