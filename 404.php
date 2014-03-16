<?php $path = '/bank_wall/';?>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>L'ESPRIT D'EQUIPE SOCIETE GENERALE</title>
    <link href="<?php echo $path;?>css/layout.css" rel="stylesheet" type="text/css" />
	<link href="<?php echo $path;?>css/fonts.css" rel="stylesheet" type="text/css" />
</head>
<body class="error-404-wrap">
<div class="header">
	<a class="logo" href="<?php echo $path;?>"></a>
</div>
<div class="error-404">
	<h3>404</h3>
	<?php if(isset($_COOKIE['lang']) && $_COOKIE['lang'] == 'en'):?>
		<h5>The page you are looking for was not found.</h5>
	<?else:?>
		<h5>La page que vous cherchez est introuvable.</h5>
	<?endif;?>
</div>

</body>
</html>