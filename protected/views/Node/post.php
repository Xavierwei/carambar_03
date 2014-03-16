<?php if($code == 1): ?>
	<script>
		window.top.closeUploadPop();
	</script>
<?php else:?>
	<script>
		window.top.uploadPopError(<?php echo $code;?>);
	</script>
<?php endif;?>