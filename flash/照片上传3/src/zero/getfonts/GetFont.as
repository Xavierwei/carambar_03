/***
GetFont
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年8月14日 17:15:11
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.getfonts{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.swf.SWF;
	import zero.swf.Tag;
	import zero.swf.TagTypes;
	import zero.swf.records.RECT;
	import zero.swf.records.shapes.SHAPE;
	import zero.swf.records.texts.ZONERECORD;
	import zero.swf.tagBodys.DefineFont3;
	import zero.swf.tagBodys.DefineFontAlignZones;
	import zero.swf.tagBodys.DefineFontName;
	
	public class GetFont{
		
		public static var fontsFolderPath:String="http://www.wanmei.com/public/swf/fonts/";
		//public static var fontsFolderPath:String="";
		
		public static const charGroups:Object={
			//《现代汉语常用字表》之一 常用字(2500字)
			ch2500:/[一乙二十丁厂七卜人入八九几儿了力乃刀又三于干亏士工土才寸下大丈与万上小口巾山千乞川亿个勺久凡及夕丸么广亡门义之尸弓己已子卫也女飞刃习叉马乡丰王井开夫天无元专云扎艺木五支厅不太犬区历尤友匹车巨牙屯比互切瓦止少日中冈贝内水见午牛手毛气升长仁什片仆化仇币仍仅斤爪反介父从今凶分乏公仓月氏勿欠风丹匀乌凤勾文六方火为斗忆订计户认心尺引丑巴孔队办以允予劝双书幻玉刊示末未击打巧正扑扒功扔去甘世古节本术可丙左厉右石布龙平灭轧东卡北占业旧帅归且旦目叶甲申叮电号田由史只央兄叼叫另叨叹四生失禾丘付仗代仙们仪白仔他斥瓜乎丛令用甩印乐句匆册犯外处冬鸟务包饥主市立闪兰半汁汇头汉宁穴它讨写让礼训必议讯记永司尼民出辽奶奴加召皮边发孕圣对台矛纠母幼丝式刑动扛寺吉扣考托老执巩圾扩扫地扬场耳共芒亚芝朽朴机权过臣再协西压厌在有百存而页匠夸夺灰达列死成夹轨邪划迈毕至此贞师尘尖劣光当早吐吓虫曲团同吊吃因吸吗屿帆岁回岂刚则肉网年朱先丢舌竹迁乔伟传乒乓休伍伏优伐延件任伤价份华仰仿伙伪自血向似后行舟全会杀合兆企众爷伞创肌朵杂危旬旨负各名多争色壮冲冰庄庆亦刘齐交次衣产决充妄闭问闯羊并关米灯州汗污江池汤忙兴宇守宅字安讲军许论农讽设访寻那迅尽导异孙阵阳收阶阴防奸如妇好她妈戏羽观欢买红纤级约纪驰巡寿弄麦形进戒吞远违运扶抚坛技坏扰拒找批扯址走抄坝贡攻赤折抓扮抢孝均抛投坟抗坑坊抖护壳志扭块声把报却劫芽花芹芬苍芳严芦劳克苏杆杠杜材村杏极李杨求更束豆两丽医辰励否还歼来连步坚旱盯呈时吴助县里呆园旷围呀吨足邮男困吵串员听吩吹呜吧吼别岗帐财针钉告我乱利秃秀私每兵估体何但伸作伯伶佣低你住位伴身皂佛近彻役返余希坐谷妥含邻岔肝肚肠龟免狂犹角删条卵岛迎饭饮系言冻状亩况床库疗应冷这序辛弃冶忘闲间闷判灶灿弟汪沙汽沃泛沟没沈沉怀忧快完宋宏牢究穷灾良证启评补初社识诉诊词译君灵即层尿尾迟局改张忌际陆阿陈阻附妙妖妨努忍劲鸡驱纯纱纳纲驳纵纷纸纹纺驴纽奉玩环武青责现表规抹拢拔拣担坦押抽拐拖拍者顶拆拥抵拘势抱垃拉拦拌幸招坡披拨择抬其取苦若茂苹苗英范直茄茎茅林枝杯柜析板松枪构杰述枕丧或画卧事刺枣雨卖矿码厕奔奇奋态欧垄妻轰顷转斩轮软到非叔肯齿些虎虏肾贤尚旺具果味昆国昌畅明易昂典固忠咐呼鸣咏呢岸岩帖罗帜岭凯败贩购图钓制知垂牧物乖刮秆和季委佳侍供使例版侄侦侧凭侨佩货依的迫质欣征往爬彼径所舍金命斧爸采受乳贪念贫肤肺肢肿胀朋股肥服胁周昏鱼兔狐忽狗备饰饱饲变京享店夜庙府底剂郊废净盲放刻育闸闹郑券卷单炒炊炕炎炉沫浅法泄河沾泪油泊沿泡注泻泳泥沸波泼泽治怖性怕怜怪学宝宗定宜审宙官空帘实试郎诗肩房诚衬衫视话诞询该详建肃录隶居届刷屈弦承孟孤陕降限妹姑姐姓始驾参艰线练组细驶织终驻驼绍经贯奏春帮珍玻毒型挂封持项垮挎城挠政赴赵挡挺括拴拾挑指垫挣挤拼挖按挥挪某甚革荐巷带草茧茶荒茫荡荣故胡南药标枯柄栋相查柏柳柱柿栏树要咸威歪研砖厘厚砌砍面耐耍牵残殃轻鸦皆背战点临览竖省削尝是盼眨哄显哑冒映星昨畏趴胃贵界虹虾蚁思蚂虽品咽骂哗咱响哈咬咳哪炭峡罚贱贴骨钞钟钢钥钩卸缸拜看矩怎牲选适秒香种秋科重复竿段便俩贷顺修保促侮俭俗俘信皇泉鬼侵追俊盾待律很须叙剑逃食盆胆胜胞胖脉勉狭狮独狡狱狠贸怨急饶蚀饺饼弯将奖哀亭亮度迹庭疮疯疫疤姿亲音帝施闻阀阁差养美姜叛送类迷前首逆总炼炸炮烂剃洁洪洒浇浊洞测洗活派洽染济洋洲浑浓津恒恢恰恼恨举觉宣室宫宪突穿窃客冠语扁袄祖神祝误诱说诵垦退既屋昼费陡眉孩除险院娃姥姨姻娇怒架贺盈勇怠柔垒绑绒结绕骄绘给络骆绝绞统耕耗艳泰珠班素蚕顽盏匪捞栽捕振载赶起盐捎捏埋捉捆捐损都哲逝捡换挽热恐壶挨耻耽恭莲莫荷获晋恶真框桂档桐株桥桃格校核样根索哥速逗栗配翅辱唇夏础破原套逐烈殊顾轿较顿毙致柴桌虑监紧党晒眠晓鸭晃晌晕蚊哨哭恩唤啊唉罢峰圆贼贿钱钳钻铁铃铅缺氧特牺造乘敌秤租积秧秩称秘透笔笑笋债借值倚倾倒倘俱倡候俯倍倦健臭射躬息徒徐舰舱般航途拿爹爱颂翁脆脂胸胳脏胶脑狸狼逢留皱饿恋桨浆衰高席准座脊症病疾疼疲效离唐资凉站剖竞部旁旅畜阅羞瓶拳粉料益兼烤烘烦烧烛烟递涛浙涝酒涉消浩海涂浴浮流润浪浸涨烫涌悟悄悔悦害宽家宵宴宾窄容宰案请朗诸读扇袜袖袍被祥课谁调冤谅谈谊剥恳展剧屑弱陵陶陷陪娱娘通能难预桑绢绣验继球理捧堵描域掩捷排掉堆推掀授教掏掠培接控探据掘职基著勒黄萌萝菌菜萄菊萍菠营械梦梢梅检梳梯桶救副票戚爽聋袭盛雪辅辆虚雀堂常匙晨睁眯眼悬野啦晚啄距跃略蛇累唱患唯崖崭崇圈铜铲银甜梨犁移笨笼笛符第敏做袋悠偿偶偷您售停偏假得衔盘船斜盒鸽悉欲彩领脚脖脸脱象够猜猪猎猫猛馅馆凑减毫麻痒痕廊康庸鹿盗章竟商族旋望率着盖粘粗粒断剪兽清添淋淹渠渐混渔淘液淡深婆梁渗情惜惭悼惧惕惊惨惯寇寄宿窑密谋谎祸谜逮敢屠弹随蛋隆隐婚婶颈绩绪续骑绳维绵绸绿琴斑替款堪搭塔越趁趋超提堤博揭喜插揪搜煮援裁搁搂搅握揉斯期欺联散惹葬葛董葡敬葱落朝辜葵棒棋植森椅椒棵棍棉棚棕惠惑逼厨厦硬确雁殖裂雄暂雅辈悲紫辉敞赏掌晴暑最量喷晶喇遇喊景践跌跑遗蛙蛛蜓喝喂喘喉幅帽赌赔黑铸铺链销锁锄锅锈锋锐短智毯鹅剩稍程稀税筐等筑策筛筒答筋筝傲傅牌堡集焦傍储奥街惩御循艇舒番释禽腊脾腔鲁猾猴然馋装蛮就痛童阔善羡普粪尊道曾焰港湖渣湿温渴滑湾渡游滋溉愤慌惰愧愉慨割寒富窜窝窗遍裕裤裙谢谣谦属屡强粥疏隔隙絮嫂登缎缓编骗缘瑞魂肆摄摸填搏塌鼓摆携搬摇搞塘摊蒜勤鹊蓝墓幕蓬蓄蒙蒸献禁楚想槐榆楼概赖酬感碍碑碎碰碗碌雷零雾雹输督龄鉴睛睡睬鄙愚暖盟歇暗照跨跳跪路跟遣蛾蜂嗓置罪罩错锡锣锤锦键锯矮辞稠愁筹签简毁舅鼠催傻像躲微愈遥腰腥腹腾腿触解酱痰廉新韵意粮数煎塑慈煤煌满漠源滤滥滔溪溜滚滨粱滩慎誉塞谨福群殿辟障嫌嫁叠缝缠静碧璃墙撇嘉摧截誓境摘摔聚蔽慕暮蔑模榴榜榨歌遭酷酿酸磁愿需弊裳颗嗽蜻蜡蝇蜘赚锹锻舞稳算箩管僚鼻魄貌膜膊膀鲜疑馒裹敲豪膏遮腐瘦辣竭端旗精歉熄熔漆漂漫滴演漏慢寨赛察蜜谱嫩翠熊凳骡缩慧撕撒趣趟撑播撞撤增聪鞋蕉蔬横槽樱橡飘醋醉震霉瞒题暴瞎影踢踏踩踪蝶蝴嘱墨镇靠稻黎稿稼箱箭篇僵躺僻德艘膝膛熟摩颜毅糊遵潜潮懂额慰劈操燕薯薪薄颠橘整融醒餐嘴蹄器赠默镜赞篮邀衡膨雕磨凝辨辩糖糕燃澡激懒壁避缴戴擦鞠藏霜霞瞧蹈螺穗繁辫赢糟糠燥臂翼骤鞭覆蹦镰翻鹰警攀蹲颤瓣爆疆壤耀躁嚼嚷籍魔灌蠢霸露囊罐]/,
			//《现代汉语常用字表》之二 次常用汉字1000字
			ch1000:/[匕刁丐歹戈夭仑讥冗邓艾夯凸卢叭叽皿凹囚矢乍尔冯玄邦迂邢芋芍吏夷吁吕吆屹廷迄臼仲伦伊肋旭匈凫妆亥汛讳讶讹讼诀弛阱驮驯纫玖玛韧抠扼汞扳抡坎坞抑拟抒芙芜苇芥芯芭杖杉巫杈甫匣轩卤肖吱吠呕呐吟呛吻吭邑囤吮岖牡佑佃伺囱肛肘甸狈鸠彤灸刨庇吝庐闰兑灼沐沛汰沥沦汹沧沪忱诅诈罕屁坠妓姊妒纬玫卦坷坯拓坪坤拄拧拂拙拇拗茉昔苛苫苟苞茁苔枉枢枚枫杭郁矾奈奄殴歧卓昙哎咕呵咙呻咒咆咖帕账贬贮氛秉岳侠侥侣侈卑刽刹肴觅忿瓮肮肪狞庞疟疙疚卒氓炬沽沮泣泞泌沼怔怯宠宛衩祈诡帚屉弧弥陋陌函姆虱叁绅驹绊绎契贰玷玲珊拭拷拱挟垢垛拯荆茸茬荚茵茴荞荠荤荧荔栈柑栅柠枷勃柬砂泵砚鸥轴韭虐昧盹咧昵昭盅勋哆咪哟幽钙钝钠钦钧钮毡氢秕俏俄俐侯徊衍胚胧胎狰饵峦奕咨飒闺闽籽娄烁炫洼柒涎洛恃恍恬恤宦诫诬祠诲屏屎逊陨姚娜蚤骇耘耙秦匿埂捂捍袁捌挫挚捣捅埃耿聂荸莽莱莉莹莺梆栖桦栓桅桩贾酌砸砰砾殉逞哮唠哺剔蚌蚜畔蚣蚪蚓哩圃鸯唁哼唆峭唧峻赂赃钾铆氨秫笆俺赁倔殷耸舀豺豹颁胯胰脐脓逛卿鸵鸳馁凌凄衷郭斋疹紊瓷羔烙浦涡涣涤涧涕涩悍悯窍诺诽袒谆祟恕娩骏琐麸琉琅措捺捶赦埠捻掐掂掖掷掸掺勘聊娶菱菲萎菩萤乾萧萨菇彬梗梧梭曹酝酗厢硅硕奢盔匾颅彪眶晤曼晦冕啡畦趾啃蛆蚯蛉蛀唬啰唾啤啥啸崎逻崔崩婴赊铐铛铝铡铣铭矫秸秽笙笤偎傀躯兜衅徘徙舶舷舵敛翎脯逸凰猖祭烹庶庵痊阎阐眷焊焕鸿涯淑淌淮淆渊淫淳淤淀涮涵惦悴惋寂窒谍谐裆袱祷谒谓谚尉堕隅婉颇绰绷综绽缀巢琳琢琼揍堰揩揽揖彭揣搀搓壹搔葫募蒋蒂韩棱椰焚椎棺榔椭粟棘酣酥硝硫颊雳翘凿棠晰鼎喳遏晾畴跋跛蛔蜒蛤鹃喻啼喧嵌赋赎赐锉锌甥掰氮氯黍筏牍粤逾腌腋腕猩猬惫敦痘痢痪竣翔奠遂焙滞湘渤渺溃溅湃愕惶寓窖窘雇谤犀隘媒媚婿缅缆缔缕骚瑟鹉瑰搪聘斟靴靶蓖蒿蒲蓉楔椿楷榄楞楣酪碘硼碉辐辑频睹睦瞄嗜嗦暇畸跷跺蜈蜗蜕蛹嗅嗡嗤署蜀幌锚锥锨锭锰稚颓筷魁衙腻腮腺鹏肄猿颖煞雏馍馏禀痹廓痴靖誊漓溢溯溶滓溺寞窥窟寝褂裸谬媳嫉缚缤剿赘熬赫蔫摹蔓蔗蔼熙蔚兢榛榕酵碟碴碱碳辕辖雌墅嘁踊蝉嘀幔镀舔熏箍箕箫舆僧孵瘩瘟彰粹漱漩漾慷寡寥谭褐褪隧嫡缨撵撩撮撬擒墩撰鞍蕊蕴樊樟橄敷豌醇磕磅碾憋嘶嘲嘹蝠蝎蝌蝗蝙嘿幢镊镐稽篓膘鲤鲫褒瘪瘤瘫凛澎潭潦澳潘澈澜澄憔懊憎翩褥谴鹤憨履嬉豫缭撼擂擅蕾薛薇擎翰噩橱橙瓢蟥霍霎辙冀踱蹂蟆螃螟噪鹦黔穆篡篷篙篱儒膳鲸瘾瘸糙燎濒憾懈窿缰壕藐檬檐檩檀礁磷瞭瞬瞳瞪曙蹋蟋蟀嚎赡镣魏簇儡徽爵朦臊鳄糜癌懦豁臀藕藤瞻嚣鳍癞瀑襟璧戳攒孽蘑藻鳖蹭蹬簸簿蟹靡癣羹鬓攘蠕巍鳞糯譬霹躏髓蘸镶瓤矗]/,
			//ascii
			ascii:/[\x00-\x7f]/
		}
		
		private static const deviceFontNameV:Vector.<String>=new <String>["_sans","SimSun"];
		
		public static const blockSize:int=0x80;
		
		//private static var requestNum:int;//总请求数
		
		private static var htmlTxt:TextField;//- -
		
		private static var initTxtObjV:Vector.<InitTxtObj>;
		private static var progressing:Boolean;
		
		public static var datass:Object;
		
		public static function clear():void{
			
			var i:int;
			
			htmlTxt=null;
			
			if(initTxtObjV){
				i=initTxtObjV.length;
				while(--i>=0){
					initTxtObjV[i].clear();
					initTxtObjV[i]=null;
				}
				initTxtObjV.length=0;
				initTxtObjV=null;
			}
			
			if(datass){
				for(var fontName0:String in datass){
					var datas:Datas=datass[fontName0];
					datas.clear();
					delete datass[fontName0];
				}
				datass=null;
			}
		}
		public static function reset():void{
			clear();
			
			//requestNum=0;
			
			htmlTxt=new TextField();
			
			//initTxtObjV=new Vector.<InitTxtObj>();//TypeError: Error #1034: Type Coercion failed: cannot convert Vector.<*>@2a7fa89 to __AS3__.vec.Vector.<GetFont.as$0::InitTxtObj>.
			
			datass=new Object();
			
			progressing=false;
		}
		
		reset();
		
		public static function initBySWFData(swfData:ByteArray):void{
			var swf:SWF=new SWF();
			try{
				swf.initBySWFData(swfData,null);
			}catch(e:Error){
				trace("SWF 已加密或已损坏");
				return;
			}
			var i:int,FontID:int;
			var fontObjArr:Array=new Array();
			for each(var tag:Tag in swf.tagV){
				//trace(TagTypes.typeNameV[tag.type]);
				switch(tag.type){
					
					//case TagTypes.DefineText:
					//case TagTypes.DefineText2:
					//case TagTypes.DefineEditText:
					//
					//break;
					
					case TagTypes.DefineFont:
						throw new Error("暂不支持："+TagTypes.typeNameV[tag.type]);
					break;
					case TagTypes.DefineFont2:
						throw new Error("暂不支持："+TagTypes.typeNameV[tag.type]);
					break;
					case TagTypes.DefineFont3:
						
						var defineFont3:DefineFont3=tag.getBody(DefineFont3,null);
						if(defineFont3.FontFlagsBold){
							if(defineFont3.FontName.toLowerCase().indexOf("bold")>-1){
							}else{
								defineFont3.FontName+=" Bold";
							}
						}
						//trace("defineFont3.FontName="+defineFont3.FontName);
						FontID=defineFont3.id;
						fontObjArr[FontID]={
							fontName0:defineFont3.FontName,
							shellData:new ByteArray(),
							charV:new Vector.<Char>()
						}
						
						i=-1;
						for each(var code:int in defineFont3.CodeV){
							i++;
							var char:Char=fontObjArr[FontID].charV[i]=new Char();
							char.code=code;
							char.GlyphShape=defineFont3.GlyphShapeV[i];
							if(defineFont3.fontLayout){
								char.FontAdvance=defineFont3.fontLayout.FontAdvanceV[i];
								char.FontBounds=defineFont3.fontLayout.FontBoundsV[i];
							}
						}
						
						defineFont3.CodeV=new Vector.<int>();
						defineFont3.GlyphShapeV=new Vector.<SHAPE>();
						if(defineFont3.fontLayout){
							defineFont3.fontLayout.FontAdvanceV=new Vector.<int>();
							defineFont3.fontLayout.FontBoundsV=new Vector.<RECT>();
						}
						
						defineFont3.id=1;//- -
						fontObjArr[FontID].shellData.writeBytes(tag.toData(null));
						
					break;
					case TagTypes.DefineFont4:
						throw new Error("暂不支持："+TagTypes.typeNameV[tag.type]);
					break;
					
					case TagTypes.DefineFontInfo:
					case TagTypes.DefineFontInfo2:
						throw new Error("暂不支持："+TagTypes.typeNameV[tag.type]);
					break;
					
					case TagTypes.DefineFontName:
						var defineFontName:DefineFontName=tag.getBody(DefineFontName,null);
						FontID=defineFontName.FontID;
						defineFontName.FontID=1;//- -
						fontObjArr[FontID].shellData.writeBytes(tag.toData(null));
					break;
					case TagTypes.DefineFontAlignZones:
						var defineFontAlignZones:DefineFontAlignZones=tag.getBody(DefineFontAlignZones,null);
						FontID=defineFontAlignZones.FontID;
						i=-1;
						for each(var ZoneRecord:ZONERECORD in defineFontAlignZones.ZoneRecordV){
							i++;
							fontObjArr[defineFontAlignZones.FontID].charV[i].ZoneRecord=ZoneRecord;
						}
						
						defineFontAlignZones.ZoneRecordV=new Vector.<ZONERECORD>();
						defineFontAlignZones.FontID=1;//- -
						fontObjArr[FontID].shellData.writeBytes(tag.toData(null));
					break;
					//case TagTypes.CSMTextSettings:
					//	trace("忽略："+TagTypes.typeNameV[tag.type]);
					//break;
				}
				//trace(TagTypes.typeNameV[tag.type]);
			}
			
			for each(var fontObj:Object in fontObjArr){
				if(fontObj.charV.length){
					var datas:Datas=datass[fontObj.fontName0];
					if(datas){
					}else{
						datass[fontObj.fontName0]=datas=new Datas(fontObj.fontName0);
					}
					datas.shellData=fontObj.shellData;
					for each(char in fontObj.charV){
						datas.charArr[char.code]=char;
					}
				}
			}
		}
		
		private static function canShowText(initTxtObj:InitTxtObj,fontName:String):Boolean{
			if(fontName){
				var tf:TextFormat=initTxtObj.txt.defaultTextFormat;
				tf.font=fontName;
				initTxtObj.txt.defaultTextFormat=tf;
			}
			initTxtObj.txt.embedFonts=true;
			//trace("canShowText","initTxtObj.txt.defaultTextFormat.font="+initTxtObj.txt.defaultTextFormat.font);
			if(initTxtObj.unrepeatedText){
				for each(var c:String in initTxtObj.unrepeatedText.split("")){
					initTxtObj.txt.text=c;
					//trace("c="+c,"initTxtObj.txt.textWidth="+initTxtObj.txt.textWidth);
					if(initTxtObj.txt.textWidth){
					}else{
						initTxtObj.txt.text="";
						return false;
					}
				}
				initTxtObj.txt.text="";
			}
			return true;
		}
		private static function getUnrepeatedText(_text:String):String{
			var text:String="";
			var mark:Object=new Object();
			for each(var c:String in _text.split("")){
				switch(c){
					case "":
					case "\r":
					case "\n":
					break;
					default:
						if(mark[c]){
						}else{
							mark[c]=true;
							text+=c;
						}
					break;
				}
			}
			return text;
		}
		
		public static function initTxt(txt:TextField,textOrXML:*,onInitTxtComplete:Function=null):void{
			if(txt){
				
				var initTxtObj:InitTxtObj=new InitTxtObj();
				
				initTxtObj.txt=txt;
				
				if(textOrXML is XML){
					initTxtObj.xml=textOrXML.copy();
					if(initTxtObj.xml.@text.toString()){
					}else{
						var old_prettyPrinting:Boolean=XML.prettyPrinting;
						var old_prettyIndent:int=XML.prettyIndent;
						XML.prettyPrinting=true;
						XML.prettyIndent=-1;
						var text:String=initTxtObj.xml.children().toXMLString();
						XML.prettyPrinting=old_prettyPrinting;
						XML.prettyIndent=old_prettyIndent;
						if(text){
							initTxtObj.xml.@text=text.replace(/[\r\n]/g,"").replace(/<br\s*\/>/gi,"\n");
						}
					}
				}else{
					initTxtObj.xml=<txt text={textOrXML||""}/>;
				}
				
				text=initTxtObj.xml.@text.toString();
				if(initTxtObj.xml.@html.toString()=="true"){
					htmlTxt.htmlText=text;//- -
					text=htmlTxt.text;
				}
				initTxtObj.unrepeatedText=getUnrepeatedText(text);
				
				//trace("initTxt，initTxtObj.unrepeatedText="+initTxtObj.unrepeatedText);
				
				initTxtObj.onInitTxtComplete=onInitTxtComplete;
				
				if(
					isDeviceFont(initTxtObj.xml.@font.toString()||initTxtObj.txt.defaultTextFormat.font)
					||
					canShowText(initTxtObj,initTxtObj.xml.@font.toString())
				){
					initTxtComplete(initTxtObj);
					return;
				}
				
				initTxtObj.fontName0=initTxtObj.txt.defaultTextFormat.font.replace(/@getFont\d+/,"");
				if(initTxtObjV){//- -
				}else{
					initTxtObjV=new Vector.<InitTxtObj>();
				}
				initTxtObjV.push(initTxtObj);
				checkInitTxtComplete(initTxtObj);
				//trace("initTxtObjV.length="+initTxtObjV.length);
				if(initTxtObjV.length){
					//trace("progressing="+progressing);
					if(progressing){
						if(Datas.loadingDatas&&Datas.loadingDatas.fontName0==initTxtObj.fontName0){//当前正在加载的和这个的是同一个字体
							//追加到加载列表
							Datas.addLoadingCharCodes(initTxtObj.unrepeatedText);
							initTxtObj.getFont=Datas.notAvalibleGetFont;
						}
					}else{
						progressing=true;
						next();
					}
				}
				
				return;
				
			}
			throw new Error("txt="+txt);
		}
		private static function isDeviceFont(fontName:String):Boolean{
			if(fontName){
				return deviceFontNameV.indexOf(fontName)>-1;
			}
			return true;
		}
		private static function checkInitTxtComplete(initTxtObj:InitTxtObj):Boolean{
			var datas:Datas=datass[initTxtObj.fontName0];
			if(datas){
				for each(var getFont:GetFont in datas.getFontV){
					if(canShowText(initTxtObj,getFont.fontName)){
						var id:int=initTxtObjV.indexOf(initTxtObj);
						if(id>-1){
							initTxtObjV.splice(id,1);
						}
						initTxtObj.getFont=getFont;
						initTxtComplete(initTxtObj);
						return true;
					}
				}
			}
			return false;
		}
		private static function next():void{
			if(initTxtObjV.length){
				var initTxtObj:InitTxtObj=initTxtObjV[0];
				var datas:Datas=datass[initTxtObj.fontName0];
				if(datas){
				}else{
					datass[initTxtObj.fontName0]=datas=new Datas(initTxtObj.fontName0);
				}
				initTxtObj.getFont=datas.createGetFont(initTxtObj.unrepeatedText,createGetFontComplete);
			}
		}
		private static function createGetFontComplete():void{
			//每初始化完毕一个 GetFont，需要对所有的 initTxtObj 检查出可 complete 的 txt
			var i:int=-1;
			while(++i<initTxtObjV.length){
				if(checkInitTxtComplete(initTxtObjV[i])){
					i--;
				}
			}
			if(initTxtObjV.length){
				next();
			}else{
				progressing=false;
			}
		}
		
		private static function initTxtComplete(currInitTxtObj:InitTxtObj):void{
			//trace("initTxtComplete=======================================================");
			
			if(currInitTxtObj.xml.@autoSize.toString()){
				currInitTxtObj.txt.autoSize=currInitTxtObj.xml.@autoSize.toString();
			}
			
			var uHTML:XML=null;
			var iHTML:XML=null;
			var bHTML:XML=null;
			var aHTML:XML=<a href="" target="_blank"/>;
			var fontHTML:XML=<font/>;
			var pHTML:XML=<p/>;
			var textformatHTML:XML=<textformat/>;
			
			var tf:TextFormat=currInitTxtObj.txt.defaultTextFormat;
			
			if(currInitTxtObj.getFont){
				tf.font=currInitTxtObj.getFont.fontName;
				fontHTML.@face=currInitTxtObj.getFont.fontName;
			}else if(currInitTxtObj.xml.@font.toString()){
				tf.font=currInitTxtObj.xml.@font.toString();
				fontHTML.@face=currInitTxtObj.xml.@font.toString();
			}
			
			//trace("currInitTxtObj.xml="+currInitTxtObj.xml.toXMLString());
			
			for each(var attXML:XML in currInitTxtObj.xml.attributes()){
				switch(attXML.name().toString()){
					case "align"://String
						//表示段落的对齐方式。
						tf.align=attXML.toString();
						pHTML.@align=attXML.toString();
					break;
					case "blockIndent"://Object
						//表示块缩进，以像素为单位。
						tf.blockIndent=int(attXML.toString());
						textformatHTML.@blockIndent=int(attXML.toString());
					break;
					case "bold"://Object
						//指定文本是否为粗体字。
						tf.bold=(attXML.toString()=="true");
						bHTML=<b/>;
					break;
					case "bullet"://Object
						//表示文本为带项目符号的列表的一部分。
						tf.bullet=(attXML.toString()=="true");
						//?
					break;
					case "color"://Object
						//表示文本的颜色。
						tf.color=int("0x"+attXML.toString().replace(/[^0-9a-fA-F]+/g,""));
						fontHTML.@color="#"+attXML.toString().replace(/[^0-9a-fA-F]+/g,"");
					break;
					//case "font"://String
					//	//使用此文本格式的文本的字体名称，以字符串形式表示。
					//	tf.font=attXML.toString();
					//	fontHTML.@face=attXML.toString();
					//break;
					case "indent"://Object
						//表示从左边距到段落中第一个字符的缩进。
						tf.indent=int(attXML.toString());
						textformatHTML.@indent=int(attXML.toString());
					break;
					case "italic"://Object
						//表示使用此文本格式的文本是否为斜体。
						tf.italic=(attXML.toString()=="true");
						iHTML=<i/>;
					break;
					case "kerning"://Object
						//一个布尔值，表示是启用 (true) 还是禁用 (false) 字距调整。
						tf.kerning=(attXML.toString()=="true");
						fontHTML.@kerning=attXML.toString()=="true"?1:0;//?
					break;
					case "leading"://Object
						//一个整数，表示行与行之间的垂直间距（称为前导）量。
						tf.leading=int(attXML.toString());
						textformatHTML.@leading=int(attXML.toString());
					break;
					case "leftMargin"://Object
						//段落的左边距，以像素为单位。
						tf.leftMargin=int(attXML.toString());
						textformatHTML.@leftMargin=int(attXML.toString());
					break;
					case "letterSpacing"://Object
						//一个数字，表示在所有字符之间均匀分配的空间量。
						tf.letterSpacing=Number(attXML.toString());
						fontHTML.@letterSpacing=Number(attXML.toString());
					break;
					case "rightMargin"://Object
						//段落的右边距，以像素为单位。
						tf.rightMargin=int(attXML.toString());
						textformatHTML.@rightMargin=int(attXML.toString());
					break;
					case "size"://Object
						//使用此文本格式的文本的大小（以像素为单位）。
						tf.size=int(attXML.toString());
						fontHTML.@size=Number(attXML.toString());
					break;
					case "tabStops"://Array
						//将自定义 Tab 停靠位指定为一个非负整数的数组。
						var tabStops:Array=new Array();
						for each(var tabStop:String in attXML.toString().replace(/^\s*|\s*$/g,"").split(/\s*,\s*/)){
							if(tabStop){
								tabStops.push(int(tabStop));
							}
						}
						tf.tabStops=tabStops;
					break;
					case "target"://String
						//表示显示超链接的目标窗口。
						tf.target=attXML.toString();
						aHTML.@target=attXML.toString();
					break;
					case "underline"://Object
						//表示使用此文本格式的文本是带下划线 (true) 还是不带下划线 (false)。
						tf.underline=(attXML.toString()=="true");
						uHTML=<u/>;
					break;
					case "url"://String
						//表示使用此文本格式的文本的目标 URL。
						tf.url=attXML.toString();
						aHTML.@href=attXML.toString();
					break;
					case "width":
						currInitTxtObj.txt.width=Number(attXML.toString());
					break;
					case "wordWrap":
						currInitTxtObj.txt.wordWrap=(attXML.toString()=="true");
					break;
				}
			}
			currInitTxtObj.txt.defaultTextFormat=tf;
			
			if(isDeviceFont(tf.font)){
				currInitTxtObj.txt.embedFonts=false;
			}else{
				currInitTxtObj.txt.embedFonts=true;
			}
			
			var text:String=currInitTxtObj.xml.@text.toString().replace(/\r\n/g,"\n");
			if(currInitTxtObj.xml.@html.toString()=="true"){
				var execResult:Array;
				if(uHTML){
					execResult=/^<(\w+)(.*)\/>$/.exec(uHTML.toXMLString());
					text="<"+execResult[1]+execResult[2]+">"+text+"</"+execResult[1]+">";
				}
				if(iHTML){
					execResult=/^<(\w+)(.*)\/>$/.exec(iHTML.toXMLString());
					text="<"+execResult[1]+execResult[2]+">"+text+"</"+execResult[1]+">";
				}
				if(bHTML){
					execResult=/^<(\w+)(.*)\/>$/.exec(bHTML.toXMLString());
					text="<"+execResult[1]+execResult[2]+">"+text+"</"+execResult[1]+">";
				}
				if(aHTML.@href.toString()){
					execResult=/^<(\w+)(.*)\/>$/.exec(aHTML.toXMLString());
					text="<"+execResult[1]+execResult[2]+">"+text+"</"+execResult[1]+">";
				}
				execResult=/^<(\w+)(.*)\/>$/.exec(fontHTML.toXMLString());
				text="<"+execResult[1]+execResult[2]+">"+text+"</"+execResult[1]+">";
				if(pHTML.attributes().length()){
					execResult=/^<(\w+)(.*)\/>$/.exec(pHTML.toXMLString());
					text="<"+execResult[1]+execResult[2]+">"+text+"</"+execResult[1]+">";
				}
				if(textformatHTML.attributes().length()){
					execResult=/^<(\w+)(.*)\/>$/.exec(textformatHTML.toXMLString());
					text="<"+execResult[1]+execResult[2]+">"+text+"</"+execResult[1]+">";
				}
				currInitTxtObj.txt.htmlText=text;
				//trace("text="+text);
				//trace("currInitTxtObj.txt.htmlText="+currInitTxtObj.txt.htmlText);
			}else{
				currInitTxtObj.txt.text=text;
				//trace("currInitTxtObj.txt.text="+currInitTxtObj.txt.text);
			}
			
			if(currInitTxtObj.onInitTxtComplete==null){
			}else{
				if(currInitTxtObj.onInitTxtComplete.length==1){
					currInitTxtObj.onInitTxtComplete(currInitTxtObj.txt);
				}else{
					currInitTxtObj.onInitTxtComplete();
				}
			}
			currInitTxtObj.clear();
			
			//trace("=======================================================");
		}
		
		public var fontName:String;
		private var fontSWFLoader:Loader;//实例化 fontSWFData 为一个 swf
		private var onLoadFontSWFComplete:Function;
		
		public function GetFont(_fontName:String):void{
			fontName=_fontName;
			
			fontSWFLoader=new Loader();
			fontSWFLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadFontSWFComplete);
		}
		public function clear():void{
			if(fontSWFLoader){
				try{
					fontSWFLoader.close();
				}catch(e:Error){}
				try{
					fontSWFLoader.unloadAndStop();//将会引起相关的字体被卸载，将导致使用相关字体的文本里的字符变成空白
				}catch(e:Error){
					fontSWFLoader.unload();
				}
				fontSWFLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadFontSWFComplete);
				fontSWFLoader=null;
			}
			onLoadFontSWFComplete=null;
		}
		public function loadFontSWF(fontSWFData:ByteArray,_onLoadFontSWFComplete:Function):void{
			onLoadFontSWFComplete=_onLoadFontSWFComplete;
			var loaderContext:LoaderContext=new LoaderContext();
			if(loaderContext.hasOwnProperty("allowCodeImport")){
				loaderContext["allowCodeImport"]=true;
			}else{
				loaderContext=null;
			}
			fontSWFLoader.loadBytes(fontSWFData,loaderContext);
		}
		private function loadFontSWFComplete(...args):void{
			trace("loadFontSWFComplete，fontName="+fontName);
			var fontClass:Class=fontSWFLoader.contentLoaderInfo.applicationDomain.getDefinition(fontName) as Class;
			Font.registerFont(fontClass);
			//var font:Font=new fontClass();
			if(onLoadFontSWFComplete==null){
			}else{
				onLoadFontSWFComplete();
				onLoadFontSWFComplete=null;
			}
		}
	}
}
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.FileReference;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.utils.ByteArray;

import zero.BytesAndStr16;
import zero.getfonts.Char;
import zero.getfonts.GetFont;
import zero.swf.*;
import zero.swf.avm2.ABCFileWithSimpleConstant_pool;
import zero.swf.records.RECT;
import zero.swf.records.shapes.SHAPE;
import zero.swf.records.texts.ZONERECORD;
import zero.swf.tagBodys.*;

class Request{
	public var src:String;
	public var requestFinished:Function;
	public function clear():void{
		requestFinished=null;
	}
}
class InitTxtObj{
	public var fontName0:String;
	public var txt:TextField;
	public var unrepeatedText:String;
	public var xml:XML;
	public var getFont:GetFont;
	public var onInitTxtComplete:Function;
	public function clear():void{
		txt=null;
		xml=null;
		getFont=null;
		onInitTxtComplete=null;
	}
}

class Datas{
	
	private static var fontSWF0TagV:Vector.<Tag>;
	private static var insertTagsId:int;
	private static var MyFontClassNameId:int;
	private static var ABCData_stringV:Vector.<String>;
	private static var symbolClass_NameV:Vector.<String>;
	
	private static var dataLoader:URLLoader;
	private static var loadingSrc:String;
	private static var onLoadDataFinished:Function;
	
	private static var onCreateGetFontComplete:Function;
	
	public static var loadingDatas:Datas;//同一时刻最多只会有一个 loadingDatas
	public static var notAvalibleGetFont:GetFont;//同一时刻最多只会有一个 notAvalibleGetFont
	
	private static var loadingCharCodeV:Vector.<int>;
	public static function addLoadingCharCodes(text:String):void{
		var i:int=text.length;
		if(loadingCharCodeV){
		}else{
			loadingCharCodeV=new Vector.<int>();
		}
		while(--i>=0){
			loadingCharCodeV.push(text.charCodeAt(i));
		}
	}
	
	private static function init():void{
		var fontSWF0Data:ByteArray=BytesAndStr16.str162bytes("43 57 53 0f 13 7b 00 00 78 9c ec bc 07 54 54 d9 b6 2e 3c ab 8a 22 14 41 40 8a a4 60 91 a1 c8 49 82 68 17 49 32 16 45 15 19 44 05 03 22 82 92 31 14 48 16 10 14 44 05 14 10 b0 02 20 20 20 12 b4 40 45 c5 04 0a 8a 28 36 22 b4 80 09 51 da d8 f6 bf 77 f5 39 f7 9c ee f3 c6 1d f7 bd 33 ee b9 fd bf f3 c6 1e 7c 63 8d b9 e7 5a 73 ae b9 d7 9a 61 ef 55 18 11 a0 12 30 18 70 90 12 06 00 7b 2c 02 97 88 62 08 62 60 ba bc f3 a7 e3 67 49 c6 00 bf 4a ab ef 42 29 e9 18 41 db 5d db 36 44 c2 25 60 62 d2 30 5c cc 38 66 1d d6 1a 67 29 a0 83 b7 c7 e7 e0 ef e2 f5 04 69 82 4c c1 c3 82 a7 05 cf 0b ae 13 da 27 44 10 be 2b 8c 13 c9 12 f1 24 14 10 52 44 3d c4 a2 c4 ea c5 6e 8b bd 15 93 14 67 8b 53 96 ec 5f 62 27 f9 58 72 a3 54 ae 54 bd d4 46 e9 1c e9 13 d2 6f a5 95 97 9a 2f 8d 5d 7a 7c a9 89 4c b9 4c 30 71 81 38 2e fb 45 76 bd 5c 81 dc bc 9c 8d 7c b4 fc 29 f9 2e f9 41 f9 d7 f2 e2 0a 2b 14 cc 14 d4 14 cf 28 92 97 b5 2f a3 2c 2f 5e ce 50 aa 57 ba ad 24 a7 bc 56 d9 57 79 4e d9 69 c5 8d 15 81 a4 67 24 0d 95 6f 2a 0c d5 0b aa 2f 54 cd d5 12 d5 26 d4 64 d5 07 d5 27 d5 cb 35 30 9a 38 4d 7d cd 97 9a d7 b5 76 6a f7 6b bf d0 56 26 ff 40 de ae 6b ac 17 a1 97 a6 57 ac 77 45 ff 81 be 9b 41 aa c1 07 03 b6 e1 45 43 92 51 88 51 b4 d1 75 a3 b7 46 9b 8d 4f 19 8b 9a b4 9b 70 4d 1d cc 8e 9a cd 98 39 98 3f 32 b7 58 f9 6c a5 a6 05 d1 72 9d 65 8e e5 1d 4b 19 2b 4b ab 20 ab 5c ab 4e 2b 1f eb 21 eb 3d ab b4 6c c6 6d 6e ae 4e 5b 73 61 4d f1 0f a2 94 34 8a 80 6d 96 ed 6d 5b 1b 3b 35 7b 0d 07 2d 47 d3 b5 89 4e 99 ce 13 2e 7a 6e 82 ee d5 ee 6b 3c a6 3d 0a 3c 5b 3c 1f 78 0a ac 33 5b 37 b7 ae 82 6a e2 75 cd 6b 33 6d 8d f7 8f de 92 f4 ab f4 55 8c 66 86 89 4f 9b 8f a1 6f af af 93 9f 24 20 36 14 2c 70 ba db 45 bd 1f 7f 7b 55 b3 ec 78 7d cb fb b7 97 6f 06 cb ce 8b 2e e7 c1 aa 9d bf 8c a6 46 0d 63 e2 d7 b3 10 c6 67 5b f5 53 53 3e 99 9c 0e 6e af 7c 45 91 8b f0 5b f5 e9 73 d0 b8 dc 56 d1 1b 4e 81 d8 b7 cf 22 f2 e3 c7 0e 34 43 30 3b f4 ed 24 7e 77 6c 08 05 e9 91 2d b6 62 bd ca b9 90 0b 43 7a e3 66 c1 83 9f c6 af de 50 32 18 e0 c6 0e 25 6c 5c ec ce bc 9d f4 d1 ee 4d d2 c2 36 31 83 7e ad 24 f1 13 ef df 64 fc f4 7e ea 9e 7c b0 78 c6 bd ce 60 49 8d 1f ab 3d 0d 5e f9 bc 70 9d 8d 5f f7 fc ee 11 67 5a ac 97 56 e1 43 c3 a0 57 15 2f 4e 69 16 d6 cc 54 53 82 76 d7 52 2b f2 1c de 18 cc cc c6 7b de bc e4 b4 3c 08 91 78 e3 67 c9 bd b3 87 72 39 2f 47 5a 9e 17 b3 4b 1e a9 de b5 8f 68 f7 16 bf b8 ab da ba a3 d4 87 ae e8 46 b7 73 f4 f2 da a3 8c 95 c6 25 e4 9b 8e 04 fb 96 06 f6 77 79 eb 18 0b 9a 95 8c c4 f8 f8 02 7e 8a 0e 52 c0 91 6d f3 ba b6 05 b7 3f 79 8b 5e cd 8c 9d a7 cf 05 6f 29 81 e6 5b f2 44 17 cb e4 d4 89 91 f1 8d f3 6b c9 3f 8b 3e 99 b8 3d 78 06 13 b4 4d e5 be 0d 7d 2d 9b 8e a7 46 61 bf 1c 2d 0c 2a 3c 2c 5d 2b a2 a2 ea d0 ce 56 13 dd 0a e6 64 26 e6 7e c3 36 4b 4e 5b cd 64 ce 44 c0 6c cc 9d 83 4f f0 53 5f 35 7c 19 7b 7a 6d db f0 5e 1e 27 19 80 19 a2 c1 f2 3e 61 8f 92 25 ef 56 6a 46 5f 48 7c 24 2f 7a 4c f2 b5 62 8d e2 c7 c9 96 bb ae b9 a7 57 03 76 82 0d 92 e7 24 03 c9 1d 81 11 3a 81 b9 dd 8c ad e8 e3 d0 e1 ac 89 00 91 a7 c6 db 5b 59 57 1b 87 12 00 5b 1b 06 b8 82 d5 73 05 92 8b 80 19 e7 80 90 c3 35 b5 05 ae e2 92 ea 66 c0 72 ee 80 58 61 1f b9 65 99 30 13 2b 86 49 92 10 f1 a6 3f 20 61 0e 4b 6b 04 ed 71 66 42 ef 08 60 7b 25 a4 54 69 d1 45 f7 8a 41 86 c3 84 e8 86 69 fb 98 f3 4c cc 0f 25 80 b7 8e f9 f9 b9 f7 a1 86 e9 8d 00 17 24 2a b3 56 9f a2 67 79 0c b6 9f 9c 0f b7 09 98 a9 9e 08 a9 eb 2a ce a0 60 ac 33 f5 13 46 e4 db c6 0c 8d 80 5e cf 84 98 6b 3d 5e 7d ca 95 b0 aa 8d 02 33 c7 a6 f6 31 36 d9 7e 60 0c 02 c3 9f 87 39 2c ef e8 63 1f ca 03 db 41 c3 ed d3 d5 9d 27 9a c0 c4 ce 81 7b 28 47 12 e4 ad 2b c1 37 b5 4f dd d5 53 da 81 c6 c4 96 84 81 04 b1 9b 15 b5 72 1e b4 16 2a e1 8c e7 9a 27 11 31 8b dd f5 14 40 66 3f cb ec 3e 15 71 7d d3 d3 8b 1b 3e 70 3e 67 71 ee 02 b6 ab 0c 70 81 8a 92 9c 0f f5 95 a0 ad 58 09 5c 5c 74 d7 5c fe 89 d7 cb 4c 8d 38 7d ba 79 2f 77 58 9f 09 f4 ae c4 04 92 81 30 6a 2b b6 92 8d 69 6a ce 66 62 6b 9f 00 8e 67 95 5b 30 fa 13 60 ec b8 80 25 70 82 82 0a e6 d6 6e 6d b3 cf 38 8c 59 dc a9 14 6c 19 46 9e 14 62 de ba 32 ca fa 56 fc 8e 22 b1 aa e1 b4 5e 9b ef 5e d6 d1 77 74 5e 77 4f 5b 7b c4 61 37 ef 8c 94 7d 3a e4 d2 09 f0 e3 50 f0 d2 57 fd 38 e5 b6 d9 3a 83 50 77 04 c4 28 71 ec be 6b 7e 40 ce 05 3c b5 75 bd 36 b9 54 23 a9 e6 a7 eb 4a 92 86 f6 c6 77 6e 76 5f 23 89 33 34 97 59 60 e4 e2 2c 45 76 01 be cd 19 76 ba 29 4c d0 fd ae 31 ab 99 18 37 32 88 97 09 d2 1e 1a 49 0b 97 a3 13 7e 46 47 77 df 3d 76 45 7b 14 ba fb c2 ba 3e a5 fa 54 c8 d1 d1 35 1f a8 d2 70 d6 71 94 f5 e3 48 ae 2e f2 07 18 5f 57 1e 66 bb 6d 6a f0 42 73 9f 5f e2 4b 59 93 19 2a e7 e7 bc b4 25 ab c5 e7 1a 4e fa 78 56 07 0f 5c 70 b9 cf c4 8c d6 03 46 af fa e5 61 de cc d9 50 64 94 2b ef 54 1a 66 ce 6e 17 6d 6c 03 10 f5 e0 80 30 6b 5a bb 9f cb d5 3e b2 85 b3 eb d2 ea 98 f7 5b 4a 6f 21 e3 dc 69 2a 7f d6 a7 95 db 9c aa 2a 09 22 ee f5 40 c8 fb f1 5e bc ee 8f 69 f1 66 d1 71 4c 64 94 89 4a ed 53 c9 05 e1 d6 f4 fe 2b a1 01 38 73 df 2a a7 84 af 11 d7 ec 46 18 df 9c 7a 5e 88 d6 d2 70 3b fb 8e ef 72 f2 ba e5 37 50 af bd 4d 6f 5e 8d ac a9 2a ed 18 4e 7d 19 21 58 eb f3 74 8b 4f 1c 23 23 c0 b2 29 b0 32 a8 62 c7 11 5d 8e 73 6e c4 0a 4f 33 4e 4f b7 e2 d3 55 da c8 e0 03 f8 1d 7b 5f a7 6d 09 53 ec 0c bf dc bc 30 de 14 31 13 e1 f9 f0 66 fc 9a c0 da 9a 55 a4 91 b1 af 9e 39 a8 0b 28 b0 04 e5 c7 bf c6 93 44 db 80 01 58 f3 dd a9 21 de e5 c4 e2 13 86 e5 f3 61 df 6b 95 a2 37 2a 65 eb a8 8c fa 2d 71 32 70 16 46 b8 7b 1d 83 ab 66 0b de e2 37 77 06 b9 f5 d5 a1 86 28 c8 fe 8f fe c1 a5 df 11 02 49 e8 e1 23 11 d6 71 25 51 db b7 29 07 ce 15 e4 fa a0 dd d8 4e 19 f5 40 1c 95 fc 29 8e ac a2 33 60 e7 5e c3 16 6c 29 2a 04 6c 4d 39 e0 92 95 09 81 43 0f 9c 0b a4 ab 1d 2c aa 5c a9 9c be 62 2a 80 aa 74 13 68 7b f7 f4 af e4 a6 1c 6b f9 9c 7f 82 fb c4 fc 46 3b 10 de 46 83 f8 e9 ad 76 77 4a 3a c6 00 fb cb 44 10 3d 2c 91 c1 c4 5c b6 a7 69 64 ac 2d 2c be d1 04 44 4d 1e 28 96 b0 7c cc f2 59 80 5d 43 64 62 57 95 77 8c 8d f8 07 6f f7 d1 06 a2 3f 05 b6 4e 8a fb 5e 9d 3c 09 98 cb a8 c7 bd f3 02 30 33 87 0e 05 6c 66 6c 6f 5e b9 de 78 25 23 25 fd 51 29 76 c7 7d cd 12 c3 95 15 6a 3e 42 f4 7c bf e5 d6 a3 25 83 45 ca 8d e8 5c e7 a4 ba 4f 25 07 8a de 1b 32 ff a1 a5 4b 62 bb 97 cb ae 74 f7 7b 24 7a b8 1f 93 77 54 27 80 d1 d4 64 96 df 4f df 26 27 00 f2 22 54 08 39 9a be cd dc ff 97 d3 47 c3 80 e8 1b 0a 5b aa 32 19 27 33 15 be 0f dc 78 60 dc 43 68 5a bf 9e 55 b6 ec 7a 7d d9 b2 8b b6 54 d0 b5 9d 07 91 72 17 f2 11 2b 75 26 a6 89 0d e2 97 dd cd c9 b1 97 69 c7 3c 5b ea 3b ac af 47 6e ce ad 6b a6 5b 0e 26 b3 f2 95 45 bd e6 e6 a3 fd 10 5d 4e 07 65 c9 71 d3 13 33 ec 22 2f 39 3e 61 10 e5 54 d6 a9 44 03 fd 24 0f a2 14 54 bc ce 85 31 c1 37 9c 82 09 57 68 28 27 6e 6e df ee 37 0f de 4c 26 5e 58 41 c9 5e 35 4e 2b 00 2f ce 23 14 7d 02 89 4d 11 64 2b c4 4e a2 ca 35 60 47 be 1a cc 79 a0 1f df c3 03 ce 67 26 ce 8b 40 6b 70 d0 59 67 49 2b 68 7e 37 4a 24 d0 13 d4 8f 4a d1 0f fb 19 3d 62 62 68 7e 80 f9 2c e9 68 78 fd 57 95 fe 45 57 e9 9d 14 cc 07 1a 28 b5 63 37 14 4f 68 2a 08 4a 84 bb 6a 6b 64 54 c6 8f c8 a6 3e 00 6c 3f 1d 96 60 bc 08 49 21 d5 84 f0 64 0a 30 24 78 98 0d be 78 06 33 48 ae 6e ed 20 32 89 5b 6f 00 f3 fa b0 6f fa b4 92 a9 d2 ab 21 62 a3 67 c6 c5 45 57 ab c1 8f 15 7a d3 43 c2 15 0d ed 33 87 98 41 77 a6 53 94 4d e5 92 3a 5c 2a 0c 05 52 98 c8 c4 69 d9 42 dc e6 14 bc 6d 4d 7d a6 80 6f 89 5c af bf 0a 0f e8 d5 88 13 3e e6 ef d5 b7 21 14 3c 90 89 ff 70 dc a5 70 24 ec 81 3d 9d 02 de 9a 4c bc 83 89 cc b0 bd 78 f9 d2 f3 fe 9b 17 d6 a9 f6 3b ea 4f 3c 7f e8 16 94 48 f3 f8 b1 62 5d 18 db d5 b8 2a 82 89 3d c3 04 bc b6 37 79 80 ea 4d 02 12 a7 12 f6 6c 4f 0c e0 7c f8 b6 d3 cd 06 b0 2c 23 10 95 e9 24 d4 93 67 56 9b 18 23 3a cc be e7 6c 48 be 2e b9 96 31 29 77 e1 c6 72 5b 9f 23 5b 16 67 01 6f 52 08 be 9b 7a 7d 7c 97 6e 11 d5 30 df 27 ab 61 f1 55 ca d8 35 37 dd f3 9c 24 3d ae 9c c2 e4 61 bc d3 01 9b a2 53 12 f6 4a 07 59 7c db 90 e7 ae f9 48 c3 3c 90 7a a4 74 c2 73 64 7d ea 2a 1f 1e f8 ee 0e 85 6d f7 8d 47 66 ef 1b 31 21 c7 91 09 21 b7 8c e5 24 46 4a b6 1b 88 48 02 de 23 1d 84 eb 93 18 aa 1b a6 05 9f fb 62 27 fb f5 77 d5 80 b5 1a 69 98 6d 74 db 65 d3 72 b2 8f 71 c7 06 26 b6 26 16 70 66 fd b9 79 f7 15 01 1b 87 78 6f c9 db 91 27 b8 e6 2d 76 b7 98 58 ae 0d 88 35 5a 10 5a 3a 90 c7 b8 09 75 3f 0b 67 94 93 c3 be 0e 69 97 ba 76 fb b2 d2 66 23 8e 9b 8d cc c5 98 8d 4b 7b 95 ec 9d b2 ca 1a 2b 52 1a 92 1f 61 a6 68 f5 e5 9e 8b db 98 7b 2e c6 d8 c0 d1 df a0 d1 88 51 ff 21 d1 69 06 e9 7f 4d da 76 9a 33 63 55 96 64 a6 da 30 35 c8 84 9e 01 26 36 5a ea cb 5b 8e d3 cb 8b 09 a1 c0 9e 00 8c 7a 51 5a cd 61 c7 50 08 23 50 70 df 7a 6e 4e 36 4c 19 bc bc a8 c0 29 91 8f 12 95 5f 24 eb 5e 1e 46 5c 3d 0b 94 36 9e 2b c6 f6 6c 91 c1 ce f3 a0 11 f9 7b 10 cf 23 d7 cf fd 0c c2 4c 16 e8 b0 da 9b b1 d5 83 97 c3 6d e6 48 21 26 0b 2c 47 0a a4 e1 6d 68 25 32 ef 5c d1 15 9f 06 e0 3d f6 da b5 b8 81 89 d5 a0 81 0a d1 af 9e 3e 3c d7 8c 01 bc ef 07 50 6c a2 15 8f 64 68 c3 72 9e 81 ce e4 47 0e 05 87 35 70 b3 3b 3c d8 2a 9b 5a 58 bb 55 7e f3 1e 20 53 2b c1 2c af 8f 75 cf 54 18 f4 b0 95 d0 78 ab 66 60 ae 65 bb 2e b7 09 c8 4d 95 70 4b cd 99 6b 20 4e 82 a5 4d c8 64 6b 42 8f ca 71 37 20 eb ae e3 58 fa a8 c3 70 dd 15 f7 05 26 5e ef 13 68 ed 10 71 8d 1c cc b4 bb 4a 37 59 06 2a 0f 8b a8 59 48 32 17 2c 30 21 e6 34 a6 e2 31 b5 bd 28 49 82 91 9b ae 91 c0 c3 d0 91 a0 95 eb 73 35 45 e6 01 0f 0c 55 fc c0 a0 98 96 ef 47 3f 3d 12 fa 11 d9 54 37 01 eb 8d 66 4c a1 0e a3 2d 23 39 d9 cd 4c a0 87 87 82 ef c3 2d f9 e2 3e 77 4d a7 59 cb cc 7d f2 22 ef fb 01 d1 15 19 fc 67 0d 46 c2 68 ea d4 e1 3d a2 83 25 fe 7b 58 a0 75 d3 d4 78 a0 be ef 9a 6e 22 10 1a 28 60 82 58 f6 fa a6 61 10 94 67 01 71 62 38 bf ef b4 f3 ca b0 51 20 1c c9 06 31 ae 26 c7 44 ac 10 44 16 d0 18 79 e7 ac 7d 0a 92 b3 32 0d d0 9c f5 93 ac d5 20 c4 ff f8 15 49 4a 59 d8 57 97 e6 51 86 6b 86 bf 63 b0 9c f8 0f 06 16 48 71 cb 09 0b e5 13 f5 35 43 7b 5e 1c d0 5a d4 7e 79 40 f2 95 ad 8b 44 1f 2f d9 6a 17 05 75 ae 7d 46 1e af 67 4b 97 6c 4b 39 ff 3d f6 fc c7 63 29 62 7e 0b f3 55 05 e3 fa bf bc 19 3c fa ad 12 75 a7 45 86 e4 bd fa f2 b1 37 b3 aa 83 25 8e 16 e2 e7 8a 2c 1e 27 07 18 21 7d 1c 3a 95 f4 49 28 c7 91 73 29 7b c7 a4 49 3b ee 93 42 42 08 77 74 6f ad 79 34 1c 7b 5d ae b5 e7 0a c6 3a 00 95 71 c3 72 d3 ed d3 3f d7 81 b8 49 25 f4 f4 ea dd 9d 5b 3b dd bd da 67 e0 f0 50 71 45 d8 ad da 21 77 55 e3 0c b6 9a bc 1f 04 22 2b f3 f3 39 53 6b ce ad 5b 13 6d 95 c0 99 60 e2 7e 38 68 57 ff 5d 7f 89 e4 fa c6 e6 fc a9 92 03 73 bf 5e 19 1d 5f 74 a9 48 b8 fb 04 88 55 c7 00 0f ea 25 ae 70 98 02 77 8b 99 42 a9 87 8e 33 82 f6 84 33 ae 14 c9 dc 10 54 e8 3e 58 22 77 78 fa 92 0d 31 65 7e 7e ff c6 e5 b1 2e f3 68 70 94 f8 5d 14 7c e9 d3 3d b4 ad f1 66 67 f4 f2 81 cd cd 7d 27 78 d8 e3 62 a0 71 f5 13 d7 c0 e2 f9 3e 43 d5 86 37 dd 4c 38 8b 38 9d 5d 79 f7 76 71 4c d8 3c b7 fa 09 b6 c1 b9 54 25 c0 1e bd 05 f2 cd b7 6a 0f 2e 57 8f 9d e9 cc ad f9 1c 6b f1 f1 e4 31 c5 95 dc 36 e2 04 60 03 98 18 09 b3 bc 5c b1 b4 cf aa a0 63 47 c1 34 fa cf 15 dd b7 24 24 37 93 75 5c 3b 81 10 c1 02 8d 97 ba ec 80 fa 9a da 6d 9b 6f 70 16 2e dc e0 fe 8a 64 7a 51 80 93 b8 e2 7e 56 3c dd ee e9 24 70 9f 16 7d 07 38 ec ca 83 e3 aa 72 cb 38 35 ea 51 67 a6 cc c9 77 5b cd d2 6f 00 b6 4d 19 60 3c a8 90 dd d9 42 79 a2 e7 5d 75 85 33 a1 ae d8 92 6e c7 19 90 22 d0 73 b1 dd 6c 91 b1 7b c8 06 9d 63 c2 d5 d2 18 4e 6e 7e 7f c3 c1 3c 4e bb 81 a8 1f ab f3 62 d0 c6 44 90 db 55 0f b2 89 2b 1c 1f 72 35 35 02 8a 4a ea 08 43 a9 75 82 14 c0 b6 8e 02 7c 3c f0 8d fd ea d0 0d a5 15 11 a7 07 22 49 b0 6f 8e 07 6d ee 02 6a e4 ee 5d 2b 0e 2f 00 d4 9d 01 b1 0b 37 59 c5 2d af 26 93 cf 5c 8a de 99 b3 25 75 b7 a7 6f 26 1d 08 ad 5e 8e ef 5c 73 d7 23 db 90 96 07 d8 c8 07 c3 75 b7 fd 0a b8 e1 da 7d ed b2 d9 4a 2e 5b 99 4c 2c 96 0e c4 0d f5 01 1a 1e 7e d5 d4 51 f0 0e 05 fc a0 0e fd c9 c6 d4 94 a3 19 81 4f 02 94 98 cc 91 78 2c 0e 30 8d 20 29 36 84 f9 d9 f7 8b f9 8b 8d 84 9e d2 e8 5d 39 8f e2 de da b0 83 bd 9e 51 12 4e ee 28 f2 7b 75 a9 d2 c0 b6 3a eb ae c0 58 d7 8c a2 40 49 84 fa a6 b8 f0 06 c6 b8 28 9e e7 3a fe a2 2c cc 14 79 aa 07 3b 60 85 df c3 93 84 8b f4 7b 00 fb 0f 64 b8 2d 58 88 48 0d d1 0a ca 79 b0 8f ce 14 f2 67 1e 5f 0c 12 d8 f2 f0 c3 0f 23 3a 85 97 91 08 88 24 a7 7e 40 c0 50 81 64 a1 b3 6c c4 4a a5 c3 0f d7 eb c1 b4 91 82 bd 8c cc de 67 5e 80 79 e6 45 35 54 7c 96 62 da 9c c7 d0 a6 82 54 16 97 76 c1 4a 65 0f 8f 5e aa 27 00 5a 8b 24 ec 91 08 dd 36 cf ea 4e e2 e3 72 46 e3 d3 60 6b 26 e6 91 f3 5b 19 ef d4 ed 41 26 7b 47 a7 c8 c1 a1 60 78 72 ae 64 f5 a4 84 ec 4c cd b3 a8 34 c7 14 b6 ba 6f 21 d0 5d 29 02 b7 6e 1e ad 2e bf b0 85 f5 42 92 eb d0 ad 58 0d b8 16 bf 10 9d 51 74 61 f6 99 ff 9c dc 5d b9 e8 fb 68 8a bb 85 5a 51 f2 42 bb dc 57 02 f0 f1 17 41 b0 c0 32 95 21 b7 a1 7d ff da 91 3d 1f fa 07 c1 f0 38 e2 a3 96 5b 88 35 d2 23 ef d5 0c 1c 57 f1 d6 08 33 1d 00 fc d6 63 80 49 10 ee a5 bd 51 c3 68 fd 90 e0 97 bb 9c dc 41 88 36 7a ec c2 b9 bc 43 b3 86 04 1c 7f 26 76 3a 8f c3 cd 33 69 34 63 70 3a 86 e8 80 89 40 8a 2b 4f d5 f0 44 56 16 f1 c2 8a dc 81 9a 7d ba 1a 36 40 38 9e 88 b8 10 22 79 6d 3d 5d 41 b8 1f 51 2c cf 8f 6f 5b 91 71 fa 08 0f a2 53 6b 69 f1 22 52 3d 72 57 5d 24 93 d3 b3 2f 31 a4 ee 7d 02 dc 30 1d c4 c5 ef ba 12 7d 57 6b fb dc 55 2c 59 99 54 e3 8d 1b f1 d0 b4 91 94 dc cb d8 6f bb 88 54 4b cf 02 9a f4 a3 04 d7 75 c9 c7 d1 46 00 73 2a a1 44 ef 7e 92 72 bd be 97 7f 44 f4 e5 c0 ab 76 9f 77 f0 30 46 25 4c ec 44 85 f4 a3 92 00 a9 70 b9 a2 9b 25 5b ce 44 b8 cc 03 52 36 8f 84 a0 85 43 1e 8b af 46 6e 80 35 92 e8 bd db 92 6b 1c b2 e4 61 6c db b5 74 42 88 ce a5 64 35 ed d9 48 43 57 16 9a ba e7 93 f8 7c 39 ac ce 40 d1 be 25 86 32 3b 6d 14 27 90 9b 22 ce 36 01 02 33 99 3c 84 63 66 8d d9 d5 e4 70 b5 9b c2 eb bf 26 72 52 19 e6 6a b5 c2 d2 1a 74 92 93 37 13 88 4f 29 a0 40 7a ee 48 d3 3f 38 fa 59 83 f1 ee bd 06 05 ba 33 42 a1 87 f4 cc 38 df ab c7 f1 b9 f3 a6 e9 cd 85 cf 27 d5 98 18 ef 65 80 cd 90 74 74 85 1f ae b6 ee 26 ca 0e dd 12 9d 9c 8a 3b 5c 35 c1 6d 68 3c 90 d1 8e 2d d7 0f 55 3b 9a ce 5d 7e 61 6e 8e c9 2f 5b 57 2a 70 36 34 17 b6 bb d2 ca a8 b5 e6 e7 64 b9 b1 44 0a c8 8f 55 42 72 1a 8b 96 9b 9b e4 2a a3 5d 49 a6 56 33 03 2a 81 bd 0a a9 68 2c d3 6a 9a 9e 6d 8c 1c 6f 1c e3 26 86 a0 e5 51 de 20 3a af 8a 25 3a 93 dd 5a 07 3a 4e 9a ad 89 b5 39 c3 2d f6 cc 8e 7c 57 2c da a7 76 57 f6 52 a7 0a 1a 0d 0b 5e fd 85 6d 6e 7a 69 f5 32 34 c5 d7 5a 9f 3a 37 f6 54 85 aa 66 96 2a bf 34 5c bb 77 e5 ea 09 8c eb 18 08 bb 05 d2 d2 db 42 af 77 8c 08 ae 7d 8a 04 c0 e4 d1 bc 99 a4 75 f4 89 11 c0 1d db 65 fb d9 fb d0 a9 62 8a 1d 63 43 b3 08 92 23 a3 f9 21 b3 94 11 f2 fd 3c 1d 7b f0 c2 7f ec 37 54 99 e7 16 a5 cb d5 4e bc a2 59 1c ff 5e 6a f6 73 98 97 64 56 38 d3 e6 a1 95 bc 56 0a 55 fd c8 d5 d5 05 d9 91 7f cf 3e 37 20 da 7b d9 f3 68 df 87 8e 68 94 3c c1 27 1f dc fa f3 4a 2b 87 70 7b 5e 9b 6d 47 00 51 e8 41 b4 64 f1 e7 94 65 3b 42 4f 37 af 0d 69 f4 b2 56 bd f9 80 59 da f3 f2 e0 d7 4e 75 ee d3 8f 22 33 ca f5 46 d6 aa d7 51 8b 18 fd 36 6a fe ab f9 ea bb 3b 03 36 04 4b e4 a0 93 96 e8 79 f6 aa 0e 33 d7 8a ab 36 44 a7 ff d6 d9 aa 1e a4 2e ae 76 fc 45 77 b5 e3 97 63 96 40 38 d5 01 0a 89 0b 9c f0 e7 03 e6 fd b7 ea 23 d6 f6 01 56 53 17 b0 fa 1d 9f a2 08 cd ef 3a 34 2d 9f 73 8e 3d 4f cf 46 b2 8e 5f 28 70 5b 4e 90 7c 42 4f fe 66 ce 1a ae 81 fa 27 50 19 95 93 0b 56 19 09 05 da 50 f8 c1 45 ff 4d a2 13 99 a1 e0 93 3d 01 b2 a6 3f 94 1c 15 fd 81 09 67 4a 28 18 52 a0 97 ff 48 e4 e2 c6 c0 fe 23 8c 1d 63 56 48 1d 1b fc 0b 60 4e a7 f5 fb 56 4f f6 02 a6 82 f7 b7 6d 45 b8 4d 6f 67 42 a8 ad 02 6d 39 be 6a c7 92 45 dd ad 5f 96 6b 29 51 9f 2c 8f 06 55 64 85 cc 3e 68 ad 2e 79 bd b5 ca 7b 0c 84 c2 e8 36 be ce c8 12 0e 8a 12 58 33 5e 70 87 fd 00 e0 6a 9b f4 69 d9 61 0a 34 71 28 02 5b fb 4b c6 ca 19 81 da 4e 06 dc 8c 9e 2f ed 88 67 d1 0d 21 db 20 92 5e 85 75 bf 8d a0 6f aa 76 b2 6d 7c d9 31 90 4f 9f 8b 32 7b eb 5f e2 ed 10 33 58 0e 44 db 41 f0 d8 4c 62 98 1f 4b 3d 42 db b6 5e dd 64 2b 88 5e f4 01 d1 cb e2 97 55 4a 96 a5 67 9a fc 6c 48 1f 38 d6 fd 95 82 f1 fe 08 38 43 65 86 7b 77 a2 60 c7 a3 92 7c e7 51 0a 38 20 bb 63 32 b0 b5 8d 11 75 6f 30 98 26 87 fd b0 bc 5c 94 b3 0d f3 c0 41 ad ba 7e e4 d1 0c 08 bc e3 80 88 d8 58 ee 1d ee 16 ae f5 53 b3 13 dc a8 a1 01 1f a4 56 14 03 71 73 39 d7 1e 73 39 12 88 66 d6 83 a8 9e de 86 7d 5c 3d a9 7d 45 46 40 28 a4 20 e5 cf 49 76 81 cf 80 50 74 d4 e9 86 75 7c 53 15 f3 4d 25 d6 42 5f 44 bd bb 8a db 37 a3 1b 39 1f e8 ee 4e 83 20 12 47 05 a3 7e 21 95 b8 3d 12 2a 71 f3 69 8e 6e 58 83 b5 94 56 7a c4 5a f9 f5 22 1a e3 6b ee 1e 7d 75 ee da 9e 95 d4 80 fa c6 86 fc b1 61 d7 a8 11 87 81 c0 ea 1c d5 99 43 17 c8 71 e7 3b ab 29 b8 96 9f 9e ea 9d 8f b5 0f 35 b0 48 06 43 01 69 0e 52 64 18 bc 59 a8 4d 88 3a 20 1e a1 63 f4 20 11 bc 39 4c ec 37 33 37 3f ce 60 fe c6 13 24 98 3f 7f e0 aa 21 9a 02 f5 de 0a 34 9f 9b 7a da 4b b5 55 0d 9d 97 35 d7 f2 0f 59 73 20 c6 eb 83 f8 ae 18 c0 3b d7 83 60 ed 83 e1 36 fd c8 6d 06 e6 9a 11 4f 81 d0 ec 0c ec 47 97 31 de e5 86 57 b6 0e 33 76 94 e6 53 5e 48 32 70 e5 fa 27 9e d4 32 de 47 3d c4 6c 6e b3 98 dc 0c c2 4a 54 08 f6 5a b5 11 ef f0 3a f3 46 5c 6f 89 c6 43 41 03 0a d0 6f f2 a0 dc 41 83 16 29 69 bb 6e c5 b4 a3 cd 7e 66 58 55 f0 c6 79 35 f2 cf 9c c3 03 1e d6 5c cd d6 39 c4 b7 b3 49 20 36 a1 cd d9 dc c2 04 09 eb 42 b8 5a 34 f4 bd 7e 2d e6 bb ab 64 96 ae 0b 2f 3d 73 42 81 50 0c 47 72 b2 9f 73 34 d5 d2 41 a0 9c 05 d2 6e 7e 85 76 0d 1b 29 db 95 d5 5d eb a9 05 67 12 81 7c a0 12 ea 3d ba 39 8d ed ef ed f4 27 eb bf b7 bf 1d ad 41 a7 3a b0 1e 30 8b 27 7e 79 b6 4d ce fd 54 b2 7e 18 e2 4d 45 ed 7b fc 6d 11 ab a1 a9 e0 bc 5a 48 b2 b2 f7 88 70 5b 28 38 ca 1d 20 e8 f8 0a 6a d7 c6 2b d4 26 4f 2a 30 90 2a 12 5d f8 8d 06 15 8c a0 80 b8 4e 62 ce fa 58 f3 58 10 dd 9d fc 74 0e f5 35 2a 25 80 eb 12 b5 bd 46 f3 2d 57 db bc 9a a1 38 b1 a8 25 09 3e 19 3c 90 58 95 39 52 b0 0a 71 d6 ec 6b 0d 6f d1 74 f2 a6 23 60 3e 9e b1 43 12 04 f1 d5 05 93 de e6 d4 9f b4 a1 4c 0d 6f c7 8e c0 65 44 28 5f eb f6 d9 3c 93 72 37 39 7c 79 75 ac 2d 5a be 5e 97 45 d8 2f 5b 9b bf b0 7f 9e 22 15 79 94 5c b5 35 64 83 40 30 f9 ca 86 1d 24 93 e4 4d a3 8d db c9 15 39 ea 0b b6 a7 4f 95 e4 f9 fb 63 42 dc 16 ed 8c 69 f6 19 2b 94 af ec 0b 34 9b 49 7a bb 67 29 32 90 63 e9 c5 bd 23 72 9c 17 9c ec af 8d bc 33 f9 3f 18 44 37 f7 bc 1f f3 75 1c 12 46 a3 8c 28 65 85 ee 52 07 af 9f ae e5 68 ac 92 16 1f 77 2f 68 62 dd 3d ec ec 9b 33 76 64 c4 52 e6 c3 89 37 1d 5b b7 c4 93 be de de e3 b1 3f c9 e7 c2 54 d4 4d 6a 52 7f c0 05 72 bc cf 9a 07 0f 3b cb f5 ae 5b c5 e8 bd cf c7 ee 1b 3f fa 13 3a 39 2d c0 bc 3b f9 f5 e9 c9 97 3f 8e e7 58 2e 04 d0 b4 4b 14 b0 91 c4 c3 91 74 5a a9 40 5c 71 ef 54 f3 c1 81 2e 29 f6 5b 17 13 49 43 59 c9 df dc bc fb 20 66 f6 d0 a1 2d 8c 06 36 ed 3a a9 6f f0 f4 49 49 c1 d8 1b 1f ab 0b 11 df fa 71 ff b6 d5 0f 83 32 29 3b 1d 0e 2b e9 67 cc ba a2 05 61 6d d4 7e 8b 9f 1e 07 36 cf 07 eb d6 3e 4a dc e9 db 34 9e 9d 3c 1b 6c 70 fd 07 d4 58 1e 98 c5 8f 3d 27 34 9d ec 46 52 54 48 af 9e 57 1f 43 89 e9 2b 6e bf 3a f0 d1 43 2e 5e e5 e5 83 a5 0f c3 9f 75 6e ed 6a 9e 5f af a3 81 3e 8d 2b 5c 57 85 99 bc 9d 9a d3 b6 3b 06 db 42 3c 9e ee d5 ad 5e d5 fd aa cd 31 a1 82 25 47 43 ee 5f 1c d8 6f 51 d7 b5 5a ce 23 96 75 a6 56 16 5d 24 53 b9 ac c6 64 9d c0 9e 8b 1c 95 d1 a3 8d d3 6b 7d 51 1b ce c8 ae 8e d9 76 40 dc d5 8c 38 d7 9c e8 7b 36 1a c8 87 2b e1 aa 7b 23 97 88 14 ec ba d6 85 98 d5 a2 8e cc 9a b3 be 61 39 27 d9 4e fe b3 5b 77 e7 66 bb 8d 4b 76 fd c8 75 d0 ba 24 2c 3e 9b 0b 1c 4b 78 41 06 d1 d6 09 83 35 5c ef f6 e4 7a c0 72 09 20 ce 5a 4e 6e 4f 8c 5a 95 a4 d8 79 43 28 9b ae 2c a7 e7 30 56 e1 b5 34 42 55 38 36 ce 59 65 30 b7 15 88 64 26 28 16 56 d2 86 73 31 85 ab e9 c7 71 3c 6d 39 0d 4a ab 15 13 8e 2a b1 43 eb 41 e4 0e 8e 77 86 2d 3e 40 e5 68 1a 64 b3 ce c4 06 2f d9 e0 90 ba fb 13 a3 94 91 71 40 45 14 6b cc 18 c1 0b 29 0a 3a 4a 55 15 1d 30 1a 0e bd 39 01 2f 69 20 9b a6 69 43 94 9c 98 27 0d f2 0b df f0 a0 bd 6e e4 fe 8c 85 38 ba 7a a0 0d c8 b6 dd 0c 44 a6 cb ed 03 a1 ea 90 9e 4d 21 b1 96 4e b9 f9 23 6a b5 e6 16 54 a0 2d 02 2e da 44 a6 7d 93 58 c1 d1 0c ed de 4d 32 42 d3 d4 ca 15 85 a0 b6 88 44 5d 9f c6 83 b5 8c 60 83 e2 75 80 f7 a2 82 5c ed aa 71 72 98 e8 c1 46 ee 40 25 24 6c 14 36 27 e7 bb 04 1e 65 01 d9 85 07 e6 b7 04 58 0f 0d 67 80 e4 da 04 eb 0f 1c 2f 57 e5 1a 35 e5 3e 66 62 b9 61 20 56 43 89 68 29 fc 15 30 d3 7c 93 5b 6e 49 3e 4f dd cd 78 7c c7 63 bb b3 0a 83 45 32 3b 01 f8 84 3d 20 d8 6e 36 1b 72 ae 75 18 08 77 e8 20 5d e8 c4 78 ed a5 e4 db e2 12 89 77 91 6a 1c 40 4c b6 52 12 54 37 74 d0 73 32 6f 69 de 2a 79 e0 9a 6e 7d 56 b0 47 3f f7 a9 6b 24 7e ea 10 92 df 34 81 58 e3 6a d7 cf 41 36 95 40 fa d2 04 2a d1 9b 0f 0c b0 6e 2f d1 71 05 6c 8d 3a 60 fb 1f 46 1c 5c 16 9c f6 a5 91 89 a8 20 06 90 bc 5d ba 5e 62 e3 75 24 05 af d7 06 c3 dd 5e e4 1e 7d 87 c7 37 95 b9 91 f5 54 d0 cc ad 84 f2 6a e9 b3 11 d9 ae 5d 92 47 bc 39 76 1e 9e 5e 13 50 3b 01 f8 27 9b d9 c1 fd 94 97 da 67 15 c7 ad 97 7d 1d 19 d0 72 e8 c1 4e ee e5 ba 23 89 e1 c4 c3 25 03 a7 83 7e 50 3f 0c 84 c3 d1 20 f6 55 92 6c ea be 12 84 1d ea 41 6e cf f4 35 0c f9 66 9e c0 39 24 05 1e 06 9c e5 12 da c5 ed 4b a8 20 bc 06 35 c7 76 2b 5a 72 27 69 37 e3 86 58 cf 76 27 11 46 c3 72 f5 4d 48 ca fd 13 08 d6 9b 8d 84 b0 5b 79 40 78 87 04 ac 2b c4 23 4e c4 92 23 4e c2 48 f5 b9 95 06 18 af 83 0c 7f af 83 74 c0 ab 51 41 66 45 4b ea 33 e1 0c ca f5 b1 fe 0f b1 8c 65 43 43 3a 85 40 fb c8 c4 76 5f 22 12 7f fa 26 36 d2 8f 9d ac 3d b3 76 3e 88 73 36 bb de 63 f0 01 b9 e5 f0 37 f2 31 20 23 5e fa e6 81 35 5c dd bc af b3 25 1d 68 d6 3a 03 2b 02 f7 57 2c 2d b9 ef a5 24 b6 e3 fe ae 11 c0 cf e2 7f fe 46 b3 25 ab 16 0f 30 64 7c d5 d5 27 80 76 11 49 cd 64 2b 52 6e 64 b3 3b 95 77 0b 02 61 73 28 8c 64 24 57 f8 f9 32 71 bc e9 e4 8a 6c d9 59 df 82 9b 8b c9 35 02 33 85 a8 db de f9 ae 23 b9 bd 29 8d b6 ec b8 d7 07 03 86 cc fc 17 75 24 96 94 53 80 b1 5c c1 95 d5 7b a0 6f 0d 5d aa ac ed fb 3d 5b 46 8b 6e 6c 21 b2 0a 76 81 e0 b0 29 3b 64 d8 94 05 a2 67 e9 20 43 72 78 80 f1 5a ea db 22 1e a1 e1 ac c2 3a 28 00 44 6b 1e 68 aa 7e 8a 1d 15 b2 5f 93 7c fa 09 b2 55 9a e6 37 08 90 27 d4 05 bb 26 fd 38 af 45 36 46 03 96 55 0c a2 51 03 73 0d 5d 3a 50 4d c3 c4 58 8d d8 f9 80 00 51 ec 53 22 51 e1 dd 04 e2 de e9 65 00 db e4 4b bc 6a 36 02 50 1c 29 18 31 7f 97 74 46 d8 03 29 ff 09 60 44 00 a6 54 88 ed 13 a4 4c 05 1b 34 e5 cf cd e3 27 78 12 52 93 35 e1 2e 8f 5c 0e 01 10 11 33 2c 33 7a 49 7b 54 b0 61 cf e6 12 d1 a2 13 80 13 4b 6c 2d 19 5a a1 6c f2 18 29 36 e3 ce 97 ad f6 79 14 59 3b 0b 78 53 26 d0 ed 5d 3c ac 4d 03 bd 36 31 c6 32 f2 40 e4 ea 64 5b a9 c3 1e fe 27 08 ad 6d 29 3b 47 06 9f 29 b1 64 67 0e 31 fd 38 80 79 19 b0 b4 aa 6f 35 fd 62 ac 13 9a 6f 3c 5b a7 b5 3b 65 67 03 ca 40 46 18 82 27 ab 71 4a 8e b4 54 b6 7d 9a 51 19 10 bc 8c 40 65 6c 63 95 c4 cc 04 d4 dc 0d c8 57 92 90 9a 3b 8b 45 f2 f8 02 ac 11 b9 6d f4 8b f6 56 d0 a9 e1 61 eb 63 d1 47 80 ac e5 df 66 30 97 76 7a 40 a6 b4 30 5e 7d 7b b7 88 f2 8d 69 b9 cd 99 ab 0c d8 2f d4 39 2d 9d a3 b4 8d 89 95 d3 43 2b f8 13 b6 f9 2b 3b 92 c7 ae f9 8b 05 02 06 2b c4 4a ee 75 d2 4f b9 cc dc 6d 66 ac dd 7b 45 d8 99 6f 07 39 de 22 ad eb 90 d7 ca 28 a2 56 58 c8 0f 24 a0 5f 65 42 c4 da 67 5e ec 65 46 60 f9 e2 e0 a1 60 69 fc 73 83 45 0a 26 49 b9 e1 2a 7d 5b 91 c0 b6 9d de f9 2b 17 8b 81 18 0c b0 f5 59 02 e3 74 c6 75 10 1b 9a e4 3d 74 d8 93 38 a0 40 85 80 2c f5 1d 8e 56 aa c3 b6 4c 8c 87 30 c8 c2 75 ef e0 bc cc a7 a1 8c f8 77 a9 80 1d 49 e4 8a ff 45 c7 bf a8 c4 be d7 3d 72 d8 4d c3 b9 1a f0 86 00 26 d5 3d 6e 24 72 a6 ad 3c 2d 4c 8a 59 19 ca c0 91 be 00 36 26 f1 1c 1e 79 34 a6 1b e9 20 b7 6d fa f1 8d 75 06 5d be 5d a1 de 49 e6 6d 46 40 0c 92 84 cd 52 3b 18 a5 f8 56 58 f2 6e b2 cd 89 ff 68 7a e9 3e 19 f5 20 93 6c ba b6 82 cc e0 86 a5 90 a0 41 8a 07 ba 31 5b 75 75 63 c2 99 70 92 cc 03 a6 c1 5d e9 5d 0d c5 2e ba 51 da 9c 86 c2 6a 8e 33 e8 76 52 c1 dc a3 8e b3 68 55 57 09 8c 4f 72 4b af 06 20 99 f3 af 82 1f f6 97 2c 1b fa 4c 36 02 fa 19 26 ec f4 13 f1 7b da 21 0c a2 2f 91 62 aa a2 70 54 c9 67 4d a8 c6 16 c0 33 62 41 41 6c 1f 23 cc f8 33 e0 be a1 91 72 ed 7e 8b 07 66 1f ed cd 62 b9 1a 3a d2 db f5 eb 9f 79 ed d8 6d 22 0c 78 d7 4a 10 26 f9 96 90 52 43 24 0f 33 e9 76 2e af 40 f4 19 15 4c 7e 7e aa bd 18 18 56 5d 4a f7 2d 09 c6 f8 fb 17 82 f7 0a c0 5b 0f 16 df 17 17 c9 d7 7f 91 9b 19 2c 35 2f 7a b0 a6 01 71 8a 24 e1 2d 97 87 59 77 0f 79 69 21 4e b1 09 70 41 bc b9 fe 5a 1e 05 42 3a 2b 21 55 af 8f 37 d7 f2 1c d7 30 01 e4 0e 12 dc 10 b0 3c 5b 78 c5 00 b0 80 38 cc bb 4f 56 dc 7e d7 d8 57 de 71 84 55 94 59 97 2e bf 2d 08 c8 39 13 c0 25 28 9e a5 8f 29 02 3e 0a 49 b2 79 6a a2 04 56 4e bd 8e 88 f9 58 8d e2 83 2b af 80 70 f2 3a 48 b1 4f 59 6f bb 5f 55 b2 3a a8 19 59 d7 06 da e4 16 57 c4 7c 2a 8d 92 8a 88 ab bc d2 04 e8 a7 06 b1 af e2 1c d3 57 7a 20 6c 8d b8 ca 8e a9 07 1f 38 37 44 ef b5 53 80 f3 98 89 33 3f 54 7d 71 f3 92 c4 df 5c 65 6e d8 5f 1f fb 0d c6 d2 f0 9b 92 a5 ee b4 34 b3 be 78 90 e9 40 02 a0 b4 56 70 f1 d6 88 ed 9b 93 1b 98 d8 b2 30 30 f6 da 7a 86 48 7c 13 5d c1 79 6d cf 03 81 d8 77 3e cf f9 ab b9 3a be fc 23 37 39 c1 d1 56 2f e3 6a 98 13 83 68 ab a4 19 cd 77 08 6e 88 47 f2 e3 51 b0 f5 34 d0 5b 7c 33 cc 88 4d c8 a6 c9 39 31 84 cb 15 aa 94 8c dd bf 0f 3d 9a e3 79 97 eb 36 c1 c9 62 26 21 96 d6 e0 a8 81 bd ab 26 f6 cc a5 e6 91 db f6 52 5a ab 95 da 1a 20 22 ae 45 a9 a9 95 f6 52 d4 b6 cf a3 44 42 ca 18 4f c3 c5 1d 86 f9 33 57 dc 6f e6 e7 93 1f df 31 bb 18 0a 9c 01 c0 a5 64 46 94 3d d9 cc c4 6a 56 82 6f fe 95 8d 07 62 54 e3 0e ce a5 5b 2a c8 54 06 90 13 36 7c 37 4c 75 ad 4d 90 c1 05 95 e9 98 df 68 02 ab 5c 0a 2e fd 92 58 5a d9 93 ab 55 52 1d 5c e1 cc ce 6b 4c 6c 17 12 b2 93 96 d7 70 de b6 1c 69 d3 40 73 a5 01 ea ee 1d 73 a4 bc 1d 1e c2 32 b2 95 e0 2d 0a f8 a9 47 f4 a7 1e 25 37 8c c2 43 5c 78 14 8c f9 49 33 a9 58 9f 6b 1e 0e b1 3a 4e 3b a2 3a cf 2f 4e c5 5f f8 5a 75 a5 93 f1 1c 49 9b fc ec 6a c0 88 74 dd 42 4b df 62 59 36 59 5c 55 a4 10 b4 dd 40 88 db 89 86 27 25 26 24 6f a9 ee 29 5e ae ba c8 83 3a 32 88 34 d4 e9 1c 3f b1 69 75 88 eb ee 8c b1 57 4b 39 67 0f 3f 9d 80 0e 43 85 23 d6 cb d5 ae 46 93 99 98 d0 d4 8e 64 36 d1 4d 61 a9 02 c7 cb b8 30 9c 82 3d 4a 07 d9 95 9b 6b 37 85 f7 f9 7b 72 a4 f5 91 02 ab e9 dd 99 65 bf f9 3a 0f 34 91 bc be 19 49 95 79 93 ad 5a f6 ed 49 6a 55 f9 b9 19 37 30 e9 8f 88 9c 25 62 1d 8a 2f c3 16 5c ae 3c 50 92 88 7b 9b b6 b1 f4 4e 0e 5a b1 d7 bf 01 a1 1f cd e6 06 2b 24 72 a6 b6 d5 7e eb ca 79 a4 44 c4 38 71 97 7c 90 48 52 8c 48 f1 cc b2 5e 30 3e 87 55 72 76 f9 da 95 93 fb eb 53 a7 e5 95 4b ab da 7a de 0b d3 3e 0f c9 86 24 6d 2e 3f 7d d6 d4 29 a1 e2 a7 53 73 33 b9 68 02 a8 13 2a 74 63 9a 68 99 74 6d ae d7 f3 4a 78 82 c9 42 14 db ea a0 7c 9e 32 c1 e3 6a a4 81 9f e8 85 4b f5 e1 a3 99 3b 2d 47 b4 a4 a6 7e 9e de bb ca a0 e7 e9 db 23 cb 5f ec 54 b7 a8 58 5b 18 f2 aa 6b 02 7d f9 ff f3 fe 87 67 cb dd cc 75 2c a9 cb 98 18 57 3f c0 9f 2e a7 b6 6e 11 32 37 a6 32 12 0a 2f 86 94 60 8e 0e 5b 04 3e fd a4 e2 13 8d 54 1c ea 5e 46 e2 d4 87 ea 85 1c 6d 86 dd 8e 70 5c 70 e4 49 e7 a7 a7 dc 10 6b cc 5b d2 37 f8 74 ad 3c ef 2e 53 6b 99 da e3 8f 04 8e 62 53 1a b2 97 f7 01 9e 39 85 aa ea ce c4 cc d6 dc d5 37 b3 df c0 e8 c5 fc e4 0c 42 19 93 e3 66 c7 67 b2 4e d7 ea 74 df 97 b9 77 26 90 e3 3e 77 f8 e5 6c 61 21 d8 2c 35 98 0d 7d eb b6 0d f5 95 bd 4a 54 e3 da d4 7d 97 47 4e b2 6d 14 78 54 fa 5c da 01 6f 26 39 84 03 ec 64 9c fe 9b 1a 7d b7 d4 45 26 cb 86 a4 51 3d 5c d3 1a 59 b3 61 54 c7 f0 64 4c 23 48 38 6c b8 77 25 48 96 e1 3b 01 4a 7e 86 25 71 a1 17 00 9b eb 03 78 e5 7d ce 3e 8c e4 8d 72 bb 8a 54 bd 0f 4b ab 87 58 32 54 43 7f 5a 52 f5 d8 47 b9 ea 01 60 c4 46 00 77 17 43 b9 40 93 21 da ba aa 0c 17 63 97 bf 66 0a 61 77 20 23 95 da 1d f3 03 13 a7 d0 3a 5e 4c fd 05 26 fb 66 e9 f3 2b 9e 9c 9e af d6 97 c6 d6 90 7f dd fa e9 67 71 cf 33 4d f4 57 b6 e5 3a 7d 8f fa f6 ef bb 73 bc 1a d1 fc 72 bd 4a c3 e7 d6 57 33 1b 0d 8b 9b 3d 73 9e a2 9f 04 ad a9 c6 b3 e1 73 5b e6 65 ae 08 da 95 eb 85 ad c2 b6 70 47 09 a7 7f 39 a1 78 f6 e7 ad 3b ef a8 90 f7 9a d2 26 85 be e4 29 7c a8 5b 1a 11 db ab d7 89 4d ab 10 5e 56 4b 82 a9 4e 25 d3 1e 5e 19 9a 17 93 2b 94 a8 1c 24 30 fa 12 43 a1 79 42 b6 f3 2a 95 1a 4c 9d df 1e ae 95 d6 6c 21 ae c4 e8 8d 7a 48 dc 34 bd 8f fc bc 10 0c cd a9 60 2f f7 22 56 63 cd 5c 73 a4 f8 67 cf f6 a7 5e da 10 ed 1f 6c da 73 3d 4f 27 99 09 4f 08 04 3a 3c 31 cb 56 3d e2 9c 26 b0 54 96 a5 2c e6 87 2d 57 ad 24 44 33 2b 75 c9 8e 58 d6 ea b5 76 47 78 61 f2 92 32 e8 53 38 47 df fb fa d2 a2 b3 4b 84 78 34 c8 d4 32 a1 16 5f eb a8 4d 74 c9 b6 95 e1 aa 3a f8 a6 8d 10 2a 5b cf 82 0c ab 12 ce 9a 8e 90 6f ae 56 b9 19 3e 96 9e 1b 89 f5 6b bc 62 7d 62 d4 be 2e 14 ea 86 41 f4 c6 38 79 fc 6c 6c bb c7 1b ce 83 f3 5d d6 88 9f 03 30 48 95 af 7b 2e 39 1b 3d c0 44 0f 20 4d 05 73 ed 52 a8 f8 47 fb 1a d1 0f 0e 7e 72 2b 6c 35 2d 0a 73 4e 52 5f 87 97 86 df eb da 5c 31 45 ca 8e b4 96 46 b3 82 17 0e 06 b9 7b de b0 de 86 13 a8 ad 79 40 24 31 41 ae bf 82 1e 3c 16 4b f4 c1 8c 5c 3a a0 da d8 be 9b 6b 62 e7 5a 5f 25 a2 c1 03 9d 3e 1e 76 21 c1 f3 6b 58 4a 42 60 e5 2b 89 a9 7d 07 6a 7d f1 5d 01 1e a1 c4 6d e6 29 20 b0 0a 49 d7 e5 5d 1e 10 bd 54 fd b0 fc 74 bd 49 24 16 64 8e 32 a1 12 9b b5 cb dc fe 20 47 93 20 b4 77 d0 26 b9 b4 7b 7b e1 e1 31 56 fa 41 8a 59 91 68 7d 89 70 5c f0 e7 58 c5 9c 76 4a f7 b5 f0 d6 5c bd 25 07 dd 41 e7 38 13 5b b1 7c 60 5b 6a df f0 3a 6c e3 b1 55 a1 e0 39 80 6c 29 3c 3c 67 6b 4b 58 69 2d 3b a4 1e e8 10 86 7e 5c ec a6 dc 7e b5 31 c1 75 2a de bb 3a ed 73 07 2c 43 9c e4 e6 5b 77 c9 e5 1d 0b d5 de 0b b5 07 77 39 ca 00 d9 74 02 6c e1 0b bb 51 70 eb 31 26 b6 7a 0a 04 ca c7 25 6a b2 ef d0 fb 0f 88 1f c0 5d 95 94 7c 27 08 32 6e 4c 81 da 51 ef ee 8b b1 02 8f 18 eb 1f 86 c6 9f 99 f4 22 c6 4b 51 31 1e 46 b0 d4 6f af b7 a9 d0 c8 46 f3 f1 38 eb 75 ec 44 b9 0b eb ec 06 72 53 84 11 05 75 40 36 85 eb d7 98 ed 37 7b ba 20 53 00 7d d9 3a db 41 38 e5 b1 0f 04 65 91 08 36 61 a4 f9 98 e3 91 17 12 05 c0 be c2 c4 68 2d a9 ae 39 bc fa 99 44 74 41 8b 80 ca 48 0a 83 b5 f5 a7 33 8c ea 80 8a 7d 80 61 8c 80 e0 11 d9 0c b3 98 4d 80 94 5c a0 da ac 64 81 7e 59 9b 94 69 58 95 3c 5c e2 17 e7 f4 32 60 ae 61 60 9c 26 bd 2d ed 10 12 fc 91 82 c1 2c 40 89 d1 59 d3 59 63 e7 1d c7 d6 a0 b2 9a 8b 10 35 91 fc ce f3 b6 b5 c3 1d ce 13 8e d2 8e 67 3a 9d c3 25 0e 8c 3d 57 db 02 91 f1 63 00 ff 66 9b 45 c0 61 df 82 f3 f8 ed c1 8c ce 7a f2 7d 6e 2b 88 ca b0 40 2f b1 b9 71 50 4e 6e 44 09 29 a6 b3 f0 f3 eb 89 72 bd 7b d0 2f a6 19 3c 58 af 28 e5 b5 67 2b 92 13 20 99 71 72 80 46 15 71 eb da f4 10 24 63 4f a6 60 aa f0 ef 7c d2 e5 78 48 6d 85 7e 5e f3 02 cc eb 13 09 19 9f 83 cd 35 26 52 cf 7b 98 27 ae 2f b9 ef a4 94 4f 7b 9f aa 9e 15 bc a4 6a aa cd 91 a0 b3 da 83 97 a5 e3 7a a0 2c 25 c7 fa b5 4d c9 b6 0d a5 1b e5 6c 26 82 9e 5a 6c a2 77 fa aa f5 7d 2f 28 39 3a 4f d9 54 1b d8 6d 38 83 2c 51 7e fa f5 3c a4 fa d9 9e 90 27 33 15 6f e5 5d ac e5 b3 65 db e6 d6 28 1b ee 8e f5 fc 98 a7 16 2c e6 80 be b1 d5 f3 3d d9 a8 f1 63 89 70 5f ee 52 29 11 ba bb 83 e4 01 0a c6 ed 1b 88 48 7f a3 15 9c e5 01 92 fd 4b 12 8d 75 7c 1f 79 e6 d0 8f e8 96 78 f5 5b ed 78 81 f1 8e 3c db 5f c0 2a 9e 99 cb 06 6d 47 12 96 a4 91 33 eb a5 b7 a5 5a 3c 9e 61 36 57 bf e3 65 be e7 d3 f3 48 54 45 02 15 ec 95 67 7b 7d d8 78 da 0a f0 9e e5 88 c1 77 32 48 43 3d 82 47 3c e2 0e 92 2e 72 6f d6 bf df 67 99 56 36 9e ad 6e 04 75 66 20 5a b9 57 a7 e3 1a 0b 34 72 29 58 61 7d c1 c9 66 79 42 95 65 c6 3c 3b fb 10 e4 64 11 4a f2 8e 12 aa 99 35 b5 da 00 5d 1c 10 88 b8 b7 89 c4 2d 15 32 99 11 0a 38 4a 39 96 97 d6 5d 73 59 97 07 d7 75 40 fc b2 a0 71 44 f4 26 b1 dc cc c3 f5 74 05 ee 45 20 54 6b 83 c1 01 69 4e a7 18 65 c1 25 08 7f c7 32 f2 9d eb d4 60 c6 4d 41 6a 2b 85 22 60 eb 0c 1d 0f 27 af 32 7a 1e 13 75 e4 2e 30 bc c3 fb 9b 77 6a 98 fa fd 14 71 f9 b8 67 b5 15 13 23 4f 83 a5 cd b7 9c 18 12 1b 94 4c bc 1e d3 cf 64 ea 25 39 a2 5b 66 e2 d8 19 93 94 9d bf 0c be 54 62 61 91 d0 17 62 7f 6f b7 d6 8e 5f 3b 95 36 b5 41 b0 14 15 f5 08 5b 54 9f 45 c4 f3 20 46 6d 98 7d e5 90 f6 b7 f2 5d a7 17 62 48 90 82 84 f4 17 4d 39 7d e4 de 2c e1 42 b5 19 ce 9a 25 c9 b2 48 89 e5 07 22 d8 3e f2 e9 e7 82 46 1b d7 90 7b b3 3f 81 f0 46 16 a8 58 fe aa d6 79 7a a1 c0 49 fa 72 44 b9 9b a8 52 13 60 92 1e dd a0 97 78 52 c1 4b e5 04 c3 7e 2d a3 e4 e6 33 1f 5f 43 23 30 75 a4 c0 cd fe c2 ae 12 85 85 59 83 67 35 f4 ae cc 3d 37 79 18 6f 43 c0 be d9 4c 74 bb 50 2a b8 d7 71 44 61 51 1a 04 86 e8 b0 d4 b8 54 c6 dc c7 97 9a 21 be b9 8d 6e 7e fc 08 0b a0 c7 32 93 e9 c9 2e d7 27 c6 57 c7 6c 68 4e 60 64 64 dc a0 51 30 74 a4 82 1c 0b 0a f7 dd 16 c3 c4 e0 4a 00 1f b9 a4 6e 19 6d af ca a6 ea be 91 e5 d7 04 35 90 24 bc 8e 02 51 78 8c 57 c7 d2 a6 4a 55 b9 c0 00 69 72 7c ed f2 f3 c7 e7 ca c2 cb b5 a8 fc 0f bf 4e 62 f7 1a a4 4d 29 b0 9e c3 c4 ec 3b 28 7f 95 a3 7b 59 6c 2d 40 6d 1f e0 bd f6 e9 30 e4 26 a2 9c d1 77 49 d3 01 86 be 11 e7 ae 18 d4 23 59 ea 34 13 17 b8 32 f9 c4 a3 70 10 a0 54 42 36 81 b0 31 2d ed 18 d5 20 77 e9 f6 aa 0f 23 6c dd a7 2e 94 a4 3b dc bd 53 c5 0d 12 33 36 6b 34 7e 18 ab 4e 78 a3 b2 f6 97 6c 7a 40 9b f5 a6 ba 40 12 c6 7d 0e 14 66 6a bd 4f e6 0a d5 b9 29 45 94 71 75 96 48 2b ec 09 24 1f 7c 1e 21 2b 0c e4 cd 4c 20 a7 6d 64 9d c9 69 02 e9 b2 36 bd e5 bf b6 20 76 96 99 df 9c 75 bf ba 40 fb 8e d6 92 16 59 fc b4 19 27 9a d1 d3 ab 40 b3 bd e0 be 47 aa ec fa 5e af 58 12 13 fb 99 02 b7 c9 39 44 0d 6a 91 26 8f ff ad 65 f7 6a 5a 96 e9 60 6b c7 70 7a 54 34 b6 0e 8d 16 fd 35 3e bd 0b d4 05 6b 25 99 e3 2f 2c b9 79 36 c7 5e c7 64 d9 4d 25 3d b4 52 82 a0 e7 e6 91 ca ae 54 27 fb ea 74 9b 17 f9 31 59 47 24 1a 8d 66 d6 2f b1 1e 55 fb ed e3 bc 45 47 b2 c6 ee fe 37 eb 84 cd ad c3 2f 0f 19 64 e5 2e 32 ff 97 27 c0 fe ff b4 a8 2e 10 5e 4d 76 87 3a bf f2 35 77 d3 03 3c 2c 1f 66 61 3a d6 4b 65 68 bc 93 07 81 d7 ce b0 d3 47 c7 95 d1 84 d7 d9 c3 ab b2 0f 0a 20 65 8d d8 0f db e0 f3 f2 83 d7 25 e5 77 6a e1 1a 8f f9 e1 fd 83 ed 03 df 0d 16 cf e6 0f 79 33 85 d4 bf bf de fe d0 31 06 3b bd 5b a5 69 66 53 44 d1 20 e2 eb b9 3a a6 01 4d 10 4c 00 c2 26 cb 4e ed 3b fa 73 07 63 cf b8 27 38 33 c1 5a bb ab cd 04 7d ad f9 6b 4b 55 44 f2 f6 c7 43 b1 0f 5d 33 92 bd 36 a3 2f 02 28 da ae 11 20 9a 66 ea fe 80 35 70 ce 5f 09 29 dc b2 01 47 36 e1 e4 b1 90 d0 b8 02 f1 2c fb 6e 6f 32 e3 9a 8a 21 cb 17 cb cd 03 b1 07 b7 23 ce 99 9a 33 b1 4f 31 89 c5 64 e9 62 26 3e 71 ef 92 5a 2d d6 a2 2e b2 0c 5a 40 e8 be 28 2d b9 29 14 f1 92 4c 42 4e 46 53 9b a5 a9 20 7d 02 e3 e1 00 f2 7e 5f bc 0f 2c a1 02 ff b5 e8 0d af ed cd af d3 e4 d0 e3 81 2f 7f 7f 3c b0 aa 0b 3d 1e f8 26 27 08 3f 67 01 f0 fb 13 19 bc bd 6b 7b 6a 94 83 36 99 c7 70 b4 22 6b 02 44 e7 d9 5b 0d 8f d9 77 d1 32 06 36 83 06 19 84 d3 aa 5b d8 c3 81 e4 7a 20 6c 0f 85 51 5c 5f 45 a4 d5 85 5d 27 5f da 87 f4 52 8b 82 bd b6 ee bc ea 98 df 33 90 08 44 e4 51 ca 1a 6b d1 ce 4a 47 43 04 9d 29 58 14 59 1a 17 b4 67 ed 52 e6 a1 e1 5b ea 57 59 07 9d 36 5d b5 a6 bd ec 4b 46 57 e2 04 ad e1 71 72 c3 99 36 9a 89 74 2f 65 59 f1 89 49 bf 23 4c bc ae 3c 28 be 5a 74 69 bc 4b c1 be a6 82 6d f1 55 b6 e7 b1 b1 c3 5b 61 5d 36 b8 a5 1d 19 c7 04 82 10 f5 49 97 ab 3f 95 60 58 86 28 37 8c 2a 47 b0 1e be a4 33 56 b6 f0 08 08 51 4c 78 64 bf ab 82 69 61 79 cf e1 a5 47 88 39 f5 76 c8 b3 55 bb a6 1d 1e dd cc 09 05 a2 3e 80 4c 95 04 ad 1a 49 b3 c3 64 98 02 1e ac fc 38 eb d0 87 3e 2a 7b dd 92 97 65 16 fe 4a db b6 a4 12 18 32 4c 21 47 eb 92 12 ff 61 1f fa 31 20 d2 29 b0 f5 a7 d7 8c d3 65 55 d3 0f 3f a0 01 5e 57 bb 31 a5 78 a0 5a 29 c7 f2 6d 7c 46 62 ac 17 1a 4e 67 df e9 da ed 45 2b a2 f3 1e b9 de fb 14 04 b1 1a c5 c3 f6 e6 72 4c bc a9 30 f8 89 ef f0 24 4d 3c 58 28 48 64 e9 0c a9 9c 6c 3e d3 b9 ec fe 55 05 f4 98 06 29 4d 34 e2 b0 70 ab 74 4c 4d ad aa a2 e3 3c e8 84 01 66 55 58 ae 77 bb 33 a9 c4 ba 29 2d 4e 12 64 13 df 5d 58 55 d5 89 14 f1 67 ef ed b7 78 70 21 ce 2b fc 7d 69 51 1c 23 78 71 10 04 4e d1 41 f2 55 a9 af 82 bf 9e 85 40 11 40 a2 71 dc bd d1 60 99 de 85 f4 a1 21 dd 53 16 e7 94 4a 5d 3f db 6d 9d 39 86 56 39 97 2b d6 d5 be be f4 71 23 74 21 f9 e5 7e 94 c2 8a 36 d2 62 0b 38 9f b7 3b 19 f7 32 cc a0 96 2d 68 1f b4 9d 6d de 5f 08 24 24 1e be a9 13 91 6e 30 52 e3 f8 f0 5f 11 b6 9c 54 63 59 04 c6 91 41 46 9a 87 71 ab 07 fc fb 7d d4 a2 2d 80 ef b1 c4 1e 3f dc e9 75 25 ea a8 af 95 e7 c0 fb e2 cb 5f 51 b7 94 b0 b6 e7 1d 7b 57 bd 80 09 d7 46 46 a2 cc a4 76 e5 ee 8c 77 29 ec f5 72 1d 2f fd df a4 5b be 8b 0b ac 2e 41 a6 f3 bc a6 fa 59 44 40 25 58 1d 98 61 3d 3f 54 09 cb d2 2a 61 47 e4 d6 35 b9 cd 95 5f 74 58 40 ae 0d 85 fe 3c 3d ae a2 51 13 a8 73 2a e1 d0 81 63 bd b9 05 ab 04 65 59 80 49 9c d5 09 29 be 1d 8a c9 28 1a 09 92 77 a2 40 15 03 b0 f1 4b de 69 d1 f6 4a ab c9 82 4c 0b c0 5e fd 69 fb d9 76 0a 26 88 01 f8 93 d1 9b 9f 7a 33 1b a6 e6 00 ad a7 ee ee f6 e9 7d df 18 d7 af 24 5a 34 75 2d 2c d6 e6 85 4c 41 96 a3 4a 92 76 f5 73 08 da e7 18 a9 1c d7 d4 71 b9 2a a9 fb 58 76 41 56 f9 5b a9 c1 99 aa b3 1a da 41 a8 2b 64 8f 4a 3d 1c 6b ba 1e a3 24 66 fc e6 cc fb 6b 05 39 4f f1 e8 4c 9f d3 a6 fd 84 c3 7d 12 b5 95 56 86 bb 46 be 10 9d fc 48 bb 68 18 f3 e0 dc b8 70 cc e4 dc 79 47 5d ec cf 5f 99 1e 9d 5b de b7 a8 04 af 0c 9f fa 45 77 bd f5 d2 a5 57 8d 1b d3 25 67 ed 0b 0e ce cf 86 7a e6 86 e2 5f 7f 5c b5 37 fe c1 cb 9e 5e 99 fc d1 43 e8 db 43 d6 0c 2a 4b 1b 91 e5 f8 bf 25 6b 71 05 c5 83 2d 54 4a b9 17 14 91 73 4e f3 68 da 37 32 b2 8b 25 df 0c 54 ed 3a ce 14 71 65 62 49 5c 7d d7 38 d9 01 36 0f 7b 62 14 56 c2 fc 99 40 89 a8 a0 5a eb c1 87 6d 74 75 5f 4a c0 b2 77 c8 2e de 75 1c f0 6e b7 00 9f e7 32 cc bd 52 0e 8a 25 24 4c 4d a0 c6 b8 ef 0a a9 f4 69 75 47 93 67 c6 11 aa 3d a3 ef 3c 8b 3b e7 4f b2 fe c3 2c bf 53 15 dd d4 71 81 eb 22 6a c2 34 d2 98 16 3a e6 57 9a b5 80 e0 63 04 e6 8f e6 8e 04 9f 64 e2 c7 2a e1 80 ce 41 5a 85 71 1b 52 9b 54 8b 09 75 01 8e 15 15 5c ab c7 c2 cb dd 66 db 4d 47 80 34 12 fc 95 22 d6 17 bf f6 f8 1c c9 c4 5b 50 20 b2 ea 82 27 6f 59 f9 36 d5 b8 ba b3 8a ac cd 67 a3 2b 2e ec aa 8e 9c 46 5f 40 21 65 0a 81 9a a5 e3 e5 ec 0c 26 04 0a 56 73 78 6d 67 85 d1 76 ae e4 c5 da 1e f1 cb ce fb d9 66 59 83 40 46 ca 8b ea 0a d7 81 fa 39 5d b2 3b 10 38 24 30 db 1d cf 19 ba 3d b8 f0 f2 0b fe f5 07 66 59 ec dd 17 61 8e d6 91 37 6f 7c 96 bd 18 ab 99 90 bb 29 58 58 e5 5e 96 92 dc b3 7b bc 0a 99 7a d1 c7 b3 f1 5f 5e 37 3c 4c c9 d2 59 d6 ac 8c ba f9 17 da bf d5 69 fb df a0 75 9a b0 9c 25 43 7d 11 68 2c 20 22 0b 51 33 be 2a d5 fb 86 b4 a6 ac cb f0 ec 81 60 b9 e3 b5 c6 5e 27 76 aa 8d 78 ce ac a6 60 54 e9 20 ec bc 39 53 df eb 84 7c 8b 37 e0 9d 67 40 50 a1 8e 28 2f 7b 4c 28 43 38 6e 37 dc e3 f6 9e ea bc 55 64 c2 d5 76 b8 be 1c 08 6f 49 20 9e b1 a3 93 0b ed 13 70 cc 95 22 b0 d2 d2 3b ad aa e3 0e 5e f9 7c 6e e0 f0 9c ca 98 75 ba 75 01 a9 9a 90 fa 3c 1b 68 0b d6 cb 84 ff c9 33 50 98 64 9c f0 16 25 99 86 a7 3f 32 24 5f b9 f9 ee 3a 8d e4 b7 ff e4 88 49 34 ed 2d 4a 03 e1 5e 12 57 ca 13 ba ec ba ad b5 3b fe d9 11 99 77 33 a6 ce 04 1e 8d f0 bc f9 25 c1 3e c3 c1 5a 19 d7 69 52 f2 6c 08 a3 14 75 cf f7 9f 1d 3b 71 4c 7b 0b 71 7f db 27 69 cd 01 5a 41 fd e9 64 20 2e 0d 05 95 18 09 da 91 9c 0d 21 20 a3 8d 54 64 5c 1a b9 33 74 ed 25 25 82 8e ef 3b b5 ba 05 a9 11 8b 6d 4a 6e 4c 8c cf 55 c0 ff 12 95 61 7e d0 3d b2 12 e3 e8 07 e1 d7 32 14 54 26 f0 d6 e3 c4 f2 7f 5a a9 57 33 5b 94 ce 7f 9f 89 2b 18 c6 c4 3a 52 0c ad 7b c5 9e b7 ff 3a 2e d1 3c c6 34 c8 66 fd d3 0f 48 8f 65 30 cc 24 b8 67 19 c6 69 bb 7e d4 af c4 b8 4e 81 b0 8b 04 2d 1d 09 8f eb 65 98 82 f8 94 c2 12 8b 0b 22 b4 50 8c 87 34 c8 75 7e f4 4e 39 4b 82 72 e8 6e 94 91 27 80 90 3f 85 aa ed 51 2c d8 01 55 8d 20 23 8a 4d 1f e3 81 da 1c 08 7f 19 68 d2 6e a9 17 21 41 35 0d f4 6a b1 07 31 2b 61 19 92 95 88 71 84 1e 75 b0 1e 9e 3c 78 09 3d 56 65 ba 53 66 4b b7 62 df ec f6 43 22 eb ba bd 23 e6 13 36 d5 36 f5 e8 3b 26 3e 5d 7c b6 4e eb a4 98 64 e6 ab 8b a1 06 1e 84 3c 43 81 4e 9b b0 ee 99 da 9d 56 1b 56 66 ff 69 cf b8 e1 6f 2d 17 13 19 4e 53 0f ac 5a 67 bd d8 22 47 1b 3e a0 d2 68 3e 7c e2 b9 33 48 3a 92 30 09 de 02 39 3e c7 a4 46 74 01 6f 6a 04 fe eb a4 86 97 35 74 96 00 41 24 14 6a 1f 00 f6 f3 25 6d e7 73 48 c2 57 8e 71 bf 11 ac 3d 69 e1 a6 5b 7e 26 3c 69 60 c3 2f cc ff e2 91 b5 1e 91 1a d3 82 5c 9f b7 3b 39 d9 f1 1a dc 0b 5e 25 13 ff d5 c3 6e dd 67 91 9e d3 26 ac ac 8d 9e ab c6 ab 42 94 64 82 fe ab 3d 79 51 c9 0b de 0d 37 cd b5 c2 7f 59 55 d5 57 ad b4 04 33 ae e0 3a 3f c3 2c 38 bf 4d 97 f9 5f 16 9f 3e 6c 5a f0 f8 d7 58 eb 6b 11 d0 a9 5a 29 77 4a 2f 33 e6 f1 fe 37 59 7e af 29 72 0e f4 7f 38 8a 86 49 12 bb fe 0f 1e ea 8f 3c 89 7e ff e8 73 fe c8 c3 f4 6f fb 4f bc c8 3f 8c 88 cd fe dd 16 54 8a fb fd 16 e4 9f c3 52 d8 d3 a9 f9 b8 ae dd 5a 41 b7 7f bd a1 c0 3b 72 04 05 2c 29 f7 d8 ab 04 b2 9f 1e 9c ac c9 5e 6d e7 b0 9e 93 3d bb 07 30 73 ba 80 35 b2 8e 0d 77 6d 9d 3d dc 94 dd ce e9 53 1d 3b bb 61 25 d7 33 8d 73 82 89 eb 6b 0b 0d 78 22 76 2a de 68 ae b6 15 70 66 6f c9 fe 75 0b 36 f2 48 e2 3d fc 2c f3 7c 6e a6 e2 53 c0 86 70 40 c4 79 c6 ed 0b f7 e4 d9 97 e1 2b 69 65 3a e1 da 4e 92 5c 3b 1b bb 04 26 ae 65 bf b2 4e 5d fc 0f 6a b5 ae ab 48 31 93 27 42 ff 4b 27 dc f8 56 fd 6f f0 7b 7f d2 73 73 3d ca 0e ff b8 59 fe 9c aa 76 df 2f fe c7 dd f9 e7 54 95 b7 a7 e5 3f 75 07 7f 4e ad bb 8b 6a 4c 73 2f 8d 7d 13 59 1a ae e3 e4 e3 d5 03 84 9c 26 90 ec c8 d2 71 b9 d2 74 16 08 32 00 9c 11 36 31 d8 48 6d 7d 41 86 0c f7 53 d1 fd 24 e1 b9 b2 d6 82 5a 1e 70 37 32 b1 df cf db 9d b8 5a b7 92 0a d5 f5 60 f2 bc 2f af 70 1e 5b 11 95 7b e7 cf 3b db 2a 87 df 79 db ea ce 3f 78 db 3a 57 a6 45 d7 d2 33 e1 4f 13 8e 74 cf 1d 3b 9a 34 9e 9d e7 f0 e6 32 fb 79 9c 9b 40 e7 db d5 82 4a 09 1b d5 a4 ac 1f 4d 6e 4c a8 98 7a bb ea ce 8d 9c f1 1d 8a 43 48 8c 7a 65 ae f1 2d b9 35 9d be 3b e5 b6 5a 7d e1 ea e9 b5 1d 95 58 bf 44 a2 58 5a 3c e0 c4 7c 40 20 3c e6 fa 13 e2 a6 23 d1 ee bd 7d 0c e3 6b 22 f2 3c 0c c3 13 f0 83 bb 47 fc 5d c6 4a f1 25 e3 e1 bd 0f ac fa 74 62 46 3a 54 ac eb f5 aa df b4 5f 8c e8 1c fb 08 d8 02 24 5c de 14 12 39 4c 28 90 76 3c 9e b2 9c 13 ee be 6b 4f 28 b0 d7 01 7c cb a8 3e 3d 43 9c ca b6 80 90 a6 c3 39 8b c6 b4 02 ba c7 b4 87 35 fa 7d c7 37 81 04 db 58 9d 8c 59 d6 05 80 20 73 0a 14 61 3a a2 8b 73 f1 36 fb 4f 9e 39 57 53 3a 9a 9a bc 98 cb 3a f9 6e 2f 89 59 9b aa 15 2e b3 86 1d e1 a8 f3 16 08 43 c2 80 ed df b2 d0 d2 bf 65 1e 88 ea e8 57 80 e9 f8 5d cc 7f c5 c9 c4 90 8c 5d 0a d7 1c 75 13 ce 8f 38 ac 92 1e 79 c2 1a 98 ff 97 1c 88 0c 59 bf a0 70 6d d7 71 ba 7d b3 96 d2 9b c1 b3 12 b9 06 ff 12 b1 a1 56 a9 49 3a 0f a6 4f 1c 69 f9 5e 31 f8 cc 4b 22 8b f9 26 af 36 31 96 e2 14 d8 5a c2 fb d7 4c 7c 2d 32 f1 bf bd 38 17 1d d4 b2 b7 7c 7d e9 a3 7d 7d 7c a5 68 35 f9 ff e4 28 a5 5c 49 63 66 cc 93 3a 24 25 71 b9 96 d2 aa 7b b9 fa 20 f3 af 47 b3 91 14 62 ac d3 f3 1a 0e 3d 9f bd 21 15 3d 9f fd ee b7 f3 d9 cb b2 fe 76 3e 7b e6 e8 df 9f cf 5e e5 eb 32 24 ce ec 78 22 ba b9 4b a9 c2 bb 1e 30 07 23 34 d6 ea b3 98 98 8d c5 4c e1 e9 7c dd 70 cb 7b ed d4 82 60 5f d1 94 da 2d 08 bf 4f 37 3d 11 fd a8 f2 01 56 04 ae 60 80 c0 0e 09 59 59 ba 85 bc 43 da b2 2a 9a 70 54 5a 2e ff 87 85 42 dd 91 23 ca ef 1a 01 6b 4d 83 25 1f dd ed 8b 3f 5c b1 ca 57 60 58 0e 15 26 a6 a5 3a 49 96 81 50 06 60 99 51 9a c3 f9 aa cc 2f 32 0c d7 ca 9d f6 e9 f6 25 32 98 54 c0 8a d3 81 30 ce cc ea 61 fc a2 fc 61 02 f0 3e da 20 5f 52 cf d8 e8 53 1f c3 78 13 17 fa da a8 e6 8b b5 da 4c 80 ce 9a 8c aa a5 40 f0 e5 81 7d e9 64 b1 d5 3e c0 3b d4 40 b0 78 6a b9 ce f4 e3 05 2b 7f d7 3a e9 e7 56 2f 63 d8 77 e4 e4 21 20 17 44 66 f2 ca 75 24 fd 7b 05 5c 08 eb 3e 14 ca 28 a8 a6 a5 39 03 79 80 82 2f ee 3e c6 29 6b cb 56 2b 04 ce 07 26 ce 87 40 bb 58 4f a0 82 f0 b1 45 8f 1d bf 1d 1c fa 77 3a ee 89 49 ba 38 a7 5b f1 c7 64 f7 df cb 02 2a 11 ba 15 7f 4c e5 ff bd 2c b0 e1 86 af 52 94 3f 7b 95 e1 ec b8 04 51 72 26 51 62 66 c0 37 cb 41 20 ae cb 25 e8 df cd 16 89 87 c8 62 8c ff 86 32 e5 df cb 88 4d b3 b7 2a fe ae 96 35 b5 b5 3a f2 bb 5a f6 df cb 1a 6f b7 25 14 ff 1f bc fe 3a 14 db 1d f1 bf fb fa 4b 42 38 e1 e4 b6 b1 0e e3 aa 06 ca 73 4e 1b ae a0 90 07 9c 3e 26 4e ba 23 ed 58 6a b6 d6 07 01 ce b7 25 0b 1f 85 d2 b8 f7 94 45 4d 80 50 4b 02 63 5d 75 f2 15 b1 4c 10 25 d4 80 ab fd ac 03 7b 35 5d a5 67 0b 27 ff f2 c9 93 de bd 9c e0 bb 96 3f dc 79 5a 4e 14 04 3f c4 da 32 3f 16 88 71 53 3a 08 1d 4c ec 71 33 d0 a7 dc ab 1b 16 d7 1f dc c0 7e 7c f5 7d 95 b9 41 0b 63 7a 44 f8 ea 79 c9 a3 f5 b4 34 f2 ee e1 bb 0c e5 33 ab b5 e7 81 3e c8 83 fd 07 66 5d 3d d5 d7 da 52 68 95 64 35 f2 7d a2 82 af 93 1a 72 67 80 09 e9 99 fa 34 69 f9 d0 45 6d 86 fd 70 15 05 ca e9 80 ff 38 7a 2f d1 81 48 25 e8 03 47 86 a1 a1 e3 68 60 1f e3 3a 66 7e 9b 07 74 26 0f 02 96 85 7b 6d da 51 98 15 52 ea eb b7 04 42 4a b7 5b 5b a4 8d 11 53 6a e6 b6 ae 3d c2 a8 52 f4 d8 c2 c4 30 72 41 30 5a 01 ef 5f 1f b6 c2 bd 15 2e bc e5 dc e4 be a0 32 f4 05 e4 23 1a 3f 91 2f 90 18 3a ed 4e 7e 60 98 4b c1 f6 db 39 71 8a d5 13 57 14 02 7b 05 13 1e 5a 28 1e ad 8d c9 56 6f 64 69 9c 9f 00 cd d0 3f c1 8f 10 52 77 61 fa 4e c6 91 72 64 67 bc ef f4 44 66 0c b7 91 ae 6f cf 8f d3 ec b8 07 02 52 ce 10 3c dc ab ca a8 13 88 43 4a 30 f7 5b 20 eb 7d 25 4e f0 65 54 2d 05 9b e6 07 3a 71 4c b8 b8 73 40 5a 6f 02 ce 9f 01 6f 13 5f 57 cb fc 7b 03 2f 74 1e 85 ec 3a b6 3f f4 cf f3 7b 02 b9 13 b7 aa 2f 0c b9 8e bf 5e 44 a2 6f 5b 02 d9 a4 fb 4f a4 db 61 72 f5 85 3f 26 dc 7f 16 dd 8e 6a 96 c4 fc 27 05 ce 9f 45 cd 83 f2 e5 37 fe 56 fb 63 df 9b 7b 1f 5f f5 b7 d3 45 88 a2 87 12 f9 87 b5 25 a4 e6 6a df 57 af c1 24 c1 ff 22 19 fd 03 4f 62 3c f9 1f d3 b5 3f f2 74 ff a7 09 cd 1f b9 f1 ec df 45 2b a5 47 7f 88 56 cf b1 6a 21 29 92 8b ae 83 f6 d9 ce f3 09 76 2f 30 56 e5 5a 9f 1f d0 c4 be b4 53 90 d0 b1 84 8a 04 8e c9 e1 a2 9d dc e1 a2 1d 86 66 40 78 25 03 e2 e6 1b 5a 2e 1a 46 6a 83 5c 48 3d 10 ef 68 fb 54 90 a9 9c d8 24 0a d4 aa 02 2e 5a 59 c7 02 f3 cc 95 38 17 7b 55 f3 a9 7f 5f c5 f4 f1 b3 57 5b de d2 55 53 e2 a6 0e 7e 79 53 b2 e3 47 46 e6 e8 e7 f8 13 ea a2 83 df b7 fb b0 40 15 b7 c2 c8 ba 7e 17 cf 75 14 08 dc 26 30 e9 f8 55 77 3a fa 1b 13 d2 38 4c cc b4 38 6f 91 bc 72 d3 b0 d7 04 b0 29 00 cf 0c e7 4e 27 5f 02 38 f0 df fb fb 07 ec 3b a7 62 79 ce af db e7 d5 3d 8a 6b 95 fc d7 7e 00 b2 26 0f ec 26 97 d7 6a 49 f7 75 83 36 15 89 c6 3e 35 8c 58 5e fe 3e 6b 19 da d9 49 27 8f 29 35 4e d4 3d eb 52 c0 36 e4 82 e8 97 71 c2 76 d9 63 8f 28 d8 dc 26 b8 79 88 60 62 cf 23 c4 75 ea 5a fe cf ff aa 02 fb 3e 60 d8 d7 fa 8f bf fe fb 9f 56 6a 61 6d b1 ef aa 3f 1e 04 f9 1f 57 aa 5f ba d1 fa c9 39 5a fc fa fb 9d cb c9 2a 83 f3 4a 43 c5 67 25 b2 85 5f c6 1f ee f8 13 a8 f7 8e 34 fc 7f e5 02 7d 17 f6 3b 0f 1a b2 f9 8f e7 33 a7 52 1a be ff dd 3f dc 91 63 3d b9 43 9c dd 7a b9 2e 68 b5 f4 4c 6c 2b d3 c0 a9 cb b2 f1 77 ff 66 66 e6 73 fd de e4 93 8b cc dd 89 84 f7 0d b3 ba 1a 3a 8f 1a 25 c2 93 a8 65 2b 28 a0 53 12 0a c1 fd fe 07 f1 0c 6f 35 fa 2a c0 7b 17 83 6c 52 b9 d2 ce e3 5e 17 ae ba c6 8d 48 e8 7c 29 0b f7 b1 34 f7 e3 96 1b 7c 02 f2 ae 26 a0 7e 3a 3f 76 85 bd 93 33 fb 16 b0 47 b7 02 b1 f0 5e ad bf b8 a6 7c 74 6a d2 af 6e 57 e8 d7 c8 39 82 c8 7c ca 41 fe d3 fe 92 4d cf be 03 6e 81 0e a2 1d b6 42 d3 d3 8a b9 0e a9 c9 06 7a ab 4f 46 c5 07 2a 1e 95 af 38 59 09 ec 40 26 3c 6f 92 3e 9d ce a3 00 33 97 82 17 7e 27 a7 78 6a 43 a9 45 49 ee bf e2 f7 26 86 96 cf 1c 77 57 97 74 3d 9e 43 b6 5d c4 1b 7a 78 e2 bf 44 aa 5a b8 e3 ee 0b ee 88 f3 39 52 f0 71 ab 6f 96 a3 dc bf 44 aa 9e 14 f9 f9 7f f2 51 e5 bf 5f 01 e2 e2 df 07 5c fc 4f 9b b4 4c e2 7f fc 5a f5 60 15 15 3f 44 84 7f d5 8f 67 ba 0f 38 12 ef fc f1 3b 18 fa 2b bb 9f 1e 07 56 f5 d9 d0 b5 6b 77 ac 9b f2 e8 65 07 28 36 df 02 42 09 05 24 29 67 c9 b6 d8 6e 15 0d 60 a5 1f 19 05 b9 be 4a d8 9c df ed e5 da 7e c3 d1 80 75 96 dc 89 6d 39 87 d8 6b 03 10 e2 1a d8 dd 65 0b c7 bc 0c 89 62 9d 6a 13 72 72 2e 81 8b a1 40 91 bc 9b c5 f6 3a a5 5c ed 09 78 97 50 10 bc 90 3a 92 ef c6 64 42 4f 1c 05 83 f5 cf 48 1d 09 ef 17 0a e4 01 23 9a 82 39 2c 1c b3 5e 25 3b 08 04 30 ff 32 5b b8 7d f8 c9 f3 ef 3e e2 1c 93 fc fb 44 0e 48 a0 02 aa a0 06 ea a0 01 9a a0 05 da a0 03 64 d0 05 3d d0 07 03 30 04 23 30 06 13 30 05 33 30 87 95 60 01 96 60 05 d6 b0 0a 6c 60 35 ac 81 1f 80 02 b6 60 07 f6 e0 00 8e b0 16 9c c0 19 5c c0 15 dc c0 1d 3c c0 13 d6 01 15 bc 80 06 de 40 07 06 f8 80 2f f8 81 3f 04 40 20 04 41 30 84 c0 7a 08 85 0d b0 11 36 41 18 84 c3 66 d8 02 5b 61 1b 44 c0 76 88 84 1d 10 05 3b 21 1a 62 60 17 ec 86 58 88 83 78 48 80 44 48 82 64 48 81 3d b0 17 f6 41 25 54 41 35 9c 86 1a a8 85 3a 38 03 2c 60 03 07 b8 50 0f 0d d0 08 67 a1 09 9a a1 05 ce 41 2b b4 41 3b 9c 87 0e b8 00 9d d0 05 dd d0 03 17 e1 12 f0 a0 17 fa e0 32 5c 81 ab d0 0f d7 e0 3a dc 80 01 b8 09 b7 e0 36 dc 81 bb 30 08 43 70 0f ee c3 30 8c c0 03 78 08 a3 f0 08 c6 e0 31 3c 81 71 78 0a 3f c2 04 3c 83 49 78 0e 53 30 0d 3f c1 0b 98 81 59 98 83 97 f0 0a 5e c3 1b 78 0b f3 f0 0e 16 e0 3d 7c 80 45 f8 19 3e c2 27 f8 0c 5f e0 2b 7c 83 5f e0 3b fc 0a 91 ce 1f 24 43 45 1c 64 1d 64 a3 97 67 eb 65 eb e9 39 05 99 53 97 d4 28 d6 28 ea ad e8 30 70 90 ad 51 44 ef a1 77 fe 78 a1 f4 0e 03 f4 ca d6 a3 78 05 99 07 99 0f 5a 0d 5a 05 99 cf 18 39 ac 19 b4 72 90 05 ed 20 f3 6c bd 1a 3b a4 bd 26 c8 1c a5 a1 f7 50 cc 73 43 b9 11 3e 59 f4 2a d6 40 b8 14 d1 11 41 fb b7 71 51 1c 94 1a 94 02 ed 41 a9 1a bb bf ca ab 51 04 6d f4 1e 42 b5 42 16 09 72 75 28 5e 97 e9 50 fc 4d cb bf 72 5d 97 41 39 bf 59 97 2b 65 eb 75 18 a0 2d 4b 3d 61 d2 8c 2e 3a a3 1a 45 79 83 4f 64 94 bb 46 d1 12 bd 6f 87 5e 33 46 a8 36 7f bd 80 8a 6a f8 db f5 9b 7e 0e b2 e8 bc 1c d6 fc f5 42 e4 ad 41 29 bf cd 16 9d c7 df 5b 45 cf e9 b7 59 fc d5 42 ff 68 bd 19 dd bf f5 40 79 41 5b 18 fe df f5 3f 77 e5 e3 6c 11 1f 94 f7 d5 1d 41 e1 5f a8 08 a6 7f a7 f3 d1 9f 8f 45 38 f4 6e 31 1f cb f8 58 85 43 e9 35 7c ac e5 23 97 8f 0a 24 74 84 b5 88 e7 92 ff 48 45 b0 69 91 ce 6f fb 20 c8 fa e4 8b 60 de 57 7f 3e 7d 17 bf 1d 8f a0 e4 97 04 7e 3b 89 df 3e 82 d3 03 bd 8f 55 08 5e 59 ac e1 b7 6b f9 6d 9c 80 1e d8 fc bc 94 8f 24 04 47 e7 55 05 d0 91 d5 10 0c 5d 34 e5 d3 ed f8 14 7b 04 3f 7c 0c e1 63 21 9f 4e 47 fc 68 de 57 1f 3e fa 22 88 ce 4b 1f d1 a7 16 a7 0f dd 9f d6 22 3e 16 d5 d6 80 af ad 01 5f 5b 03 be b6 06 7c 6d 0d f8 da 1a f0 b5 35 e0 6b 6b c0 d7 d6 80 af ad 01 5f 5b 03 be b6 06 7c 6d 0d f8 da 1a f0 b5 35 e0 6b 6b c0 d7 d6 80 af ad 01 5f 5b 03 be b6 06 7c 6d 0d f8 da 1a f0 b5 45 e9 c6 88 b7 97 fc 42 47 3c 3c aa 89 35 62 4f 5f 04 51 9d ad 11 b9 35 38 6b be 14 b4 4d 12 b0 06 b3 ef 6a 7c 2c e4 23 09 89 04 79 5f d7 f2 91 8a 20 3a 0e 8a 3e 7c f4 45 50 f8 17 ff bf d0 d7 21 63 92 90 98 90 fe dd 16 41 c9 2f ee 7c a4 fd 85 e2 c3 a7 f8 f0 29 3e 7c 8a 2f d2 d7 1d 41 94 e2 cb ef eb cf a7 fb f3 39 fd f9 74 7f fe ca d9 c0 d7 7c 03 5f e2 06 be c4 0d 7c 89 9b 10 3a 1d 89 31 e8 dd 70 fe b3 08 e7 cf 2b 1c b1 f6 66 24 f2 a0 7d b7 21 fc 3e 08 a6 7f f7 45 10 90 11 51 0a 1d 89 42 68 af 9d fc 5e 3b f9 bd 76 22 bd fc 91 d8 24 f9 c5 1f 89 4f ac 4f 74 24 46 a1 7d 77 f1 2d b6 8b 3f da 6e a4 97 02 69 37 bf 1d c7 bf 1b c7 bf 1b c7 1f 21 0e 19 cd 16 89 68 68 3b 9e df 4e e0 73 26 f0 db 49 48 db 1d 41 54 7a 12 7f fd 24 f1 fb 26 81 fb af 38 01 2e 94 7f 59 ca 47 55 04 f7 7c 53 e3 63 21 82 bc cf 38 81 2e fe 5d 14 49 08 26 7e 55 45 10 e5 e9 82 ad df ec 11 9c 87 42 04 79 9f e9 b0 0f 87 ce 6b 1f 0e 1d 79 1f 0e d5 64 1f ee ca 97 1a dc 3e 1c fa 94 f7 e1 d0 a7 bc 0f 87 3e 65 14 0b f9 48 82 4c 84 5e 80 2b c4 d5 08 1e 41 70 ab 60 0d 82 7e 42 b5 7c e4 f2 e9 24 28 e2 f3 14 e1 d0 55 5a 84 63 7d 3a 86 60 fa f7 53 7c ac e2 d3 6b f8 58 cb c7 3a 94 e7 17 2e bf 4d 82 62 7e df 62 7e df 62 7e df 62 7e df 62 9c 33 d2 b7 98 df b7 98 df 17 45 2e 1f 33 71 c7 90 bb 05 08 26 7e 2d e2 b7 8b f9 78 02 41 e6 2f 65 fc 76 0d 82 a8 c7 40 79 b8 7c 24 41 19 5f 56 19 5f 56 19 5f 56 19 5f 56 19 5f cf 32 be ac 32 be ac 32 be ac 32 be ac 53 7c 59 a7 f8 b2 4e f1 65 9d e2 cb 3a c5 97 75 8a 2f eb 14 5f d6 29 be ac 53 7c 59 35 08 25 13 57 83 8c 50 c4 c7 62 04 a9 88 4f ab e1 cf ba 96 7f b7 16 69 e7 21 18 f9 cb 21 04 49 88 f7 ab e5 73 a2 78 8c 4f 2f e3 b7 4f f1 db 75 7c 64 f3 39 33 71 75 88 0d 0b 10 44 b5 42 db 27 10 44 f7 6c 1d 5f 93 3a be 26 28 16 e0 d8 38 bd 6f 35 08 a2 74 b4 cd e5 23 09 b8 7c 1d b8 c8 f8 87 10 44 a5 73 f9 d2 b9 7c e9 5c be 74 2e 5f 3a 97 2f 9d cb 97 8e 72 9e c0 d5 e3 be 21 b3 ae 47 56 0e 0b c1 0f df da 11 2c ff d2 c9 a7 77 21 c8 fb 7e 11 c1 c1 5f 78 08 0e 7f bf c2 c7 6b 7c 4a 0d ae 01 e9 55 80 6b e4 db b9 91 6f 67 14 db 11 4c 47 ec 7c 16 59 9f b5 7c e4 f2 b1 06 d7 84 13 fb 5c 80 6b c6 75 7f 3a 81 20 2a b7 99 bf 62 51 0a 0b c1 0f c8 8c d0 76 3b 82 a8 0e cd 7c 1d 9a f9 3a 34 f3 75 68 e6 eb d0 cc d7 01 a5 64 e2 ce e1 d0 58 83 62 0d 82 62 9f 6b 11 d4 43 66 71 0e 57 f3 ed 04 ae 15 19 81 85 20 3a af 56 44 87 4e 3e a5 0b 41 74 cc 56 64 84 2b 08 a2 a3 b5 f2 67 d4 86 e8 73 02 d7 8e f0 74 f2 f1 22 82 a8 dc 76 be dc 76 3e 27 4a 29 c0 9d e7 af b1 f3 38 75 64 ee e7 f9 73 3f cf 9f fb 79 44 93 13 ff 5f 63 67 1b db e6 55 86 61 db ef db 56 ed c6 e4 c4 5e d2 2e 99 79 6d 27 cd 9a 39 ce 97 13 77 71 66 c7 b1 dd 92 ad 49 60 8c a9 12 62 ac 74 29 19 2a 4d d5 86 b5 83 a1 49 08 fe 20 98 f6 21 04 4c 65 42 5a 91 36 f8 3b ba f5 2b ee 92 e0 2e c5 44 95 36 89 5f 0c 0d 81 84 40 88 fe 40 82 b6 f9 e0 3e 57 97 d3 25 cb ba 45 d3 d5 3b cf 39 e7 39 f7 79 ce 47 bc fc 89 f3 26 f3 be e9 1c 5e 3a 25 26 16 ce 10 79 d6 39 2d 0f 2f 8a cf 69 1f 4f 53 9f d3 d4 c7 f0 94 68 ea 76 86 7a 9e 21 e7 19 72 9e 51 fc 75 e7 ac b2 bd 09 cb f0 2d 58 81 73 b0 0a e7 e1 b3 ce 39 1c 9e c3 e1 39 b2 9d e3 16 9c a7 62 e7 a9 d8 79 9d b4 53 a2 a9 d5 14 ab 9e a2 3e 53 d4 67 8a 95 96 d9 af 32 fb 55 66 bf ca ec 57 99 fd 2a b3 5f 65 f6 ab cc d8 32 63 cb d4 ad 4c dd ca d4 cd 44 5e 71 2e a8 1a aa be 22 a7 c4 93 0b 65 f4 5b b0 02 e7 60 15 ce c3 33 ce 34 99 a7 75 62 a7 44 93 79 9a cc d3 64 9e c6 e7 0c 3e 67 f0 39 83 cf 19 7c ce e0 73 06 9f 33 f8 9c 21 db 0c 3e 67 c8 36 43 b6 19 b2 cd e0 73 16 9f b3 f8 9c c5 e7 2c 3e 67 f1 39 8b cf 59 7c ce e2 d3 f0 a4 f3 3b c7 bb 7a 56 bc 5d f5 af e0 a7 82 9f 0a 7e 2a f8 a9 e0 a7 82 9f 0a 7e 2a f8 a9 68 47 a6 44 e3 a7 82 9f 0a 7e 2a 9c f3 8b ec da 45 76 ed a2 76 ed 75 f1 f2 62 19 56 e0 1c ac c2 79 78 d2 79 5b bb ff 92 33 c7 69 9c e3 16 cc 31 e3 1c 33 aa d2 4b 17 44 33 d7 1c 73 cd 51 c9 4b ce bb ce 8b e2 61 bd 71 97 f8 19 71 c9 99 75 7f 43 fc a4 f3 7b 6e 71 95 d5 55 59 5d 95 d5 55 59 5d 95 d5 55 59 5d 95 b9 aa cc 55 a5 da 55 e5 bf 08 4f 3a 7f 50 9e b3 86 ba 2f f3 38 9c c7 e1 3c a3 e6 19 35 8f c3 79 1c ce e3 70 5e 63 23 5e c0 bd 70 35 e2 dd 26 d6 b8 41 37 b5 54 2b ee 5d 0c 89 27 ae 45 88 78 e8 28 3a 46 6b 9c 48 13 91 04 4c 12 0f ba 61 f7 d5 40 ad 98 5a 0a 89 26 43 98 0c 61 32 84 c9 10 26 43 d8 1d 5f 68 42 27 88 b7 a1 93 e2 d3 0b b5 6e 9d 22 11 e8 89 c1 e5 98 78 c5 97 10 f7 2e b6 89 0b 9a d1 b4 06 dd 7a b5 d6 c0 5a d1 38 af 57 fc 4e 58 47 fc 2e e8 11 89 a2 63 30 4e a4 19 26 88 b4 c1 a0 db e0 56 fd b5 62 70 39 24 1e bf 5e 8f 8e 40 8f 48 54 dc bb 18 13 cd 67 03 a3 9b 60 42 2c ca 61 03 6b 69 d0 1a 43 6e a3 eb 69 15 8d 1a 1b 85 09 d1 38 8f 88 35 a2 71 1e c1 79 44 99 eb 88 d7 13 bf 0b 7a 44 a2 30 26 8e eb 93 8c e9 df 0c b7 13 4f c0 24 fd 83 ee 67 61 94 fc 51 f2 47 c9 1f d5 d8 3a 22 f5 f0 2e e8 c1 66 fa 24 18 95 24 12 74 63 9c 8a 98 46 d5 8a 27 ae d5 89 57 7c f5 a2 d9 17 13 8f 8a 66 ed 31 39 4f 88 ff f9 6f 12 1d f1 cc d8 a0 1b d7 6e d6 88 9e ce 55 5c 3d c3 e2 15 5f 9d 58 f5 d7 8b c6 83 89 44 44 93 33 ce 4a e3 e4 8c 2b 7f d0 6d 92 ae 11 cd 2a 9a c8 d0 44 7d 9a 18 db a4 6a 37 a0 1b a1 07 63 f4 8c c3 e6 0f 32 34 73 b6 9b e5 27 22 8e 2f 78 30 2a 1a e7 46 b7 89 45 ed 5a 33 f3 b6 b0 f6 16 d6 6e 18 16 8b 8b f5 62 6a a9 51 34 e7 a1 05 b7 2d b8 6d 61 17 cc a8 24 91 88 d7 c2 bc ad 62 ad 68 76 b6 55 ab 8e 8a 45 b5 b6 72 5f da d8 a3 36 ce 46 1b 67 b2 8d 33 d9 a6 3e 09 22 35 6e 3b 6b 6f 67 07 0d eb 89 44 44 53 b1 76 4e 45 3b e7 d0 b0 49 2c 2e b6 d2 33 21 9a 75 b5 73 de 3a 54 e7 90 68 9c 18 dd 08 3d 71 ef 62 14 1d 13 c7 17 b6 8b 55 ff 0e 22 9d a2 b7 d4 25 06 97 bb c5 d4 52 1f ad 83 44 0a b0 04 1b dc 4e f5 8f 8b 29 f5 ef 54 a4 07 f6 12 4f a3 fb c4 aa bf 1f 5d 20 5e 44 97 60 c8 ed 72 cd 67 f5 2e d7 7c 56 37 3a ee 76 53 ff 14 ad 29 de 93 14 ab 4e a9 ce 71 a8 7a 71 d7 52 ea d9 09 bb e8 df 8d ee a1 7f 1a 66 e1 80 e8 2d 0d 32 aa 00 8b c4 87 e1 08 0c b9 3d 9c f6 1e bd 33 8d a2 a9 52 8f 5c c5 44 e3 ca b4 76 8a c1 e5 2e d8 2d 9a 59 7a 58 a3 e9 3f 88 2e c0 12 dc 05 87 e0 30 7d a2 6e af aa 11 17 cd 9b d6 4b b5 7b c9 d9 4b f5 0c b3 30 4f eb a0 f8 6a a0 80 1e 21 1e 76 d3 8a c4 c5 e3 d7 3b c4 e0 72 a7 68 ea 9f c6 55 9a 3c 69 bc a5 f1 96 d6 d8 7e 74 16 0e c0 12 dc 05 87 61 c8 dd c9 5e ec 64 2f 76 f2 e6 dc c7 8b d7 47 a4 4f 91 1a 37 43 cf 8c b9 ef e8 98 68 7a 66 f8 e9 90 61 5d 19 76 27 c3 ee 64 d8 9d 8c ea df 2d a6 96 7a 68 4d 33 b6 4f bc e2 cb 12 1f 10 8b 8b 83 e8 02 2c c2 61 38 02 6b dd 7e 66 ef c7 67 3f ae fa 39 ed 26 9e 84 9d a2 a9 46 3f 7b 61 38 f2 c1 a8 fb d9 c7 fb 79 9f b3 72 1b 16 cd bb 94 e5 25 c9 b2 e3 59 76 3c cb 49 33 7d 9a 69 ed 82 dd a2 a9 6a 16 e7 a6 7f 06 e6 e1 20 f1 82 b8 b0 54 42 ef 82 43 70 98 3e 31 37 87 e7 1c 1e 06 58 c5 00 ae 06 5c f3 7f a9 03 ea 79 a7 9b c7 4f 9e fe 79 5a f3 9c bd 3c 4e f2 38 c9 e3 24 8f 93 3c b3 e7 99 3d cf ce e6 99 3d cf 7b 3e 48 dd 06 55 f3 0e 74 17 ec 21 d2 27 9a fa 0f 52 ff 41 6a 6e 58 12 83 cb 7b c4 0b 57 87 89 8c c0 a0 5b e0 75 2a 90 b3 40 55 0b 54 b2 a0 53 5d 47 a4 41 34 ef 4c 01 ff 05 f9 6f a6 ff 0e fa 74 d0 a7 93 48 17 ec 21 d2 4b ff 34 ba 0f dd 0f b3 44 06 e0 20 91 22 7a 08 1d 74 8b dc a0 22 95 31 4c c3 02 2c c1 5a b7 c4 cb 59 e2 ac 96 a8 7f 89 93 59 52 05 7a 44 f3 4a 94 98 a5 c4 4e 95 38 33 25 5e e6 5d bc 45 bb d5 b3 51 34 2f b6 61 87 98 5a ea 24 de 25 9a 37 c7 e8 5e 5a d3 e8 0c 7d b2 70 00 e6 69 2d a2 4b 70 8f 78 e2 da 08 3a ee 7e 4e 79 62 ee 10 0e 87 70 f8 00 f9 0d 53 62 6a a9 57 ac fa d3 e8 90 fb 20 e7 e7 41 f5 0f b9 7b d0 7b a4 83 ee b0 fa 34 8a e6 3c 0f e3 73 58 f3 a6 88 f4 c1 3c 2c 10 0f b9 23 8c 1d 61 de 11 d6 3b 4a 7c d4 35 bf 4b 19 e5 05 18 e5 1c 9a 48 1b ad 9d a2 d9 c1 51 4e e3 28 d5 1b a5 f2 a3 ac 71 94 4a 1a 3a 6e d8 e3 93 a1 c7 e7 40 cf ac 34 ec 05 97 9f 43 6f f5 b6 7a e6 37 5a db 3c f3 1b ad 6d de 8f ae 1f 10 9f f6 1f 11 ff 17 78 de 31 f1 cd ee 36 ef c2 d5 2d e2 89 6b 41 f1 f8 f5 56 74 82 f8 36 6f 9b 32 3c 53 fb d4 26 f3 97 22 07 cc 1f 92 bc f1 15 98 ea 35 ff bc 37 e8 04 fe da e5 f3 fd a2 ef 4f 52 5f 26 56 2b b5 9c 59 69 7d 20 eb f3 4d 67 de b3 ad ab 55 9d 55 f7 db 11 3f e8 5b 51 37 b2 b4 e4 9c c0 3b 6b c6 7e 33 eb 04 fe b6 4e be df ca cb b5 ec ca bc 6b 5b 6f aa 9f da d6 af e4 6e d5 6f 3d f5 77 54 58 ea cf 56 ad ed e7 ac 8a fd c4 ae ed e7 dd 1f cd f7 b8 d4 ee 1c 35 b0 ad 4f 2a f6 6f 62 df b6 fd 7e 69 d5 77 6d bf ef 29 76 81 7e 5b d2 2b b1 97 ed da 1e 59 c7 fd 57 a5 1e 1d 34 ea a0 d4 25 c6 ee 56 be 47 88 1d b3 fd ce a9 92 5f 22 f6 e3 75 b2 dc 61 e7 30 fe a6 72 9f 5c b5 dc 3a fb d1 b0 4e bf 2d 7d ab 63 ff b0 2a de b7 a2 de 57 ac 35 b7 52 fb 4d 76 17 5e ea 5a 51 49 db 3a 6e 63 15 db 2f 6f 5b 77 28 f6 5a d6 a8 5a db ba d5 aa ed 56 2d 76 af a8 db 15 3b c6 88 7b a4 7e 85 da a9 39 9a 73 46 6d b6 23 5a 72 1f 1e b1 36 cb cf 6c 2c 6c b3 dc 6c fd b4 6a b3 ad 95 6b 77 ff 9f 56 7d 70 53 74 7b 7c 2b 5f 81 97 6d eb 90 cd f2 90 ad fd 90 d4 2b dc 9e 77 da 3f 9a d9 9c f6 fd b4 be a1 d6 7f f5 fd 45 ea 8f 6b 76 6b b5 7a 8e 1a 04 56 dd da 47 33 ab fb 0d 17 3e 3c e2 0d 5a f3 b9 4f 3a 4d df 91 fa 35 55 db 6a ef ef fb b4 ee 5c 35 f6 c5 5b fa bb b5 ba e3 96 2f c8 a7 55 ef 5a 7f 43 f6 d6 3e d3 fb e9 d4 67 6c ed 6f be 75 0b 56 dd 66 5b bf 6f 5f 8b 03 52 15 54 ab bd d3 eb a9 7d 52 5f 40 39 5a 65 70 cd fd dd d0 bd 72 f7 27 15 2b e7 3e 4e 1d b3 b3 f5 db 5a 1d b3 27 fb 61 9b ef e6 5d 5d 4f 75 58 75 af 55 f7 58 f5 79 dd ad b7 d9 e9 27 ed 4d 3e 72 4b 75 d8 aa 1b 15 0a db 4a 1a 55 63 d5 1d 56 3d 6e 67 0b d9 73 95 54 16 2f f7 71 2a 26 b5 1d 75 af d4 28 23 5e e0 ec ee c8 dd b8 a1 6d b9 95 57 e5 64 f6 e3 54 d0 de fd b3 ab de 97 35 f7 3c 57 f7 43 9f f9 f1 7b e3 af 34 3f fc d4 e1 b1 03 fb f6 8f 79 d3 af 79 0f 8f 8f 79 c3 13 87 26 26 15 f3 0a 13 47 0e 4f 1c d9 37 f9 c4 c4 21 ef f0 c1 fd 49 af b8 6f 72 df 27 f5 6a 37 e9 bc 2f 4e 1c fc 96 89 1c f5 86 0e 69 60 e7 7d f7 75 b4 09 5d 49 2f 7f f0 a0 f7 d0 13 5f 1f 9f 3c ea 3d 34 76 74 ec c8 93 63 8f fb ca e1 17 f0 a3 af a0 2f 69 fe d9 e8 db 38 fc d4 ae 89 43 93 5b 0e 1c dc 77 74 3c 39 39 76 7c d2 35 df 6f 1c fd da 37 c6 f6 4f ba 75 fe 3a 67 6b c0 e7 6e f2 07 36 05 c4 0d 8e ef c3 5f 7e 7f 60 b3 43 46 7f c0 ef 77 fd 3e 7d e3 77 37 38 97 3b 76 9b 46 ff 86 8d 1b 2f 77 5c 1e f2 e9 bb 80 e9 10 ba dc 31 e6 7b cc e9 78 2c a0 ff f6 fa ee be 7b dc af a6 5c e8 36 7c f9 7d 37 cc f8 06 f4 ed ff 01 fe 24 3b d2");
		var fontSWF0:SWF=new SWF();
		fontSWF0.initBySWFData(fontSWF0Data,null);
		
		fontSWF0TagV=new Vector.<Tag>();
		for each(var tag:Tag in fontSWF0.tagV){
			switch(tag.type){
				case TagTypes.FileAttributes:
				case TagTypes.SetBackgroundColor:
				case TagTypes.ShowFrame:
				case TagTypes.End:
					fontSWF0TagV.push(tag);
				break;
				case TagTypes.DoABC:
					ABCData_stringV=((tag.getBody(DoABC,{ABCDataClass:ABCFileWithSimpleConstant_pool}) as DoABC).ABCData as ABCFileWithSimpleConstant_pool).stringV;
					MyFontClassNameId=ABCData_stringV.indexOf("MyFont");
					fontSWF0TagV.push(tag);
					insertTagsId=fontSWF0TagV.length;
				break;
				case TagTypes.SymbolClass:
					symbolClass_NameV=(tag.getBody(SymbolClass,null) as SymbolClass).NameV;
					fontSWF0TagV.push(tag);
				break;
			}
			//trace(TagTypes.typeNameV[tag.type]);
		}
		
		dataLoader=new URLLoader();
		dataLoader.dataFormat=URLLoaderDataFormat.BINARY;
		dataLoader.addEventListener(Event.COMPLETE,loadDataComplete);
		dataLoader.addEventListener(IOErrorEvent.IO_ERROR,loadDataError);
		dataLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,loadDataError);
	}
	private static function clear():void{
		try{
			dataLoader.close();
		}catch(e:Error){}
		dataLoader.removeEventListener(Event.COMPLETE,loadDataComplete);
		dataLoader.removeEventListener(IOErrorEvent.IO_ERROR,loadDataError);
		dataLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,loadDataError);
		dataLoader=null;
		onLoadDataFinished=null;
		
		fontSWF0TagV=null;
		ABCData_stringV=null;
		symbolClass_NameV=null;
		
		onCreateGetFontComplete=null;
		
		loadingDatas=null;
		loadingCharCodeV=null;
	}
	private static function loadData(src:String,_onLoadDataFinished:Function):void{
		loadingSrc=src;
		trace("加载："+loadingSrc);
		onLoadDataFinished=_onLoadDataFinished;
		dataLoader.load(new URLRequest(loadingSrc));
	}
	private static function loadDataComplete(...args):void{
		var _onLoadDataFinished:Function=onLoadDataFinished;
		onLoadDataFinished=null;
		if(_onLoadDataFinished==null){
		}else{
			_onLoadDataFinished(dataLoader.data);
		}
	}
	private static function loadDataError(...args):void{
		trace("加载失败："+loadingSrc);
		var _onLoadDataFinished:Function=onLoadDataFinished;
		onLoadDataFinished=null;
		if(_onLoadDataFinished==null){
		}else{
			_onLoadDataFinished(null);
		}
	}
	init();
	
	public var fontName0:String;
	private var fontFolderPath:String;
	private var num:int;//字体副本数
	public var shellData:ByteArray;
	public var charArr:Array;
	public var getFontV:Vector.<GetFont>;
	
	private var fontSWF:SWF;
	private var defineFont3:DefineFont3;
	private var defineFontAlignZones:DefineFontAlignZones;
	
	public function Datas(_fontName0:String){
		
		fontName0=_fontName0;
		fontFolderPath=GetFont.fontsFolderPath+fontName0.toLowerCase().replace(/[^a-z0-9]/g,"_")+"/";
		num=0;
		charArr=new Array();
		getFontV=new Vector.<GetFont>();
	}
	public function clear():void{
		
		shellData=null;
		
		var i:int;
		
		for each(var char:Char in charArr){
			char.clear();
		}
		charArr.length=0;
		charArr=null;
		
		if(notAvalibleGetFont){
			notAvalibleGetFont.clear();
			notAvalibleGetFont=null;
		}
		
		i=getFontV.length;
		while(--i>=0){
			removeGetFont(getFontV[i]);
		}
		getFontV.length=0;
		getFontV=null;
		
		onCreateGetFontComplete=null;
		
		loadingCharCodeV=null;
		
		fontSWF=null;
		defineFont3=null;
		defineFontAlignZones=null;
	}
	public function createGetFont(text:String,_onCreateGetFontComplete:Function):GetFont{
		loadingDatas=this;
		num++;
		notAvalibleGetFont=new GetFont(fontName0+"@getFont"+num);
		addLoadingCharCodes(text);
		onCreateGetFontComplete=_onCreateGetFontComplete;
		if(shellData){
			loadCharDatas();
		}else{
			loadData(fontFolderPath+"shell.swf",loadShellDataFinished);
		}
		return notAvalibleGetFont;
	}
	private function loadShellDataFinished(data:ByteArray):void{
		shellData=data;
		if(shellData){
			loadCharDatas();
		}else{
			throw new Error("加载 ShellData 失败");
		}
	}
	private function loadCharDatas():void{
		if(fontSWF){
		}else{
			initFontSWF();
		}
		loadCharData();
	}
	private function initFontSWF():void{
		var shellTagV:Vector.<Tag>=new Vector.<Tag>();
		Tags.getTagsByData(shellTagV,shellData,0,shellData.length,null);
		for each(var tag:Tag in shellTagV){
			switch(tag.type){
				
				//case TagTypes.DefineText:
				//case TagTypes.DefineText2:
				//case TagTypes.DefineEditText:
				//
				//break;
				
				case TagTypes.DefineFont:
					throw new Error("暂不支持："+TagTypes.typeNameV[tag.type]);
				break;
				case TagTypes.DefineFont2:
					throw new Error("暂不支持："+TagTypes.typeNameV[tag.type]);
				break;
				case TagTypes.DefineFont3:
					defineFont3=tag.getBody(DefineFont3,null);
				break;
				case TagTypes.DefineFont4:
					throw new Error("暂不支持："+TagTypes.typeNameV[tag.type]);
				break;
				
				case TagTypes.DefineFontInfo:
				case TagTypes.DefineFontInfo2:
					throw new Error("暂不支持："+TagTypes.typeNameV[tag.type]);
				break;
				
				case TagTypes.DefineFontName:
					//
				break;
				case TagTypes.DefineFontAlignZones:
					defineFontAlignZones=tag.getBody(DefineFontAlignZones,null);
				break;
				case TagTypes.CSMTextSettings:
					throw new Error("暂不支持："+TagTypes.typeNameV[tag.type]);
				break;
			}
			//trace(TagTypes.typeNameV[tag.type]);
		}
		
		fontSWF=new SWF();
		fontSWF.tagV=fontSWF0TagV.slice(0,insertTagsId).concat(shellTagV).concat(fontSWF0TagV.slice(insertTagsId));
		//for each(tag in fontSWF.tagV){
		//	trace(TagTypes.typeNameV[tag.type]);
		//}
	}
	public function getCharsFromData(data:ByteArray):void{
		var offset:int=0;
		var endOffset:int=data.length;
		while(offset<endOffset){
			var char:Char=new Char();
			char.code=data[offset++]|(data[offset++]<<8);
			if(defineFont3){
				char.GlyphShape=new SHAPE();
				offset=char.GlyphShape.initByData(data,offset,endOffset,null);
				if(defineFont3.fontLayout){
					char.FontAdvance=data[offset++]|(data[offset++]<<8);
					if(char.FontAdvance&0x00008000){char.FontAdvance|=0xffff0000}//最高位为1,表示负数
					char.FontBounds=new RECT();
					offset=char.FontBounds.initByData(data,offset,endOffset,null);
				}
			}else{
				throw new Error("defineFont3="+defineFont3);
			}
			if(defineFontAlignZones){
				char.ZoneRecord=new ZONERECORD();
				offset=char.ZoneRecord.initByData(data,offset,endOffset,null);
			}
			charArr[char.code]=char;
		}
		if(offset==endOffset){
		}else{
			throw new Error("getFont offset="+offset+"endOffset="+endOffset+"，offset!=endOffset");
		}
		//trace("offset="+offset+"，endOffset="+endOffset);
	}
	private function loadCharData():void{
		while(loadingCharCodeV.length){
			var charCode:int=loadingCharCodeV.pop();
			if(charArr[charCode]){
			}else{
				trace(String.fromCharCode(charCode));
				loadData(fontFolderPath+"block"+(100000+int(charCode/GetFont.blockSize)).toString().substr(1)+".swf",loadCharDataFinished);
				return;
			}
		}
		loadingCharCodeV=null;
		var charCodeArr:Array=new Array();
		for each(var char:Char in charArr){
			charCodeArr.push(char.code);
		}
		charCodeArr.sort(Array.NUMERIC);//不按从小到大排序，将会引起文字不显示的问题
		
		var charId:int=-1;
		for each(charCode in charCodeArr){
			charId++;
			char=charArr[charCode];
			if(defineFont3){
				defineFont3.CodeV[charId]=char.code;
				defineFont3.GlyphShapeV[charId]=char.GlyphShape;
				if(defineFont3.fontLayout){
					defineFont3.fontLayout.FontAdvanceV[charId]=char.FontAdvance;
					defineFont3.fontLayout.FontBoundsV[charId]=char.FontBounds;
				}
			}
			if(defineFontAlignZones){
				defineFontAlignZones.ZoneRecordV[charId]=char.ZoneRecord;
			}
		}
		
		defineFont3.FontName=
		ABCData_stringV[MyFontClassNameId]=
		symbolClass_NameV[0]=
			notAvalibleGetFont.fontName;
		
		var fontSWFData:ByteArray=fontSWF.toSWFData(null);
		//new FileReference().save(fontSWFData,"test.swf");
		notAvalibleGetFont.loadFontSWF(fontSWFData,createGetFontComplete);
	}
	private function createGetFontComplete():void{
		loadingDatas=null;
		getFontV.push(notAvalibleGetFont);
		//if(loadingCharCodeV){
		//	trace("loadingCharCodeV.length="+loadingCharCodeV.length);//loadingCharCodeV.length=20
		//}
		loadingCharCodeV=null;//20120831
		notAvalibleGetFont=null;
		var _onCreateGetFontComplete:Function=onCreateGetFontComplete;
		onCreateGetFontComplete=null;
		if(_onCreateGetFontComplete==null){
		}else{
			_onCreateGetFontComplete();
		}
	}
	private function loadCharDataFinished(data:ByteArray):void{
		if(data){
			getCharsFromData(data);
		}
		loadCharData();
	}
	public function removeGetFont(getFont:GetFont):void{
		getFont.clear();
		var id:int=getFontV.indexOf(getFont);
		if(id>-1){
			getFontV.splice(id,1);
		}
	}
}