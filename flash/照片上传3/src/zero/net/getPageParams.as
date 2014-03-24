/***
getPageParams
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年1月18日 14:22:09
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.net{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.*;

	public function getPageParams():Object{
		
		//allowScriptAccess 和 allowNetworking 将可能不精确，推荐使用方法是先检查 pageURL，如 pageURL 为有效值则不要过多追究 allowScriptAccess 和 allowNetworking
		
		var params:Object={info:""}
		
		switch(Capabilities.playerType){
			case "ActiveX":
			case "PlugIn":
				//Capabilities.playerType
				//"ActiveX"，用于 Microsoft Internet Explorer 使用的 Flash Player ActiveX 控件
				//“Desktop”代表 Adobe AIR 运行时（通过 HTML 页加载的 SWF 内容除外，该内容将 Capabilities.playerType 设置为“PlugIn”）
				//“External”，用于外部 Flash Player 或处于测试模式下
				//“PlugIn”代表 Flash Player 浏览器插件（和通过 AIR 应用程序中的 HTML 页加载的 SWF 内容）
				//"StandAlone"，用于独立的 Flash Player
				
				if(ExternalInterface.objectID){
					switch(Capabilities.playerType){
						case "ActiveX":
							params.object_id=ExternalInterface.objectID;
							params.info+="object_id="+params.object_id+"\n";
						break;
						case "PlugIn":
							params.embed_name=ExternalInterface.objectID;
							params.info+="embed_name="+params.embed_name+"\n";
						break;
					}
				}else{
					switch(Capabilities.playerType){
						case "ActiveX":
							params.object_id=null;
							params.info+="请在 object 标签中填写 id\n";
						break;
						case "PlugIn":
							params.embed_name=null;
							params.info+="请在 embed 标签中填写 name\n";
						break;
					}
				}
				
				//Security.sandboxType
				//remote (Security.REMOTE)：此文件来自 Internet URL，并在基于域的沙箱规则下运行。
				//localWithFile (Security.LOCAL_WITH_FILE)：此文件是本地文件，尚未受到用户信任，且不是使用网络名称进行发布的 SWF 文件。此 文件可以从本地数据源读取数据，但不能与 Internet 进行通信。
				//localWithNetwork (Security.LOCAL_WITH_NETWORK)：此 SWF 文件是本地文件，尚未受到用户信任，且已使用网络名称进行发布。此 SWF 文件可与 Internet 通信，但不能从本地数据源读取数据。
				//localTrusted (Security.LOCAL_TRUSTED)：此文件是本地文件，并且用户已经使用 Flash Player“设置管理器”或 FlashPlayerTrust 配置文件将其设置为受信任的文件。此 文件既可以从本地数据源读取数据，也可以与 Internet 进行通信。
				//application (Security.APPLICATION)：此文件在 AIR 应用程序中运行，并且随该应用程序的包（AIR 文件）一起安装。默认情况下，AIR 应用程序沙箱中的文件可以跨脚本访问任何域中的任何文件（尽管不允许 AIR 应用程序沙箱以外的文件跨脚本访问 AIR 文件）。默认情况下，AIR 应用程序沙箱中的文件可以加载任何域中的内容和数据。 
				
				if(Security.sandboxType=="localWithFile"){
					params.pageURL=null;
				}else{
					try{
						params.pageURL=ExternalInterface.call("top.location.href.toString");
					}catch(e:Error){
						params.pageURL=null;
					}
					if(params.pageURL){
					}else{
						try{
							params.pageURL=ExternalInterface.call("window.location.href.toString");
						}catch(e:Error){
							params.pageURL=null;
						}
					}
				}
				
				if(params.pageURL){
					params.info+="pageURL="+params.pageURL+"\n";
				}else{
					params.info+="无法获取页面地址\n";
				}
				
				if(params.pageURL){
					//allowScriptAccess=="always" 且 allowNetworking=="all"（同域或跨域）
					//allowScriptAccess=="sameDomain" 且 allowNetworking=="all"（仅同域）
					params.allowScriptAccess=null;
					params.allowNetworking="all";
					params.info+="allowScriptAccess=always或sameDomain\n";
				}else{
					//其它情况
					
					var execResult:Array;
					
					params.allowScriptAccess=null;
					if(Security.sandboxType=="localWithFile"){
						params.info+="此 swf 为仅访问本地版本，无法获取 allowScriptAccess\n";
					}else{
						try{
							fscommand("exec");
						}catch(e:Error){
							switch(e.errorID){
								case 2149:
									//SecurityError: Error #2149: 安全沙箱冲突:http://localhost/AllowNetworkingTest/AllowNetworkingTest.swf 不能对 http://localhost/AllowNetworkingTest/AllowNetworkingTest.htm 进行 fscommand 调用（allowScriptAccess 为 always）。
									execResult=/allowScriptAccess[\s\S]*?(\w+)/.exec(e.message);
									if(execResult&&execResult[1]){
										params.allowScriptAccess=execResult[1];
									}
								break;
							}
						}
						params.info+="allowScriptAccess="+params.allowScriptAccess+"\n";
					}
					
					params.allowNetworking=null;
					try{
						navigateToURL(new URLRequest(),"_blank");
						params.info+="navigateToURL 成功\n";
					}catch(e:Error){
						switch(e.errorID){
							case 2007:
								//TypeError: Error #2007: 参数 url 不能为空。
								params.allowNetworking="all";
							break;
							case 2146:
								//SecurityError: Error #2146: 安全沙箱冲突:http://localhost/AllowNetworkingTest/AllowNetworkingTest.swf 不能调用 navigateToURL，因为 HTML/容器参数 allowNetworking 具有值 internal。
								execResult=/allowNetworking[\s\S]*?(\w+)/.exec(e.message);
								if(execResult&&execResult[1]){
									params.allowNetworking=execResult[1];
								}
							break;
						}
					}
				}
				params.info+="allowNetworking="+params.allowNetworking+"\n";
			break;
			default:
				params.info+="此 swf 不在页面上\n";
			break;
		}
		
		return params;
	}
}