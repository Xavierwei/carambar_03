<!-- all tpls start -->
<script type="text/tpl" id="base-template">
	<div class="page">
		<!-- header -->
		<div class="header">
			
		</div>
		<!--  -->
		<div class="content">
			<div class="side">
				<div class="menu">
					<a href="javascript:;">FILTRER</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=TOUS">TOUS</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=TWEETS">TWEETS</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=IMAGES">IMAGES</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=VIDEOS">VIDEOS</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=BEST OF">BEST OF</a>
				</div>
			</div>
			<div class="main"></div>
			<div class="loading-list"></div>
		</div>
	</div>
	<!--  -->
</script>

<!-- inner-template -->
<script type="text/tpl" id="inner-template">
	<div class="inner">
		<div class="inner-side">
			<div class="com-loc">
				<i class="icon icon-loc"></i>
				<p>{{location}}</p>
				<p class="com-sep"></p>
				<p>{{date}} / {{month}} / {{year}}</p>
				<p class="com-sep"></p>
				<p>{{hour}} : {{minutes}}</p>
			</div>
			<div class="com-blocks">
				<div class="com-block com-back">
					<p class="block-text">RETOUR</p>
					<p data-a="back" class="icon btn2"></p>
				</div>
				<div class="com-block com-prev-next">
					<p data-a="prev" class="icon icon-left btn2"></p>
					<p data-a="next" class="icon icon-right btn2"></p>
				</div>
			</div>
		</div>
		<div class="comment-wrap">
			<div class="comment-cube">
				<div class="comment">
					{{{description}}}
					<!--  -->
					<div class="com-main">
						<div class="com-list">
							<div class="com-list-inner">
								<div class="com-list-loading">{{_e.LOADING_COMMENTS}}</div>
							</div>
						</div>
						{{#if currentUser}}
						<div class="com-make">
							<form class="comment-form" action="./api/index.php/comment/post" method="post">
								<textarea name="content" class="com-ipt" placeholder="{{_e.WRITE_YOUR_COMMENT}}"></textarea>
								<input type="hidden" name="nid" value="{{nid}}" />
								<div class="com-loading"></div>
								<input class="submit btn2" type="submit" value="{{_e.SUBMIT}}" />
								<div class="clear"></div>
							</form>
							<div class="comment-msg-success">{{_e.THANKS_COMMENT}}</div>
							<div class="comment-msg-error"></div>
						</div>
						{{else}}
						<div class="need-login">{{_e.LOGIN_BEFORE_COMMENT}}</div>
						{{/if}}
					</div>
					<!--  -->
					<div class="com-info">
						<div class="com-counts clear">
							{{#ifliked}}
							<a data-a="unlike" data-d="nid={{nid}}">{{likecount}} <i class="icon icon-liked"></i></a>
							{{else}}
							<a data-a="like" data-d="nid={{nid}}"> <i class="icon icon-like"></i></a>
							{{/ifliked}}

							<a>COMMENTAIRES</a>
							<a>PARTAGER</a>
							
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="image-wrap">
			<div class="image-wrap-inner">
				{{#ifvideo}}

				{{else}}
				<img src="./api{{image}}" width="100%" />
				{{/ifvideo}}
			</div>
			<div class="inner-loading"></div>
		</div>
	</div>
</script>

<!-- time-item-tpl -->
<script type="text/tpl" id="time-item-template">
	<div class="main-item time-item" data-date="{{date}}">
		<img src="./img/stars.png" />
		<div class="time-date"><span>{{day}}</span></div>
		<div class="time-month"><span>{{month}}</span></div>
	</div>
</script>

<!-- node-item-tpl -->
<script type="text/tpl" id="node-item-template">
	<div data-a="node" data-d="nid={{nid}}" class="main-item pic-item main-item-{{nid}}">
		<a>
			<img src="./{{image}}" width="180" />
			<div class="item-info" >
        <div class="item-info-wrap">
          <div class="item-time"><span class="item-timeicon">{{formatDate}}</span></div>
          <div class="item-user"><span class="item-usericon">{{user.firstname}} {{user.lastname}}</span></div>
          <div class="item-source">
            <div class="{{type}}"></div>
          </div>
          <div class="item-like {{#if user_liked}}item-liked{{/if}}">{{likecount}}</div>
          <div class="item-comment">{{commentcount}}</div>
        </div>
			</div>
			<div class="item-icon" style="display: block;"><div class="{{type}}"></div></div>
			{{#if topday}}
			<div class="item-topday"></div>
			{{/if}}
			{{#if topmonth}}
			<div class="item-topmonth"></div>
			{{/if}}
			{{#if mynode}}
			<div class="item-delete btn" data-a="delete" data-d="nid={{nid}}&type=node"></div>
			{{/if}}
		</a>
	</div>
</script>


<!-- comment-item-tpl -->
<script type="text/tpl" id="comment-item-template">
	<div class="comlist-item comlist-item-{{cid}}">
		<div class="comlist-tit"><span>{{user.firstname}} {{user.lastname}} </span> - {{date}} {{month}}</div>
		<div class="comlist-con">{{{content}}}</div>
		{{#if mycomment}}
		<div class="comlist-delete btn2" data-a="delete" data-d="cid={{cid}}&type=comment"></div>
		{{/if}}
		<div class="comlist-flag btn2" data-a="flag" data-d="cid={{cid}}&nid={{nid}}&type=comment"></div>
	</div>
</script>

<!-- side-tpl -->
<script type="text/tpl" id="side-template">
	<div class="side">
		<!-- user -->
		<div class="user btn" data-a="toggle_user_page">
			<div class="user-pho"><img src="./api{{avatar}}" width="34" height="34" /><div class="avatar-ie-round"></div></div>
			<div class="user-name">{{firstname}}</div>
			<div class="close-user-page" data-a="toggle-user-page"></div>
		</div>
		<!-- menu -->
		<div class="menu">
			<div class="menu-item photo" data-a="pop_upload" data-d="type=photo"><div class="menu-item-arrow"></div><p></p><h6>{{_e.POST_A_PHOTO}}</h6></div>
			<div class="menu-item video" data-a="pop_upload" data-d="type=video"><div class="menu-item-arrow"></div><p></p><h6>{{_e.POST_A_VIDEO}}</h6></div>
			<div class="menu-item {{_e.DAY}}" data-a="content_of_day"><div class="menu-item-arrow"></div><p></p><h6>{{_e.CONTENT_OF_THE_DAY}}</h6></div>
			<div class="menu-item month" data-a="content_of_month"><div class="menu-item-arrow"></div><p></p><h6>{{_e.CONTENT_OF_THE_MONTH}}</h6></div>
			<a class="menu-item logout" href="./api/user/samllogout"><div class="menu-item-arrow"></div><p></p><h6>{{_e.LOGOUT}}</h6></a>
		</div>
	</div>
</script>

<!-- html5-player-tpl -->
<script type="text/tpl" id="html5-player-template">
  <video id="inner-video-{{timestamp}}" class="video-js vjs-big-play-centered vjs-default-skin" preload="none" width="100%" height="100%" poster="./api{{image}}" data-setup="{}">
    <source src="./api{{file}}" type='video/mp4' />
  </video>
</script>

<!-- wmv-player-tpl -->
<script type="text/tpl" id="wmv-player-template">
  <iframe id="wmv-iframe" style="display:none" onload="this.style.display='block';" src="wmv_player.php?file={{file}}" scrolling="no" frameborder="0"></iframe>
</script>

<!-- flash-player-tpl -->
<script type="text/tpl" id="flash-player-template">
  <object id="flash-player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="100%" height="100%">
	<param name="allowScriptAccess" value="always"/>
	<param name="movie" value="flash/player.swf"/>
	<param name="flashVars" value="source=../api{{file}}&skinMode=show&onPlay=flashPlay()&onPause=flashPause()&onPlayComplete=flashplayComplete()&fengmian=./api{{image}}"/>
	<param name="quality" value="high"/>
	<param name="wmode" value="opaque"/>
	<param name="allowFullScreen" value="true"/>
    <embed id="flash-player-embed" name="player" src="flash/player.swf" flashVars="source=../api{{file}}&skinMode=show&onPlay=flashPlay()&onPause=flashPause()&onPlayComplete=flashplayComplete()&fengmian=./api{{image}}" allowFullScreen="true" quality="high" wmode="opaque" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="100%" height="100%" allowScriptAccess="always"></embed>
  </object>
</script>
