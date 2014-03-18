
<body>

	<div class="header">
		<div class="logo"><a href="<?php echo Yii::app()->request->baseUrl; ?>/index"><img src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/img/logo.png" /></a></div>
	</div>

	<div class="page-left">
		<ul class="menu" nav>
			<li><a rel="#/node" href="#/node"><em class="glyphicon glyphicon-th"></em> Contents</a></li>
			<li><a rel="#/comment" href="#/comment"><em class="glyphicon glyphicon-edit"></em> Comments</a></li>

			<li><a href="#/video"><em class="glyphicon glyphicon-play"></em> Video</a>
				<ul>
					<li><a rel="#/video/create" href="#/video/create"> Create</a></li>
					<li><a rel="#/video" href="#/video"> List</a></li>
				</ul>
			</li>
			<li><a rel="#/settings" href="#/settings"><em class="glyphicon glyphicon-wrench"></em> Settings</a></li>
			<li><a href="../user/samllogout"><em class="glyphicon glyphicon-log-out"></em> Logout</a></li>
		</ul>
	</div>

	<div class="page-right" ng-controller="CtrGlobal">
		<div ng-view></div>
	</div>

	<script>
		var apiToken = '<?php echo $token;?>';
	</script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/jquery-1.102.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/lib/angular/angular.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/lib/angular/angular-route.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/lib/angular/ui-bootstrap-0.9.0.min.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/lib/angular/ui-bootstrap-tpls-0.9.0.min.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/app.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/services.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/services/node.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/services/settings.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/services/user.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/services/like.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/services/comment.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/services/flag.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/services/video.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/lib.controllers.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/controllers.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/controllers/node.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/controllers/comment.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/controllers/settings.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/controllers/video.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/filters.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/directives.js"></script>
	<script src="<?php echo Yii::app()->request->baseUrl; ?>/admin_asset/js/imgHelper.js"></script>
</body>