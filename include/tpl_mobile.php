<!-- all tpls start -->
<script type="text/tpl" id="base-template">
	<div class="page">
		<div class="header"
		     data-style="margin-top:-200px" data-animate="margin-top:0" data-delay="0" data-time="500" data-easing="easeOutQuart"
		     data-0="transform:translate3d(0,0px,0);" data-500="transform:translate3d(0,50px,0);">
			<div class="hdcontent">
				<a class="nav1 nav1on" href="./"></a>
				<a class="nav2" href="./photowall.php"></a>
			</div>
		</div>

		<!--  -->
		<div class="content clear">
			<div class="side">
				<div class="menu">
					<p class="filter"><strong>FILTRER</strong></p>
					<a href="javascript:;" data-a="show-nodes" data-d="type=&orderby=datetime">TOUS</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=text&orderby=datetime">TWEETS</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=photo&orderby=datetime">IMAGES</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=video&orderby=datetime">VIDéOS</a>
					<a href="javascript:;" data-a="show-nodes" data-d="reward=true&orderby=datetime">BEST OF</a>
				</div>
			</div>
			<div class="main-wrap">
				<div class="main">

				</div>
			</div>
			<div class="loading-list"></div>
		</div>
	</div>
	<!--  -->
</script>

<!-- inner-template -->
<script type="text/tpl" id="inner-template">
	<div class="inner">
		<div class="comment-wrap">
			<div class="comment-cube">
				<div class="comment">
					<div class="com-user">
						<div data-a="back" class="com-back btn2">
							<p class="icon icon-back"></p>
							<p class="block-text">RETOUR</p>
						</div>
						<div class="comuser-date">
							<p class="date">{{date}}</p>
							<p>{{month}} / {{year}}</p>
							<p>{{hour}} : {{minutes}}</p>
						</div>
						<div class="comuser-location">
							<p class="icon icon-location"></p>
							<p>{{location}}</p>
						</div>
						<div class="comuser-icon">
							<p class="icon icon-{{type}}"></p>
							<p>{{type}}</p>
						</div>
					</div>
					<!--  -->
					<div class="com-main" style="display:none;">
						<div class="com-close" data-a="toggle_comment"></div>
						<div class="com-list">
							<div class="com-list-inner">
								<div class="com-list-loading">{{_e.LOADING_COMMENTS}}</div>
							</div>
						</div>
						<div class="com-make">
							<form class="comment-form" action="./index.php/comment/post" method="post">
								<p class="form-tit">NOM</p>
								<input type="text" class="com-ipt" name="name"/>
								<p class="form-tit">MAIL</p>
								<input type="text" class="com-ipt" name="email"/>
								<p class="form-tit">COMMENTAIRE</p>
								<textarea name="content" class="com-ipt"></textarea>
								<input type="hidden" name="nid" value="{{nid}}" />
								<div class="com-loading"></div>
								<a class="submit btn2" data-a="submit_comment">Submit</a>
								<div class="clear"></div>
							</form>
							<div class="comment-msg-success">Merci pour votre commentaire, il sera publié après validation de notre équipe.</div>
							<div class="comment-msg-error"></div>
						</div>
					</div>
					<div class="com-share-pop">
						<div class="com-share-close" data-a="toggle_share">X</div>
						<div class="com-share-list">
							<?php $shareUrl = "http://www.goodluckcarambar.com/test";?>
							<a target="_blank" href="https://www.facebook.com/dialog/feed?app_id=649297458440878
								&display=page&caption=Soutenez+Good+Luck+Carambar
								&description=%26quot%3b{{encode_username}}%26quot%3b+soutient+Carambar+dans+son+%26%23233%3bnorme+d%26%23233%3bfi+de+faire+rire+les+USA%e2%80%9d+Partagez+votre+soutien+sur+Twitter+et+Instagram+%23Goodluckcarambar.
								&link=<?php echo $shareUrl;?>/photowall.php%23/nid/{{nid}}
								&redirect_uri=<?php echo $shareUrl;?>/photowall.php
								&picture=<?php echo $shareUrl;?>{{image}}" class="share-facbook"></a>
							<a target="_blank" href="http://twitter.com/share?text='{{encode_username}}'+bsoutient+Carambar+dans+son+énorme+défi+de+faire+rire+les+USA%e2%80%9d+Partagez+votre+soutien+sur+Twitter+et+Instagram+%23Goodluckcarambar.&url=<?php echo $shareUrl;?>/photowall.php%23/nid/{{nid}}" class="share-twitter"></a>
						</div>
					</div>
					<!--  -->
					<div class="com-info">
						<div class="com-counts clear">

							<a href="javascript:;" data-a="prev" class="icon icon-left btn2"></a>
							<a href="javascript:;" data-a="next" class="icon icon-right btn2"></a>

							{{#if liked}}
							<a class="com-like com-liked" data-a="unlike" href="javascript:;" data-d="nid={{nid}}">{{likecount}} <i class="icon icon-liked"></i></a>
							{{else}}
							<a class="com-like" data-a="like" href="javascript:;" data-d="nid={{nid}}">{{likecount}} <i class="icon icon-like"></i></a>
							{{/if}}

							<a class="com-comment" href="javascript:;" data-a="toggle_comment" data-d="nid={{nid}}">COMMENTAIRES</a>
							<a class="com-share" href="javascript:;" data-a="toggle_share">PARTAGER</a>
						</div>
					</div>


				</div>
			</div>
		</div>

		<div class="image-wrap">
			<div class="image-wrap-inner">
				{{#if-exp type "==" "photo"}}
				<img src="./{{image}}" width="100%" />
				{{/if-exp}}
				{{#if-exp type "==" "text"}}
				<div class="text-warp"><p class="text">{{description}}</p></div>
				{{/if-exp}}
			</div>
			<div class="inner-loading"></div>
		</div>
	</div>
</script>

<!-- time-item-tpl -->
<script type="text/tpl" id="time-item-template">
	<div class="main-item time-item" data-date="{{date}}">
		<div><p><img src="./img/stars.png" /></p></div>
		<div class="time-date"><span>{{day}}</span></div>
		<div class="time-month"><span>{{month}}</span></div>
	</div>
</script>

<!-- node-item-tpl -->
<script type="text/tpl" id="node-item-template">
	<div data-d="nid={{nid}}" class="main-item pic-item main-item-{{nid}} style-{{style}} {{type}}-item {{#if-exp reward "!=" "0"}}reward-item{{/if-exp}}">
	<a>
		{{#if-exp type "==" "text"}}
		<div class="node-inner">
			<p class="node-desc">{{{sub_description}}}</p>
			<p class="node-uname">@{{screen_name}}</p>
		</div>
		{{else}}
		<img src=".{{image}}" width="540" />
		{{/if-exp}}

		<div class="item-icon" style="display: block;"><div class="{{type}}"></div></div>

		{{#if-exp reward "!=" "0"}}
		<div class="item-reward"></div>
		{{/if-exp}}
	</a>
	</div>
</script>



<!-- comment-item-tpl -->
<script type="text/tpl" id="comment-item-template">
	<div class="comlist-item comlist-item-{{cid}}">
		<div class="comlist-con">{{{content}}}</div>
		<div class="comlist-tit"><span>- par {{name}} à {{date}}/{{month}}</div>
	</div>
</script>

<!-- side-tpl -->
<script type="text/tpl" id="side-template">
	<div class="side">
		<div class="side-fold">
			<!-- 侧边栏展开显示按钮，加上side-unfold-arrow 为向内箭头 -->
			<div class="side-fold-arrow "></div>
		</div>
		<div class="side-fold-btn btn" data-a="toggle_side_bar"></div>
		<div class="side-inner">
			<!-- user -->
			<div class="user btn" data-a="toggle_user_page">
				<div class="user-pho"><img src="../api{{avatar}}" width="34" height="34" /><div class="avatar-ie-round"></div></div>
				<div class="user-name">{{firstname}}</div>
			</div>
			<!-- menu -->
			<div class="menu">
				<div class="menu-item photo" data-a="pop_upload" data-d="type=photo"><div class="menu-item-arrow"></div><p></p><h6>{{_e.POST_A_PHOTO}}</h6></div>
				<div class="menu-item video" data-a="pop_upload" data-d="type=video"><div class="menu-item-arrow"></div><p></p><h6>{{_e.POST_A_VIDEO}}</h6></div>
				<div class="menu-item {{_e.DAY}}" data-a="content_of_day"><div class="menu-item-arrow"></div><p></p><h6>{{_e.CONTENT_OF_THE_DAY}}</h6></div>
				<div class="menu-item month" data-a="content_of_month"><div class="menu-item-arrow"></div><p></p><h6>{{_e.CONTENT_OF_THE_MONTH}}</h6></div>
				<a class="menu-item logout" href="../api/user/samllogout"><div class="menu-item-arrow"></div><p></p><h6>{{_e.LOGOUT}}</h6></a>
			</div>
		</div>
	</div>
</script>

<!-- html5-player-tpl -->
<script type="text/tpl" id="html5-player-template">
	<iframe height='100%' width='100%' src="{{embed}}" frameborder=0 allowfullscreen></iframe>
</script>
