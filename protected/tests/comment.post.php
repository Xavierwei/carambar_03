<?php

$http = "http://bankapi.local/index.php/comment/post";
$req = curl_init();

curl_setopt($req, CURLOPT_POST, TRUE);
curl_setopt($req, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($req, CURLOPT_URL, $http);
curl_setopt($req, CURLOPT_POSTFIELDS, array(
    "content" => "I am at #Starbar and work for #Shanghai Company",
    "nid" => 1,
));

//curl_setopt($req, CURLOPT_HTTPHEADER, array("Content-Type: image/png"));
$res = curl_exec($req);

echo $res;

