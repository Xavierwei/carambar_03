Current phase template: <?php echo $phase;?>


<!-- 区域1 黄色 -->
<div class="section1">
	<!-- 视频区域 -->
	<div class="videopart videopart1 cs-clear">
		<!-- 视频 -->
		<div class="videomod">
			<iframe width="825" height="640" src="//www.youtube.com/embed/7-h4gSeXb5s?autoplay=1&rel=0" frameborder="0" allowfullscreen></iframe>
		</div>
		<!-- 视频评论 -->
		<!-- <div class="videotxt">
			<h2>#goodluckcarambar</h2>
			<div class="videotxt-item">
				<p> Trop drole Baptiste! Tu me fais trop rire ! I 3 Carambar!</p>
				<h3>#GOODLUCKCARAMBAR</h3>
				<span>@bonbon<span>
			</div>
			<div class="videotxt-item">
				<p> Trop drole Baptiste! Tu me fais trop rire ! I 3 Carambar!</p>
				<h3>#GOODLUCKCARAMBAR</h3>
				<span>@bonbon<span>
			</div>
			<div class="videotxt-item">
				<p> Trop drole Baptiste! Tu me fais trop rire ! I 3 Carambar!</p>
				<h3>#GOODLUCKCARAMBAR</h3>
				<span>@bonbon<span>
			</div>
		</div> -->
		<!-- 分享 -->
		<div class="videoshare">
			<a href="#" class="share-fb"></a>
			<a href="#" class="share-t"></a>
			<a href="#" class="share-y"></a>
			<a href="#" class="share-i"></a>
		</div>
	</div>
	<!-- 普通文字 -->
	<div class="sec1-txt">
		Carambar se lance la folle mission de faire rire<br />
		le pays le plus puissant du monde : les Etats-Unis.
	</div>
	<!-- 图片文字 -->
	<div class="sec1-txt">
		<img src="img/sec1_imgtxt1.png" />
	</div>
</div>


<!--------------------------------- Phase 1 -------------------------------->
<?php if($phase == '1'):?>
<!-- 区域2 红色 -->
<div class="section2 section2-1">
	<!-- 列表 -->
	<div class="sec2-ul  sec2-ul1 cs-clear">

		<?php foreach($voteVideos as $video):?>
			<div class="sec2-li">
				<div class="sec2-liv"><img src="./<?php echo str_replace('.jpg', '_238_123.jpg', $video->thumbnail);?>" /></div>
				<div class="sec2-lip"><?php echo $video->title;?></div>
				<div class="sec2-votebox" data-a="vote" data-d="vid=<?php echo $video->vid;?>">Vote Video <?php echo $video->vid;?></div>
			</div>
		<?php endforeach;?>

	</div>
	<div class="sec2-dot sec2-dot2"></div>
	<div class="sec2-tit"><img src="img/sec2-tit.png" /></div>
	<div class="sec2-time cs-clear">
		<div class="sec2-timeitem sec2-time-1">
			<div class="sec2-timebox">0</div>
			<div class="sec2-timebox">3</div>
			<span class="sec2-timetxt">JOURS</span>
		</div>
		<div class="sec2-timeitem sec2-time-2">
			<div class="sec2-timebox">2</div>
			<div class="sec2-timebox">3</div>
			<span class="sec2-timetxt">heures</span>
		</div>
		<div class="sec2-timeitem sec2-time-3">
			<div class="sec2-timebox">4</div>
			<div class="sec2-timebox">5</div>
			<span class="sec2-timetxt">minutes</span>
		</div>
		<div class="sec2-timeitem sec2-time-3">
			<div class="sec2-timebox">4</div>
			<div class="sec2-timebox">5</div>
			<span class="sec2-timetxt">secondes</span>
		</div>


		<div id="countdown">
			<div id="countdown-days"></div>
			<div id="countdown-hours"></div>
			<div id="countdown-minutes"></div>
			<div id="countdown-seconds"></div>
		</div>

	</div>
</div>
<?php endif;?>

<!--------------------------------- Phase 1-2 -------------------------------->
<?php if($phase == '1_2'):?>

<?php endif;?>

<!--------------------------------- Phase 2 -------------------------------->
<?php if($phase == '2'):?>

	<div class="vote-result">
		<?php foreach($voteResults as $vote):?>
			<?php echo round(($vote / $voteTotal) * 100);?>%
		<?php endforeach;?>
	</div>

<?php endif;?>

<!--------------------------------- Phase 3 -------------------------------->
<?php if($phase == '3'):?>
	<div class="section2">
		<h2 class="sec2-tit">toutes nos vidéos</h2>
		<!-- 列表 -->
		<div class="sec2-ul cs-clear">
			<?php foreach($homeVideos as $video):?>
				<div class="sec2-li">
					<div class="sec2-liv"><img src="./<?php echo str_replace('.jpg', '_297_177.jpg', $video->thumbnail);?>" /></div>
					<div class="sec2-litit"><?php echo $video->title;?></div>
				</div>
			<?php endforeach;?>
		</div>
	</div>
<?php endif;?>


<?php if($phase != '4'):?>
<!-- 区域3 白色 -->
<div class="section3">
	<!-- 普通文字 -->
	<div class="sec3-txt">soutenez-nous dès maintenant avec le hashtag</div>
	<!-- 图片文字 -->
	<div class="sec3-txt"><img src="img/sce3_imgtxt.png" /></div>
	<!-- 列表 -->
	<div class="sec3-scroll">
		<div class="sec3-ul cs-clear">
			<div class="sec3-item"></div>
			<div class="sec3-item"></div>
			<div class="sec3-item"></div>
		</div>
		<div class="sec3-arrow sec3-prev"></div>
		<div class="sec3-arrow sec3-next"></div>
	</div>
</div>
<?php endif;?>


<?php if($phase != '4'):?>
<!-- 区域4 黄色 -->
<div class="section4 cs-clear">
	<div class="sec4-left">
		<div class="sec4-left-tit"><img src="img/sce4-left-tit.gif" /></div>
		<div class="sec4-left-pho cs-clear">
			<img class="sec4-left-pho1" src="img/sec4_leftpho1.png" />
			<img class="sec4-left-pho2" src="img/sec4_leftpho2.png" />
		</div>
		<div class="sec4-left-txt">CHAQUE JOUR, LES 20 MEILLEURS  SOUTIENS SERONT Récompensés par un kit collector carambar!</div>
		<a href="#" class="sec4-left-btn"></a>
	</div>
	<div class="sec4-right">
		<div class="sec4-right-tit">Je poste mon soutien à carambar</div>
		<div class="sec4-right-txt">sur facebook <a href="#" id="facebook-login-link">Login Facebook</a></div>
		<div class="sec4-right-mess" id="facebook-content-wrap">
			<div class="sec4-right-con">
				<span># GOODLUCKCARAMBAR</span>
				<textarea id="facebook-content"></textarea>
			</div>
			<div class="sec4-right-info cs-clear">
				<div class="sec4-right-add" id="facebook-words-limit"><span>132</span>/140</div>
				<input type="submit" class="sec4-right-tweeter" data-a="submit-facebook" value="SUBMIT" />
			</div>
		</div>

		<div class="sec4-right-txt">sur twIter <a href="#" id="twitter-login-link">Login Twitter</a></div>
		<div class="sec4-right-mess" id="twitter-content-wrap">
			<div class="sec4-right-con">
				<span>#GOODLUCKCARAMBAR</span>
				<textarea id="twitter-content"></textarea>
			</div>
			<div class="sec4-right-info cs-clear">
				<div class="sec4-right-add" id="twitter-words-limit"><span>132</span>/140</div>
				<input type="submit" class="sec4-right-tweeter" data-a="submit-twitter" value="TWEETER" />
			</div>
		</div>
	</div>
</div>
<!--  -->
<?php endif;?>