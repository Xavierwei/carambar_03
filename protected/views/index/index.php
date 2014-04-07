<div class="loading-overlay">
	<div class="loading-logo"><img src="images/loading_logo.png" /></div>
</div>
<div class="header"
     data-style="margin-top:-200px" data-animate="margin-top:0" data-delay="0" data-time="500" data-easing="easeOutQuart"
     data-0="transform:translate3d(0,0px,0);" data-500="transform:translate3d(0,50px,0);">
	<div class="hdcontent">
		<a class="nav1 nav1on" href="./"></a>
		<a class="nav2 show-desktop" href="./photowall.php"></a>
		<a class="nav2 show-mobile" href="./photowall-m.php"></a>
	</div>
</div>
<!--  -->
<div class="page phase<?php echo $phase;?>">
	<!-- #Presentation Block -->
	<div class="presentation">
		<?php if($phase == 1 || $phase == 2 || $phase == 3):?>
			<div class="skyline" style="background-position:center 90px" data-0="background-position:center 90px;" data-800="background-position:center -50px;"></div>
		<?php else:?>
			<div class="skyline" style="background-position:center 190px" data-0="background-position:center 190px;" data-800="background-position:center -100px;"></div>
		<?php endif;?>
		<?php if($phase == 1 || $phase == 2 || $phase == 3):?>
		<div class="blue-road"
		     data-style="opacity:0;" data-animate="opacity:1;" data-delay="0" data-time="800"></div>
		<div class="presentation-box">
			<div class="carambar-man" data-style="left:-1000px" data-animate="left:85px" data-delay="0" data-time="800" data-easing="easeOutQuart"></div>
			<?php if($phase == 1 || $phase == 2):?>
				<?php if($topVideo):?>
				<div class="tooltip" data-style="left:149px;opacity:0;" data-animate="left:249px;opacity:1;" data-delay="800" data-time="500">
					<div class="tips-content"></div>
					<div class="tips-video">
						<img src="./<?php echo str_replace('.jpg', '_224_115.jpg', $topVideo->thumbnail);?>" />
						<a class="video-play show-desktop" href="javascript:void(0);" data-a="open_video" data-d="mid=<?php echo $topVideo->mid;?>"></a>
						<a class="video-play show-mobile" href="https://www.youtube.com/watch?v=<?php echo $topVideo->mid;?>" target="_blank"></a>
					</div>
				</div>
				<?php endif;?>
			<?php endif;?>
			<?php if($phase == 3):?>
				<div class="tooltip" data-style="left:149px;opacity:0;" data-animate="left:249px;opacity:1;" data-delay="800" data-time="500">
					<div class="tips-content-p3">
						<div class="countdown">
							<span id="countdown-days"></span>
							<span id="countdown-hours"></span>
							<span id="countdown-minutes"></span>
							<span id="countdown-seconds"></span>
						</div>
					</div>
				</div>
			<?php endif;?>
			<div class="indicator-count-wrap"
			     data-style="opacity:0;" data-animate="opacity:1;" data-delay="1000" data-time="500">
				<div class="indicator-title">Nombre de soutiens récoltés</div>
				<div class="indicator-count"></div>
				<div class="indicator-count-num"></div>
				<div class="indicator-hashtag">#GOODLUCKCARAMBAR</div>
				<div class="indicator-btn" data-a="indicate"></div>
			</div>
		</div>
		<?php endif;?>
		<?php if($phase == 4 || $phase == 5):?>
		<div class="videopart cs-clear">
			<?php if($topVideo): ?>
			<div class="videopart-tit">
				<div class="robbion-icon"></div>
				<div class="videopart-tit-defi videopart-tit-defi<?php echo $topVideo->rank;?>"><?php echo $topVideo->title;?></div>
			</div>
			<?php endif;?>
			<!-- Video -->
			<div class="videomod">
			<?php if($topVideo): ?>
				<iframe width="548" height="304" src="//www.youtube.com/embed/<?php echo $topVideo->mid;?>?rel=0&wmode=transparent" frameborder="0" allowfullscreen></iframe>
			<?php endif;?>
			</div>
			<!-- Twitter -->
			<div class="videotxt-wrap">
				<div class="videotxt"></div>
			</div>
			<!--  -->
			<div class="videobot"></div>
			<!-- 分享 -->
			<div class="videoshare">
				<!-- <a href="#" class="videoshare-fb"></a> -->
				<a href="#" class="videoshare-t"></a>
				<!-- <a href="#" class="videoshare-y"></a> -->
				<!-- <a href="#" class="videoshare-i"></a> -->
			</div>
			<a href="javascript:;" data-a="goto_challenge" class="btn-other-challenges"></a>
		</div>

			<?php if($phase == 4):?>
			<!-- section blue -->
			<div class="sec-blue">
				<div class="sec-bluecon cs-clear">
					<div class="sec-bluepho">
						<div class="countdown">
							<span id="countdown-days"></span>
							<span id="countdown-hours"></span>
							<span id="countdown-minutes"></span>
							<span id="countdown-seconds"></span>
						</div>
					</div>
					<div class="indicator-count-wrap">
						<div class="indicator-title">Nombre de soutiens récoltés</div>
						<div class="indicator-count"></div>
						<div class="indicator-count-num"></div>
						<div class="indicator-hashtag">#GOODLUCKCARAMBAR</div>
						<div class="indicator-btn" data-a="indicate"></div>
					</div>
				</div>
			</div>
			<?php else:?>
				<div class="sec-blue2">
					<div class="sec-blue2txt">
						<div class="indicator-count-wrap">
							<div class="indicator-count"></div>
							<div class="indicator-count-num"></div>
						</div>
					</div>

				</div>
				<div class="line line4"></div>
			<?php endif;?>

		<?php endif;?>

		<?php if($phase != 5):?>
		<div class="goto-support-bg">
			<a href="javascript:;" data-a="goto_support" class="goto-support">ET TENTEZ DE GAGNER DE NOMBREUX CADEAUX ICI</a>
		</div>
		<?php endif;?>
	</div>
	<!-- /Presentation Block -->
	<!-- #Challenge Block -->
	<div class="challenge_bg">
		<div class="map_bg"
		     data-0="transform:translate3d(0,0px,0);" data-1500="transform:translate3d(0,-400px,0);"></div>
	</div>
	<?php if($phase == 1 || $phase == 2):?>
	<div class="challenge">
		<div class="challenge-title" data-style="opacity:0;" data-animate="opacity:1;" data-delay="200" data-time="800"></div>
		<div class="challenge-inner" data-646="transform:translate3d(0,0px,0);" data-1200="transform:translate3d(0,100px,0);">
			<div class="challenge-item" data-style="opacity:0;" data-animate="opacity:1;" data-delay="100" data-time="800">
				<div class="challenge-img">
					<img src="pic/challenge1.jpg" />
				</div>
				<div class="vote-btn vote-btn1" data-a="vote" data-d="cid=1">DEFI No1</div>
			</div>
			<div class="challenge-item" data-style="opacity:0;" data-animate="opacity:1;" data-delay="200" data-time="800">
				<div class="challenge-img">
					<img src="pic/challenge2.jpg" />
				</div>
				<div class="vote-btn vote-btn2" data-a="vote" data-d="cid=2">DEFI No2</div>
			</div>
			<div class="challenge-item" data-style="opacity:0;" data-animate="opacity:1;" data-delay="300" data-time="800">
				<div class="challenge-img">
					<img src="pic/challenge3.jpg" />
				</div>
				<div class="vote-btn vote-btn3" data-a="vote" data-d="cid=3">DEFI No3</div>
			</div>
		</div>
		<div class="challenge-man" data-300="transform:translate3d(0,0px,0);" data-400="transform:translate3d(0,-259px,0);"></div>
	</div>
	<?php endif;?>
	<?php if($phase == 3 || $phase == 4 || $phase == 5):?>
	<div class="videolistbg">
		<?php if($phase == 5):?>
			<div class="videolist-tit2"></div>
		<?php else:?>
			<div class="videolist-tit"></div>
		<?php endif;?>
		<div class="videolist">
			<div class="videolistshare">
				<div class="video-con">
					<?php
						$videoCount = 0;
						foreach($homeVideos as $index=>$video):
							if($video->rank == 9 || $videoCount == 8) {continue;}
							$videoCount++;

					?>
						<div class="videolist-item">
							<div class="videolist-item-tit videolist-item-tit<?php echo $index+1;?>"></div>
							<div class="videolist-box">
								<img src="./<?php echo str_replace('.jpg', '_248_132.jpg', $video->thumbnail);?>" />
								<a data-d="mid=<?php echo $video->mid;?>" data-a="open_video" href="javascript:void(0);" class="video-play show-desktop"></a>
								<a href="https://www.youtube.com/watch?v=<?php echo $video->mid;?>" target="_blank" class="video-play show-mobile"></a>
							</div>
							<div class="videolist-txt"><?php echo $video->title;?></div>
							<div class="video-icon video-icon-<?php echo $video->ribbon;?>"></div>
						</div>
					<?php endforeach;?>
					<?php
						if($videoCount < 8):
					?>
						<div class="videolist-item">
							<div class="videolist-item-tit videolist-item-tit0"></div>
							<div class="videolist-boxnull">des défis de plus en plus fous...</div>
						</div>
					<?php endif;?>
					<?php
					$video6 = 0;
					foreach($homeVideos as $index=>$video):
						if($video->rank != 9) {continue;}
						$video6++;
						?>
						<div class="videolist-item">
							<div class="videolist-item-tit videolist-item-tit9"></div>
							<div class="videolist-box">
								<img src="./<?php echo str_replace('.jpg', '_248_132.jpg', $video->thumbnail);?>" />
								<a data-d="mid=<?php echo $video->mid;?>" data-a="open_video" href="javascript:void(0);" class="video-play show-desktop"></a>
								<a href="https://www.youtube.com/watch?v=<?php echo $video->mid;?>" target="_blank" class="video-play show-mobile"></a>
							</div>
							<div class="videolist-txt"><?php echo $video->title;?></div>
							<div class="video-icon video-icon-<?php echo $video->ribbon;?>"></div>
						</div>
					<?php endforeach;?>
					<?php if($video6 == 0):?>
						<div class="videolist-item">
							<div class="videolist-item-tit videolist-item-tit9-2"></div>
							<div class="videolist-boxnull">
								<img src="./pic/vos3.jpg" />
							</div>
							<div class="videolist-txt">Arriver à faire rire un staDE, <br/>UNE STAR ET UN MAX D’américains ! </div>
						</div>
					<?php endif;?>
					<div class="cs-clear"></div>
				</div>
			</div>
		</div>
		<div class="challenge-man" data-600="transform:translate3d(0,0px,0);" data-700="transform:translate3d(0,-259px,0);"></div>
	</div>
	<?php endif;?>

	<!-- /Challenge Block -->

	<div class="yellow-wrap">
		<?php if($phase == 1):?>
		<!-- line -->
		<div class="line line-p1">
			<div class="line-com-p1"></div>
		</div>
		<?php endif;?>
		<?php if(0):?>
		<!-- #barack -->
		<div class="barack">
			<div class="baracktit"></div>
			<div class="barackbtn" data-a="open_invitation"></div>
		</div>
		<!-- /barack -->
		<?php endif;?>

		<?php if($phase == 1 || $phase == 2 || $phase == 3 || $phase == 4):?>
		<!--  -->
		<div class="support-carambar-wrap">
			<div id="support-carambar" class="img">
				<div class="img1"></div>
				<div class="img2"></div>
				<div class="img3"></div>
			</div>
		</div>
		<!--  -->
		<div class="share">
			<div class="share-fb">
<!--				<a href="javascript:void(0)" data-a="open_facebook" class="share-fbbtn"></a>-->
				<a href="javascript:void(0)" id="facebook-login-link" class="share-fbbtn"></a>
			</div>
			<div class="share-t">
				<textarea class="share-txt" id="twitter-content"></textarea>
				<p class="share-t-num" id="twitter-words-limit"><span>122</span>/140</p>
				<a target="_blank" href="javascript:transfoWebo(86)" class="share-tbtn disabled" data-a="share_twitter"></a>

			</div>
			<div class="share-i cs-clear">
				<a target="_blank" href="https://play.google.com/store/apps/details?id=com.instagram.android&hl=fr" class="share-iandroid"></a>
				<a target="_blank" href="https://itunes.apple.com/fr/app/instagram/id389801252?mt=8" class="share-iios"></a>
			</div>
		</div>
		<!--  -->
		<div class="tshirttit"></div>
		<!--  -->
		<div class="tshirt">
			<div class="tshirt1"></div>
			<div class="tshirt2"></div>
		</div>
		<!--  -->
		<?php endif;?>
		<div class="photit"></div>
		<!--  -->
		<div class="pholist cs-clear">
			<div class="pholist-loading"></div>
		</div>
		<!-- line -->
		<div class="line line3">
			<a href="./photowall.php" class="line-com3 show-desktop"></a>
			<a href="./photowall-m.php" class="line-com3 show-mobile"></a>
		</div>
		<!--  -->
	</div>


	<!-- footer -->
	<div class="footer">
		<div class="footer-inner">
			jeu gratuit sans obligation d’achat du 25/03/2014 au 11/04/2014. à gagner 360 kits supporters collectors d’une valeur commerciale approximative de 12,50€. retrouvez l’ensemble des modalités en consultant le <a target="_blank" href="./pdf/reglement_glc.pdf">reglement complet du jeu</a>.
			<div class="footer-links">
				<a target="_blank" href="./pdf/vie_privee_glc.pdf">Vie privée</a> /
				<a target="_blank" href="./pdf/cookies_glc.pdf">Cookies</a> /
				<a target="_blank" href="./pdf/mentions_legales_glc.pdf">Mentions légales</a> /
				<a target="_blank" href="./pdf/mentions_sanitaires_glc.pdf">Mentions sanitaires</a>
			</div>
		</div>
	</div>
</div>

<div class="overlay" data-a="close_popup"></div>


<!-- Templates -->
<!-- #youtube-player-tpl -->
<script type="text/tpl" id="youtube-player-template">
	<div class="pop video-popup" data-a="close_popup">
		<div class="popup-close"></div>
		<iframe width="825" height="640" src="//www.youtube.com/embed/{{mid}}?autoplay=1&rel=0" frameborder="0" allowfullscreen></iframe>
	</div>
</script>
<!-- /youtube-player-tpl -->

<!-- #facebook-post-tpl -->
<script type="text/tpl" id="facebook-post-template">
	<div class="pop pop-fb">
		<div class="pop-close" data-a="close_popup"></div>
		<div class="facebook-post-form">
			{{#if oldie}}
			<div class="flash_facebook_uploader">
				<div class="pop-fttit">PUBLIER VOTRE SOUTIEN avec le <span>#goodluckcarambar</span></div>
				<object id="flash_fb" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="820" height="366">
					<param name="allowScriptAccess" value="always"/>
					<param name="movie" value="flash/main.swf"/>
					<param name="quality" value="high"/>
					<param name="wmode" value="transparent"/>
					<param name="flashVars" value="xml=flash/xml/config.xml"/>
					<embed name="flash" src="flash/main.swf" quality="high" wmode="transparent" flashVars="xml=flash/xml/config.xml" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="820" height="366" allowScriptAccess="always"></embed>
				</object>
				<div class="pop-ft-submitting">Submitting</div>
			</div>
			{{else}}
			<div class="pop-fttit">PUBLIER VOTRE SOUTIEN avec le <span>#goodluckcarambar</span></div>
			<div class="pop-ft-form cs-clear">
				<div class="facebook-post-img-wrap">
					<div class="facebook-post-img" id="fileupload">
						<input type="file" accept="image/*" name="file">
					</div>

					<div class="facebook-post-load">
						<div class="popload-percent"><p></p></div>
						<div class="popload-text">Téléchargement en cours…</div>
					</div>

					<div class="poptxt-pic">
						<a class="pop-zoomout-btn" data-a="pop-zoomout-btn" href="javascript:void(0)">Zoom In</a>
						<a class="pop-zoomin-btn" data-a="pop-zoomin-btn" href="javascript:void(0)">Zoom Out</a>
						<div class="poptxt-pic-inner">
							<img style="pointer-events:none" />
						</div>
					</div>
				</div>
				<div class="pop-ft-text">
					<div class="pop-ft-ftit">votre commentaire</div>
					<input id="facebook-img" type="hidden" />
					<textarea id="facebook-content"></textarea>
				</div>
			</div>
			<ul class="step1-tips">
				<li>Votre photo doit être au format JPG, PNG ou GIF</li>
				<li>La taille de votre fichier ne doit pas dépasser 5MB</li>
				<li class="damaged">La photo que vous avez téléchargé est corrompu</li>
			</ul>
			<div class="pop-ft-check" data-a="facebook_check">
				<div class="pop-ft-check-inner">
					<span>j'ai lu et j'accepte le règlement du jeu</span>
				</div>
			</div>
			<div class="pop-ft-icon"></div>
			<div class="pop-ft-btn disabled" data-a="submit_facebook"></div>
			<div class="pop-ft-submitting">Submitting</div>
			{{/if}}
		</div>

		<div class="facebook-post-success">
			Soumis avec succès, merci！
		</div>
	</div>
</script>
<!-- #facebook-post-tpl -->

<!-- #photowall-item-tpl -->
<script type="text/tpl" id="photowall-item-template">
	<a href="./photowall.php#/nid/{{nid}}" class="phoitem show-desktop">
		<img src="./{{thumbnail}}">
	</a>
	<a href="./photowall-m.php#/nid/{{nid}}" class="phoitem show-mobile">
		<img src="./{{thumbnail}}">
	</a>
</script>
<!-- /youtube-player-tpl -->

<!-- #send-invitation-tpl -->
<script type="text/tpl" id="send-invitation-template">
	<div class="pop pop-bar">
		<div class="pop-close" data-a="close_popup"></div>
		<div class="pop-bar-txt"></div>
		<input id="invitation_answer" type="text" class="pop-bar-input">
		<div class="pop-bar-btn" data-a="send_invitation"></div>
		<div class="pop-bar-tips">
			<p></p>
		</div>
	</div>
</script>
<!-- #send-invitation-tpl -->

<!-- #send-invitation-tpl -->
<script type="text/tpl" id="videotxt-item-template">
	<div class="videotxt-item">
		<p>{{description}}</p>
		<h3>#GOODLUCKCARAMBAR</h3>
		<span>@{{screen_name}}</span>
	</div>
</script>
<!-- #send-invitation-tpl -->
