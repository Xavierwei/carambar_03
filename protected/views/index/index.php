<div class="header"
     data-style="margin-top:-200px" data-animate="margin-top:0" data-delay="0" data-time="500" data-easing="easeOutQuart"
     data-0="transform:translate3d(0,0px,0);" data-500="transform:translate3d(0,50px,0);">
	<div class="hdcontent">
		<a class="nav1 nav1on" href="#"></a>
		<a class="nav2" href="#"></a>
	</div>
</div>
<!--  -->
<div class="page phase<?php echo $phase;?>">
	<!-- #Presentation Block -->
	<div class="presentation">
		<div class="skyline"
		     data-0="transform:translate3d(0,0px,0);" data-500="transform:translate3d(0,100px,0);"></div>
		<?php if($phase == 1 || $phase == 2 || $phase == 3):?>
		<div class="blue-road"
		     data-style="opacity:0;" data-animate="opacity:1;" data-delay="0" data-time="800"
		     data-0="transform:translate3d(0,0px,0);" data-500="transform:translate3d(0,50px,0);"></div>
		<div class="presentation-box">
			<div class="carambar-man" data-style="left:-1000px" data-animate="left:85px" data-delay="0" data-time="800" data-easing="easeOutQuart"></div>
			<?php if($phase == 1 || $phase == 2):?>
			<div class="tooltip" data-style="left:149px;opacity:0;" data-animate="left:249px;opacity:1;" data-delay="800" data-time="500">
				<div class="tips-content"></div>
				<div class="tips-video">
					<img src="pic/presentation-video.jpg" />
					<a class="video-play" href="javascript:void(0);" data-a="open_video" data-d="mid="></a>
				</div>
			</div>
			<?php endif;?>
			<?php if($phase == 3):?>
				<div class="tooltip" data-style="left:149px;opacity:0;" data-animate="left:249px;opacity:1;" data-delay="800" data-time="500">
					<div class="tips-content-p3"></div>
				</div>
			<?php endif;?>
			<div class="indicator-count-wrap"
			     data-style="opacity:0;" data-animate="opacity:1;" data-delay="1000" data-time="500"
			     data-0="transform:translate3d(0,0px,0);" data-500="transform:translate3d(0,50px,0);">
				<div class="indicator-title">Nombre de soutiens récoltés</div>
				<div class="indicator-count"></div>
				<div class="indicator-hashtag">#GOODLUCKCARAMBAR</div>
				<div class="indicator-btn" data-a="indicate"></div>
			</div>
		</div>
		<div class="goto-support-bg" data-0="transform:translate3d(0,0px,0);" data-500="transform:translate3d(0,70px,0);">
			<a href="#" class="goto-support">ET TENTEZ DE GAGNER DE NOMBREUX CADEAUX ICI</a>
		</div>
		<?php endif;?>
		<?php if($phase == 4 || $phase == 5):?>
		<div class="videopart cs-clear">
			<div class="videopart-tit"></div>
			<!-- Video -->
			<div class="videomod"><iframe width="548" height="304" src="//www.youtube.com/embed/7-h4gSeXb5s?autoplay=1&rel=0" frameborder="0" allowfullscreen></iframe></div>
			<!-- Twitter -->
			<div class="videotxt">
				<!-- <h2>#goodluckcarambar</h2> -->
				<div class="videotxt-item">
					<p> Trop drole Baptiste! Tu me fais trop rire ! I 3 Carambar!</p>
					<h3>#GOODLUCKCARAMBAR</h3>
					<span>@bonbon</span>
				</div>
				<div class="videotxt-item">
					<p> Trop drole Baptiste! Tu me fais trop rire ! I 3 Carambar!</p>
					<h3>#GOODLUCKCARAMBAR</h3>
					<span>@bonbon</span>
				</div>
				<div class="videotxt-item">
					<p> Trop drole Baptiste! Tu me fais trop rire ! I 3 Carambar!</p>
					<h3>#GOODLUCKCARAMBAR</h3>
					<span>@bonbon</span>
				</div>
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
		</div>

			<?php if($phase == 4):?>
			<!-- section blue -->
			<div class="sec-blue">
				<div class="sec-bluecon cs-clear">
					<div class="sec-bluepho"></div>
					<div class="sec-bluenum"></div>
					<div class="sec-bluetime"></div>
				</div>
			</div>
			<?php else:?>
				<div class="sec-blue2">
					<div class="sec-blue2txt"></div>
					<div class="sec-blue2txt2"></div>
				</div>
				<div class="line line4"></div>
			<?php endif;?>

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
		<div class="challenge-title"></div>
		<div class="challenge-inner" data-646="transform:translate3d(0,0px,0);" data-1200="transform:translate3d(0,100px,0);">
			<div class="challenge-item">
				<div class="challenge-img">
					<img src="pic/challenge1.jpg" />
				</div>
				<div class="vote-btn vote-btn1" data-a="vote" data-d="cid=1">DEFI No1</div>
			</div>
			<div class="challenge-item">
				<div class="challenge-img">
					<img src="pic/challenge2.jpg" />
				</div>
				<div class="vote-btn vote-btn2" data-a="vote" data-d="cid=2">DEFI No2</div>
			</div>
			<div class="challenge-item">
				<div class="challenge-img">
					<img src="pic/challenge3.jpg" />
				</div>
				<div class="vote-btn vote-btn3" data-a="vote" data-d="cid=3">DEFI No3</div>
			</div>
		</div>
		<div class="challenge-man" data-300="transform:translate3d(0,0px,0);" data-400="transform:translate3d(0,-259px,0);"></div>
	</div>
	<?php endif;?>
	<?php if($phase == 3 || $phase == 4):?>
	<div class="videolistbg">
		<div class="videolist-tit"></div>
		<div class="videolist" data-626="transform:translate3d(0,0px,0);" data-1200="transform:translate3d(0,100px,0);">
			<div class="videolistshare">
				<div class="video-con">
					<div class="videolist-item">
						<div class="videolist-item-tit videolist-item-tit1"></div>
						<div class="videolist-box"><img src="images/demo.jpg" /><a data-d="mid=" data-a="open_video" href="javascript:void(0);" class="video-play"></a></div>
						<div class="videolist-txt">le soutien politique français</div>
						<div class="video-icon"></div>
					</div>
					<div class="videolist-item">
						<div class="videolist-item-tit videolist-item-tit2"></div>
						<div class="videolist-box"><img src="images/demo.jpg" /><a data-d="mid=" data-a="open_video" href="javascript:void(0);" class="video-play"></a></div>
						<div class="videolist-txt">le soutien politique français</div>
						<div class="video-icon"></div>
					</div>
					<div class="videolist-item">
						<div class="videolist-item-tit videolist-item-tit3"></div>
						<div class="videolist-boxnull">prochainement...</div>
					</div>
				</div>
			</div>
		</div>
		<div class="challenge-man" data-300="transform:translate3d(0,0px,0);" data-400="transform:translate3d(0,-259px,0);"></div>
	</div>
	<?php endif;?>
	<?php if($phase == 5):?>
		<div class="videolistbg">
			<div class="videolist-tit2"></div>
			<div class="challenge-man" data-500="transform:translate3d(0,0px,0);" data-600="transform:translate3d(0,-259px,0);"></div>
			<div class="videolist" data-826="transform:translate3d(0,0px,0);" data-1400="transform:translate3d(0,100px,0);">
				<div class="videolistshare">
					<div class="video-con">
						<div class="videolist-item">
							<div class="videolist-item-tit videolist-item-tit1"></div>
							<div class="videolist-box"><a href="#"><img src="images/demo.jpg" /></a></div>
							<div class="videolist-txt">le soutien politique français</div>
							<div class="video-icon"></div>
						</div>
						<div class="videolist-item">
							<div class="videolist-item-tit videolist-item-tit2"></div>
							<div class="videolist-box"><a href="#"><img src="images/demo.jpg" /></a></div>
							<div class="videolist-txt">le soutien politique français</div>
							<div class="video-icon"></div>
						</div>
						<div class="videolist-item">
							<div class="videolist-item-tit videolist-item-tit2"></div>
							<div class="videolist-box"><a href="#"><img src="images/demo.jpg" /></a></div>
							<div class="videolist-txt">le soutien politique français</div>
							<div class="video-icon"></div>
						</div>
						<div class="videolist-item">
							<div class="videolist-item-tit videolist-item-tit1"></div>
							<div class="videolist-box"><a href="#"><img src="images/demo.jpg" /></a></div>
							<div class="videolist-txt">le soutien politique français</div>
							<div class="video-icon"></div>
						</div>
						<div class="videolist-item">
							<div class="videolist-item-tit videolist-item-tit2"></div>
							<div class="videolist-box"><a href="#"><img src="images/demo.jpg" /></a></div>
							<div class="videolist-txt">le soutien politique français</div>
							<div class="video-icon"></div>
						</div>
						<div class="videolist-item">
							<div class="videolist-item-tit videolist-item-tit2"></div>
							<div class="videolist-box"><a href="#"><img src="images/demo.jpg" /></a></div>
							<div class="videolist-txt">le soutien politique français</div>
							<div class="video-icon"></div>
						</div>
					</div>
				</div>
			</div>
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
		<?php if($phase == 3 || $phase == 4):?>
		<!-- line -->
		<div class="line line2">
			<div class="line-com2"></div>
		</div>
		<!-- #barack -->
		<div class="barack">
			<div class="baracktit"></div>
			<div class="baracktxt">Please tell us when we can meet</div>
			<div class="barackbtn" data-a="open_invitation"></div>
		</div>
		<!-- /barack -->
		<?php endif;?>

		<?php if($phase == 1 || $phase == 2 || $phase == 3 || $phase == 4):?>
		<!--  -->
		<div class="img">
			<div class="img1"></div>
			<div class="img2"></div>
			<div class="img3"></div>
		</div>
		<!--  -->
		<div class="share">
			<div class="share-fb">
				<a href="#" class="share-fbbtn" data-a="open_facebook"></a>
			</div>
			<div class="share-t">
				<textarea class="share-txt" id="twitter-content"></textarea>
				<p class="share-t-num">14/140</p>
				<a href="javascript:void(0)" class="share-tbtn" data-a="share_twitter"></a>

			</div>
			<div class="share-i cs-clear">
				<a href="#" class="share-iandroid"></a>
				<a href="#" class="share-iios"></a>
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
			<div class="phoitem">
				<img src="images/demo2.jpg" />
			</div>
			<div class="phoitem">
				<img src="images/demo2.jpg" />
			</div>
			<div class="phoitem">
				<img src="images/demo2.jpg" />
			</div>
			<div class="phoitem">
				<img src="images/demo2.jpg" />
			</div>
			<div class="phoitem">
				<img src="images/demo2.jpg" />
			</div>
		</div>
		<!-- line -->
		<div class="line line3">
			<div class="line-com3"></div>
		</div>
		<!--  -->
	</div>


</div>
<!-- footer -->
<div class="footer">
	Mentions légales
</div>

<div class="overlay" data-a="close_popup"></div>


<!-- Templates -->
<!-- #youtube-player-tpl -->
<script type="text/tpl" id="youtube-player-template">
	<div class="pop video-popup" data-a="close_popup">
		<div class="popup-close"></div>
		<iframe width="825" height="640" src="//www.youtube.com/embed/7-h4gSeXb5s?autoplay=1&rel=0" frameborder="0" allowfullscreen></iframe>
	</div>
</script>
<!-- /youtube-player-tpl -->

<!-- #facebook-post-tpl -->
<script type="text/tpl" id="facebook-post-template">
	<div class="pop pop-fb">
		<div class="pop-close" data-a="close_popup"></div>
		<div class="pop-fttit">PUBLIER VOTRE SOUTIEN avec le #goodluckcarambar</div>
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
		<div class="pop-ft-check">
			<input type="checkbox" />
			<span>j'ai lu et j'accepte le règlement du jeu</span>
		</div>
		<div class="pop-ft-icon"></div>
		<div class="pop-ft-btn" data-a="submit-facebook"></div>
	</div>
</script>
<!-- #facebook-post-tpl -->

<?php if($phase == 3 || $phase == 4):?>
<!-- #send-invitation-tpl -->
<script type="text/tpl" id="send-invitation-template">
	<div class="pop pop-bar">
		<div class="pop-close" data-a="close_popup"></div>
		<div class="pop-bar-txt"></div>
		<input id="invitation_answer" type="text" class="pop-bar-input">
		<div class="pop-bar-btn" data-a="send_invitation"></div>
		<div class="pop-bar-tips"></div>
	</div>
</script>
<!-- #send-invitation-tpl -->
<?php endif;?>