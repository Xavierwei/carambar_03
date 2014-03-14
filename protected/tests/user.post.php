<?php

$http = "http://localhost/bank_wall/api/index.php/user/post";
$req = curl_init();

curl_setopt($req, CURLOPT_POST, TRUE);
curl_setopt($req, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($req, CURLOPT_URL, $http);
curl_setopt($req, CURLOPT_POSTFIELDS, array(
    "name" => "admin",
    "personal_email" => "jziwenchen@gmail.com",
    "company_email" => "jziwenchen@gmail.com",
    "password" => "admin",
    "firstname" => "Jackey",
    "lastname" => "Chen",
    "country_id" => 1
));

$res = curl_exec($req);

echo $res;