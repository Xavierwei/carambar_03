<body class="login-body">
  <div class="page login-page">
	  <!-- header -->
	  <div class="login-header">
		  <a href="<?php echo Yii::app()->request->baseUrl; ?>/../index" class="logo"></a>
	  </div>
	  <!--  -->
	  <form action="user/login" method="post">
		  <input name="username" class="form-control" type="text" value="" />
		  <input name="password" class="form-control" type="password" value="" />
		  <input type="submit" value="login" />
	  </form>

  </div>
</body>