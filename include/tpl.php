<!-- all tpls start -->
<script type="text/tpl" id="base-template">
	<div class="page">
		<!-- header -->
		<div class="header">
			<div class="header-wrap">
				<div class="hdcontent">
					<a class="nav1" href="./"></a>
					<a class="nav2 nav2on" href="./photowall.php"></a>
				</div>
			</div>
		</div>
		<!--  -->
		<div class="content">
			<div class="side">
				<div class="menu">
					<p class="filter"><strong>FILTRER</strong></p>
					<a href="javascript:;" data-a="show-nodes" data-d="type=TOUS&orderby=datetime">TOUS</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=TWEETS&orderby=datetime">TWEETS</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=IMAGES&orderby=datetime">IMAGES</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=VIDEOS&orderby=datetime">VIDEOS</a>
					<a href="javascript:;" data-a="show-nodes" data-d="type=BEST OF&orderby=datetime">BEST OF</a>
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
	<div class="inner {{#if-exp reward "!=" "0"}}reward-inner{{/if-exp}}">
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
					<p data-a="back" class="icon icon-back btn2"></p>
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
					<!--  -->
					<div class="com-main">
						<div class="com-base">
							<div class="com-uname">@{{screen_name}}</div>
							<div class="com-desc">{{{description}}}</div>	
						</div>
						<div class="com-wrap" style="display:none;">
							<div class="com-close" data-a="com-close">X</div>
							<div class="com-tit" >
								COMMENTAIRE
							</div>
							<div class="com-list" >
								<div class="com-list-inner">
									<div class="com-list-loading">loading comments...</div>
								</div>
							</div>
							<div class="com-make">
								<form class="comment-form" action="./api/index.php/comment/post" method="post">
									<p class="form-tit">NOM</p>
									<input type="text" name="name"/>
									<p class="form-tit">MAIL</p>
									<input type="text" name="mail"/>
									<p class="form-tit">COMMENTAIRE</p>
									<textarea name="content" class="com-ipt"></textarea>
									<input type="hidden" name="nid" value="{{nid}}" />
									<div class="com-loading"></div>
									<input class="submit btn2" type="submit" value="submit" />
									<div class="clear"></div>
								</form>
								<div class="comment-msg-success">thanks comment</div>
								<div class="comment-msg-error"></div>
							</div>
						</div>
					</div>
					<!--  -->
					<div class="com-info">
						<div class="com-counts clear">
							{{#if liked}}
							<a data-a="unlike" href="javascript:;" data-d="nid={{nid}}">{{likecount}} <i class="icon icon-liked"></i></a>
							{{else}}
							<a data-a="like" href="javascript:;" data-d="nid={{nid}}">{{likecount}} <i class="icon icon-like"></i></a>
							{{/if}}

							<a href="javascript:;" data-a="load-comment" data-d="nid={{nid}}">COMMENTAIRES</a>
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
				<img src="./{{image}}" width="100%" />
				{{/ifvideo}}
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
	<div data-a="node" data-d="nid={{nid}}" class="main-item pic-item main-item-{{nid}} {{type}}-item {{#if-exp reward "!=" "0"}}reward-item{{/if-exp}}">
		<a>
			{{#if-exp type "==" "text"}}
			<div class="node-inner">
				<p class="node-desc">{{{sub_description}}}</p>
				<p class="node-uname">@{{screen_name}}</p>
			</div>
			{{else}}
			<img src="./{{image}}" width="180" />
			{{/if-exp}}
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
		<div class="comlist-tit"><span>{{user.firstname}} {{user.lastname}} </span> - {{date}} {{month}}</div>
	</div>
</script>


<!-- html5-player-tpl -->
<script type="text/tpl" id="html5-player-template">
  <iframe height=498 width=510 src="http://player.youku.com/embed/XNjg0NDc0ODc2" frameborder=0 allowfullscreen></iframe>
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
