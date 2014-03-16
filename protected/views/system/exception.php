
	<h1><?php echo $data['type']?></h1>

	<p class="message">
		<?php echo nl2br(htmlspecialchars($data['message'],ENT_QUOTES,Yii::app()->charset))?>
	</p>

	<div class="source">
		<p class="file"><?php echo htmlspecialchars($data['file'],ENT_QUOTES,Yii::app()->charset)."({$data['line']})"?></p>
		<?php echo $this->renderSourceCode($data['file'],$data['line'],$this->maxSourceLines); ?>
	</div>
