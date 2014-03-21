<body class="login-body">
  <div class="page login-page">
	  <!-- header -->
	  <div class="login-header">
		  <a href="<?php echo Yii::app()->request->baseUrl; ?>/index" class="logo"></a>
	  </div>
	  <!--  -->
	  <form action="<?php echo Yii::app()->request->baseUrl; ?>/user/login" method="post">
		  <label>Username:</label><input name="username" class="form-control" type="text" value="" />
		  <label>Password:</label><input name="password" class="form-control" type="password" value="" />
		  <input class="btn btn-danger" type="submit" value="login" />
	  </form>

  </div>
</body>