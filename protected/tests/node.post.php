<?php

$http = "http://localhost:8888/bank_wall/api/index.php?r=/node/post";
$req = curl_init();

curl_setopt($req, CURLOPT_POST, TRUE);
curl_setopt($req, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($req, CURLOPT_URL, $http);
curl_setopt($req, CURLOPT_POSTFIELDS, array(
    "description" => "I am at #Starbar and work for #Shanghai Company",
    "photo" => "@/Applications/MAMP/htdocs/bank_wall/web/photo/1.jpg;type=image/jpg",
    //"video" => "@/home/jackey/Videos/t3.avi"
));

// 发送cookie
$cookie = "PHPSESSID=ee2271830dc379927f80bff5f8992c41";
curl_setopt($req, CURLOPT_COOKIE, $cookie);

//curl_setopt($req, CURLOPT_HTTPHEADER, array("Content-Type: image/png"));
$res = curl_exec($req);

echo $res;

