/***
AS3BaseEffect
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2012年12月13日 09:50:00
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.stage3Ds.as3s{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	import zero.shaders.Float2;
	import zero.shaders.Pixel4;
	import zero.stage3Ds.BaseEffect;
	import zero.stage3Ds.Xiuzhengs;
	
	public class AS3BaseEffect{
		
		/**
		 * 移动<br/>
		 * 将数据从 source1 移动到 destination，按组件<br/>
		 */
		protected static const mov:String="mov";//0x00
		
		/**
		 * 相加<br/>
		 * destination = source1 + source2，按组件<br/>
		 */
		protected static const add:String="add";//0x01
		
		/**
		 * 相减<br/>
		 * destination = source1 - source2，按组件<br/>
		 */
		protected static const sub:String="sub";//0x02
		
		/**
		 * 相乘<br/>
		 * destination = source1 * source2，按组件<br/>
		 */
		protected static const mul:String="mul";//0x03
		
		/**
		 * 除以<br/>
		 * destination = source1 / source2，按组件<br/>
		 */
		protected static const div:String="div";//0x04
		
		/**
		 * 倒数<br/>
		 * destination = 1/source1，按组件<br/>
		 */
		protected static const rcp:String="rcp";//0x05
		
		/**
		 * 最小值<br/>
		 * destination = minimum(source1,source2)，按组件<br/>
		 */
		protected static const min:String="min";//0x06
		
		/**
		 * 最大值<br/>
		 * destination = maximum(source1,source2)，按组件<br/>
		 */
		protected static const max:String="max";//0x07
		
		/**
		 * 分数<br/>
		 * destination = source1 - (float)floor(source1)，按组件<br/>
		 */
		protected static const frc:String="frc";//0x08
		
		/**
		 * 平方根<br/>
		 * destination = sqrt(source1)，按组件<br/>
		 */
		protected static const sqt:String="sqt";//0x09
		
		/**
		 * 平方根倒数<br/>
		 * destination = 1/sqrt(source1)，按组件<br/>
		 */
		protected static const rsq:String="rsq";//0x0a
		
		/**
		 * 幂<br/>
		 * destination = pow(source1,source2)，按组件<br/>
		 */
		protected static const pow:String="pow";//0x0b
		
		/**
		 * 对数<br/>
		 * destination = log_2(source1)，按组件<br/>
		 */
		protected static const log:String="log";//0x0c
		
		/**
		 * 指数<br/>
		 * destination = 2^source1，按组件<br/>
		 */
		protected static const exp:String="exp";//0x0d
		
		/**
		 * 标准化<br/>
		 * destination = normalize(source1)，按组件（仅生成一个 3 组件结果，目标必须掩码为 .xyz 或更小）<br/>
		 */
		protected static const nrm:String="nrm";//0x0e
		
		/**
		 * 正弦<br/>
		 * destination = sin(source1)，按组件<br/>
		 */
		protected static const sin:String="sin";//0x0f
		
		/**
		 * 余弦<br/>
		 * destination = cos(source1)，按组件<br/>
		 */
		protected static const cos:String="cos";//0x10
		
		/**
		 * 叉积<br/>
		 * destination.x = source1.y * source2.z - source1.z * source2.y<br/>
		 * destination.y = source1.z * source2.x - source1.x * source2.z<br/>
		 * destination.z = source1.x * source2.y - source1.y * source2.x<br/>
		 * （仅生成一个 3 组件结果，目标必须掩码为 .xyz 或更小）<br/>
		 */
		protected static const crs:String="crs";//0x11
		
		/**
		 * 点积<br/>
		 * destination = source1.x*source2.x + source1.y*source2.y + source1.z*source2.z<br/>
		 */
		protected static const dp3:String="dp3";//0x12
		
		/**
		 * 点积<br/>
		 * destination = source1.x*source2.x + source1.y*source2.y + source1.z*source2.z + source1.w*source2.w<br/>
		 */
		protected static const dp4:String="dp4";//0x13
		
		/**
		 * 取绝对值<br/>
		 * destination = abs(source1)，按组件<br/>
		 */
		protected static const abs:String="abs";//0x14
		
		/**
		 * 求反<br/>
		 * destination = -source1，按组件<br/>
		 */
		protected static const neg:String="neg";//0x15
		
		/**
		 * 饱和<br/>
		 * destination = maximum(minimum(source1,1),0)，按组件<br/>
		 */
		protected static const sat:String="sat";//0x16
			
		/**
		 * 矩阵连乘 3x3<br/>
		 * destination.x = (source1.x * source2[0].x) + (source1.y * source2[0].y) + (source1.z * source2[0].z)<br/>
		 * destination.y = (source1.x * source2[1].x) + (source1.y * source2[1].y) + (source1.z * source2[1].z)<br/>
		 * destination.z = (source1.x * source2[2].x) + (source1.y * source2[2].y) + (source1.z * source2[2].z)<br/>
		 * （仅生成一个 3 组件结果，目标必须掩码为 .xyz 或更小）<br/>
		 */
		protected static const m33:String="m33";//0x17
		
		/**
		 * 矩阵连乘 4x4<br/>
		 * destination.x = (source1.x * source2[0].x) + (source1.y * source2[0].y) + (source1.z * source2[0].z) + (source1.w * source2[0].w)<br/>
		 * destination.y = (source1.x * source2[1].x) + (source1.y * source2[1].y) + (source1.z * source2[1].z) + (source1.w * source2[1].w)<br/>
		 * destination.z = (source1.x * source2[2].x) + (source1.y * source2[2].y) + (source1.z * source2[2].z) + (source1.w * source2[2].w)<br/>
		 * destination.w = (source1.x * source2[3].x) + (source1.y * source2[3].y) + (source1.z * source2[3].z) + (source1.w * source2[3].w)<br/>
		 */
		protected static const m44:String="m44";//0x18
		
		/**
		 * 矩阵连乘 3x4<br/>
		 * destination.x = (source1.x * source2[0].x) + (source1.y * source2[0].y) + (source1.z * source2[0].z) + (source1.w * source2[0].w)<br/>
		 * destination.y = (source1.x * source2[1].x) + (source1.y * source2[1].y) + (source1.z * source2[1].z) + (source1.w * source2[1].w)<br/>
		 * destination.z = (source1.x * source2[2].x) + (source1.y * source2[2].y) + (source1.z * source2[2].z) + (source1.w * source2[2].w)<br/>
		 * （仅生成一个 3 组件结果，目标必须掩码为 .xyz 或更小）<br/>
		 */
		protected static const m34:String="m34";//0x19
		
		/**
		 * 丢弃（仅适用于片段着色器）<br/>
		 * 如果单个标量源组件小于零，则将丢弃片段并不会将其绘制到帧缓冲区。（目标寄存器必须全部设置为 0）<br/>
		 */
		protected static const kil:String="kil";//0x27
		
		/**
		 * 纹理取样（仅适用于片段着色器）<br/>
		 * destination 等于从坐标 source1 上的纹理 source2 进行加载。在这种情况下，source2 必须采用取样器格式。<br/>
		 */
		protected static const tex:String="tex";//0x28
		
		/**
		 * 大于等于时设置<br/>
		 * destination = source1 &gt;= source2 ? 1 : 0，按组件<br/>
		 */
		protected static const sge:String="sge";//0x29
		
		/**
		 * 小于时设置<br/>
		 * destination = source1 &lt; source2 ? 1 : 0，按组件<br/>
		 */
		protected static const slt:String="slt";//0x2a
		
		/**
		 * 相等时设置<br/>
		 * destination = source1 == source2 ? 1 : 0，按组件<br/>
		 */
		protected static const seq:String="seq";//0x2c
		
		/**
		 * 不相等时设置<br/>
		 * destination = source1 != source2 ? 1 : 0，按组件<br/>
		 */
		protected static const sne:String="sne";//0x2d
		
		/**
		 * 属性寄存器（Attribute registers）<br/>
		 * <br/>
		 * 这些寄存器参考顶点着色器的VertexBuffer输入。因此，他们只能在顶点着色器中可用。<br/>
		 * 要通过正确的索引分配一个VertexBuffer到一个特定的属性寄存器，使用方法<br/>
		 * Context3D：setVertexBufferAt（）<br/>
		 * 在着色器中，访问属性寄存器的语法：va&lt;n&gt;，其中&lt;n&gt;是属性寄存器的索引号。<br/>
		 * 有一共有8个属性寄存器用于顶点着色器。<br/>
		 * <br/>
		 * These registers reference the Vertex Attribute data of the VertexBuffer that is the input of the Vertex Shader. Therefore, they are only available in Vertex Shaders.<br/>
		 * This is the main data stream that the Vertex Shader is responsible for processing. Each vertex attribute in the VertexBuffer has its own attribute register.<br/>
		 * In order to assign a VertexBuffer attribute to a specific attribute register, use the function Context3D:setVertexBufferAt() , with the proper index.<br/>
		 * Then from the Shader, access the attribute register with the syntax: va&lt;n&gt; , where &lt;n&gt; is the index number of the attribute register.<br/>
		 * There are a total of eight attribute registers available to Vertex Shaders.<br/>
		 */
		protected var va:Vector.<Register>;
		
		/**
		 * 常量寄存器（Constant registers）<br/>
		 * <br/>
		 * 这些寄存器是用来从ActionScript传递参数到着色的。这是通过Context3D::setProgramConstants()系列函数来实现。<br/>
		 * 在着色器中，这些寄存器的访问语法：<br/>
		 * vc&lt;n&gt;，用于顶点着色器<br/>
		 * fc&lt;n&gt;，用于像素着色器<br/>
		 * 其中&lt;n&gt;是常量寄存器的索引值。<br/>
		 * 有128个常量寄存器用于顶点着色器和28常量寄存器用于像素着色器。<br/>
		 * <br/>
		 * These registers serve the purpose of passing parameters from ActionScript to the Shaders. This is performed with the Context3D::setProgramConstants() family of functions.<br/>
		 * These registers are accessed from the Shader with the syntax: vc&lt;n&gt; for Vertex Shaders and fc&lt;n&gt; for Pixel Shaders, where &lt;n&gt; is the index number of the constant register.<br/>
		 * There are 128 constant registers available to Vertex Shaders, and 28 constant registers for Pixel Shaders.<br/>
		 */
		protected var vc:Vector.<Register>;
		/**
		 * 常量寄存器（Constant registers）<br/>
		 * <br/>
		 * 这些寄存器是用来从ActionScript传递参数到着色的。这是通过Context3D::setProgramConstants()系列函数来实现。<br/>
		 * 在着色器中，这些寄存器的访问语法：<br/>
		 * vc&lt;n&gt;，用于顶点着色器<br/>
		 * fc&lt;n&gt;，用于像素着色器<br/>
		 * 其中&lt;n&gt;是常量寄存器的索引值。<br/>
		 * 有128个常量寄存器用于顶点着色器和28常量寄存器用于像素着色器。<br/>
		 * <br/>
		 * These registers serve the purpose of passing parameters from ActionScript to the Shaders. This is performed with the Context3D::setProgramConstants() family of functions.<br/>
		 * These registers are accessed from the Shader with the syntax: vc&lt;n&gt; for Vertex Shaders and fc&lt;n&gt; for Pixel Shaders, where &lt;n&gt; is the index number of the constant register.<br/>
		 * There are 128 constant registers available to Vertex Shaders, and 28 constant registers for Pixel Shaders.<br/>
		 */
		protected var fc:Vector.<Register>;
		
		/**
		 * 临时寄存器（Temporary registers）<br/>
		 * <br/>
		 * 这些寄存器在着色器中，可以用于临时计算。<br/>
		 * 这些寄存器的访问语法：<br/>
		 * vt&lt;n&gt; (vertex)，用于顶点着色器<br/>
		 * ft&lt;n&gt; (pixel)，用于像素着色器<br/>
		 * &lt;n&gt;是寄存器编号。<br/>
		 * 有8个用于顶点着色器，8个用于像素着色器。<br/>
		 * <br/>
		 * These registers are available to Shaders, and they are used for temporary calculations. Since AGAL doesn't use variables, you'll use temporary registers to store data throughout your code.<br/>
		 * Temporary registers are accessed with the syntax vt&lt;n&gt; (Vertex Shaders) and ft&lt;n&gt; (Pixel Shaders) where &lt;n&gt; is the register number.<br/>
		 * There are 8 temporary registers available for Vertex Shaders, and 8 for Pixel Shaders. <br/>
		 */
		protected var vt:Vector.<Register>;
		/**
		 * 临时寄存器（Temporary registers）<br/>
		 * <br/>
		 * 这些寄存器在着色器中，可以用于临时计算。<br/>
		 * 这些寄存器的访问语法：<br/>
		 * vt&lt;n&gt; (vertex)，用于顶点着色器<br/>
		 * ft&lt;n&gt; (pixel)，用于像素着色器<br/>
		 * &lt;n&gt;是寄存器编号。<br/>
		 * 有8个用于顶点着色器，8个用于像素着色器。<br/>
		 * <br/>
		 * These registers are available to Shaders, and they are used for temporary calculations. Since AGAL doesn't use variables, you'll use temporary registers to store data throughout your code.<br/>
		 * Temporary registers are accessed with the syntax vt&lt;n&gt; (Vertex Shaders) and ft&lt;n&gt; (Pixel Shaders) where &lt;n&gt; is the register number.<br/>
		 * There are 8 temporary registers available for Vertex Shaders, and 8 for Pixel Shaders. <br/>
		 */
		protected var ft:Vector.<Register>;
		
		/**
		 * 输出寄存器（Output registers）<br/>
		 * <br/>
		 * 输出寄存器是在顶点和像素着色器存储其计算输出。此输出用于顶点着色器是顶点的剪辑空间位置。用于像素着色器是该像素的颜色。<br/>
		 * 访问这些寄存器运算的语法：<br/>
		 * op，用于顶点着色器<br/>
		 * oc，用于像素着色器<br/>
		 * 但显然只能一个输出寄存器用于顶点和像素着色器。<br/>
		 * <br/>
		 * The output registers are used by Vertex and Pixel Shaders to store the output of their calculations. For Vertex Shaders, this output is the position of the vertex. For Pixel Shaders it is the color of the pixel.<br/>
		 * These registers are accessed with the syntax op for Vertex Shaders, and oc for Pixel Shaders.<br/>
		 * There is obviously only one output register for Vertex and for Pixel Shaders.<br/>
		 */
		protected var op:Register;
		/**
		 * 输出寄存器（Output registers）<br/>
		 * <br/>
		 * 输出寄存器是在顶点和像素着色器存储其计算输出。此输出用于顶点着色器是顶点的剪辑空间位置。用于像素着色器是该像素的颜色。<br/>
		 * 访问这些寄存器运算的语法：<br/>
		 * op，用于顶点着色器<br/>
		 * oc，用于像素着色器<br/>
		 * 但显然只能一个输出寄存器用于顶点和像素着色器。<br/>
		 * <br/>
		 * The output registers are used by Vertex and Pixel Shaders to store the output of their calculations. For Vertex Shaders, this output is the position of the vertex. For Pixel Shaders it is the color of the pixel.<br/>
		 * These registers are accessed with the syntax op for Vertex Shaders, and oc for Pixel Shaders.<br/>
		 * There is obviously only one output register for Vertex and for Pixel Shaders.<br/>
		 */
		protected var oc:Register;
		
		/**
		 * 变寄存器（Varying Registers）<br/>
		 * 这些寄存器用来从顶点着色器传递数据到像素着色器。传递数据被正确地插入图形芯片，从而使像素着色器接收到正确的正在处理的像素的值。<br/>
		 * 以这种方式获取传递的典型数据是顶点颜色，或 纹理UV 坐标。<br/>
		 * 这些寄存器可以被访问的语法v &lt;n&gt;，其中&lt;n&gt;是寄存器编号。<br/>
		 * 有8个变寄存器可用。<br/>
		 * <br/>
		 * These registers are used to pass data from Vertex Shaders to Pixel Shaders. The data that is passed is properly interpolated by the GPU, so that the Pixel Shader receives the correct value for the pixel that is being processed.<br/>
		 * Typical data that gets passed in this way is the vertex color or the UV coordinates for texturing.<br/>
		 * These registers can be accessed with the syntax v&lt;n&gt; , where &lt;n&gt; is the register number.<br/>
		 * There are 8 varying registers available.<br/>
		 */		
		protected var v:Vector.<Register>;
		
		/**
		 * 纹理取样器（Texture sampler registers）<br/>
		 * 纹理采样寄存器是用来基于UV坐标从纹理中获取颜色值。<br/>
		 * 纹理是通过ActionScriptcall指定方法Context3D::setTextureAt()。<br/>
		 * 纹理样本的使用语法是：fs&lt;n&gt; &lt;flags&gt;，其中&lt;n&gt;是取样指数，&lt;flags&gt;是由一个或多个标记，用于指定如何进行采样。<br/>
		 * &lt;flags&gt;是以逗号分隔的一组字符串，它定义：<br/>
		 * 	纹理尺寸。可以是：二维，三维（和英文原文有出入），多维数据集<br/>
		 * 	纹理映射。可以是：nomip，mipnone，mipnearest，miplinear<br/>
		 * 	纹理过滤。可以是：最近点采样，线性<br/>
		 * 	纹理重复。可以是：重复，包装，夹取<br/>
		 * 因此，举例来说，一个标准的2D纹理没有纹理映射，并进行线性过滤，可以进行采样到临时寄存器FT1，使用以下命令：<br/>
		 * 	“tex ft1, v0, fs0 &lt;2d,linear,nomip&gt; ”<br/>
		 * 变寄存器v0持有插值的纹理 UVs。<br/>
		 * <br/>
		 * Texture Sampler registers are used to pick color values from textures, based on UV coordinates.<br/>
		 * The texture to be used is specified through ActionScript with the call Context3D::setTextureAt().<br/>
		 * The syntax for using texture samplers is: fs&lt;n&gt; &lt;flags&gt; , where &lt;n&gt; is the sampler index, and &lt;flags&gt; is a set of one or more flags that specifies how the sampling should be made.<br/>
		 * &lt;flags&gt; is a comma separated set of strings, that defines:<br/>
		 * 	texture dimension. Options: 2d, cube<br/>
		 * 	mip mapping. Options: nomip (or mipnone , they are the same) , mipnearest, miplinear<br/>
		 * 	texture filtering. Options: nearest, linear<br/>
		 * 	texture repeat. Options: repeat, wrap, clamp<br/>
		 * For example, a standard 2D texture without MIP mapping and linear filtering could be sampled into temporary register ft1 , with the following line:<br/>
		 * 	tex ft1, v0, fs0 &lt;2d,linear,nomip&gt;<br/>
		 * In the example above, the varying register v0 holds the interpolated texture UVs.<br/>
		 * <br/>
		 * setTextureAt()	方法	 <br/>
		 * public function setTextureAt(sampler:int, texture:flash.display3D.textures:TextureBase):void<br/>
		 *  语言版本: 	ActionScript 3.0<br/>
		 * 运行时版本: 	Flash Player 11, AIR 3<br/>
		 * 指定要为片段程序的纹理输入寄存器使用的纹理。<br/>
		 * 一个片段程序最多可以从 8 个纹理对象读取信息。使用此函数将 Texture 或 CubeTexture 对象分配给片段程序使用的取样器寄存器之一。<br/>
		 * 注意：如果将活动的片段程序（使用 setProgram）更改为使用较少纹理的着色器，请将未使用的寄存器设置为 null：<br/>
		 * setTextureAt( 7, null );<br/>
		 * 参数<br/>
		 * sampler:int — 取样器寄存器索引，介于 0 到 7 之间的值。<br/>
		 * texture:flash.display3D.textures:TextureBase — 要启用的纹理对象，Texture 或 CubeTexture 实例。 <br/>
		 */		
		protected var fs:Vector.<Sampler>;
		
		public var effect:BaseEffect;
		
		protected var u_d:Number;
		protected var v_d:Number;
		protected var u_wid:Number;
		protected var v_hei:Number;
		
		public var alpha:Number=1;
		public var center:Float2=null;
		protected var u_center:Number;
		protected var v_center:Number;
		
		public function AS3BaseEffect(){
		}
		protected function initNullParams():void{//对可能为null的某些值赋一个初始值
			var i:int=-1;
			for each(var type:Class in effect["constructor"].typeV){
				i++;
				var name:String=effect["constructor"].nameV[i];
				switch(type){
					case Float2:
						if(this[name]){
						}else{
							//对任何未赋值的 Float2 ，设置默认值为图片中心
							this[name]=new Float2(effect.bmd.width*0.5,effect.bmd.height*0.5);
						}
					break;
					case Pixel4:
						if(this[name]){
						}else{
							//对任何未赋值的 Pixel4 ，设置默认值为不透明黑色
							this[name]=new Pixel4(0,0,0,1);
						}
					break;
				}
			}
		}
		
		private var intervalId:int;
		private var outputBmd:BitmapData;
		private var stepId:int;
		public function stopRenderBmp():void{
			clearInterval(intervalId);
		}
		public function renderBmp(bmp:Bitmap,bmd:BitmapData,paramArr:Array):void{
			
			stopRenderBmp();
			
			effect.bmd=bmd;
			
			/*
			trace("输出uploadBmd到舞台查看");
			trace("bmp.stage.numChildren="+bmp.stage.numChildren);
			if(bmp.stage.numChildren>1){
				var uploadBmp:Bitmap=bmp.stage.getChildAt(1) as Bitmap;
				uploadBmp.bitmapData=effect.uploadBmd;
			}else{
				bmp.stage.addChild(uploadBmp=new Bitmap(effect.uploadBmd));
				uploadBmp.x=123;
				uploadBmp.y=123;
			}
			//*/
			
			//va=getRegisterV(8,"va",true,false);
			
			//vc=getRegisterV(128,"vc",true,false);
			//fc=getRegisterV(28,"fc",true,false);
			fc=new Vector.<Register>(28);
			fc.fixed=true;
			
			//vt=getRegisterV(8,"vt",true,true);
			ft=getRegisterV(8,"ft",true,true);
			
			//op=new Register("op",false,true);
			oc=new Register("oc",-1,false,true);
			
			//v=getRegisterV(8,"v",true,false);
			v=new Vector.<Register>();
			//uv，只使用 xy
			v[0]=new Register("v",0,true,false);
			v[0].readableMark["z"]=false;
			v[0].readableMark["w"]=false;
			v.fixed=true;
			
			fs=new Vector.<Sampler>(8);
			fs.fixed=true;
			fs[0]=new Sampler(bmd);
			
			for each(var subArr:Array in paramArr){
				this[subArr[0]]=subArr[1];
			}
			
			initNullParams();
			
			updateParams();
			
			bmp.bitmapData=outputBmd=bmd.clone();
			outputBmd.fillRect(outputBmd.rect,0x00000000);
			
			stepId=-1;
			
			intervalId=setInterval(renderStep,30);
			renderStep();
		}
		private function renderStep():void{
			var t:int=getTimer();
			while(getTimer()-t<30){
				stepId++;
				var y:int=int(stepId/fs[0].bmd.width);
				if(y<fs[0].bmd.height){
					var x:int=stepId%fs[0].bmd.width;
					
					fcMark=new Object();
					fcId=-1;
					
					v[0].__x=(Xiuzhengs.d+x+0.5)/effect.uploadBmd.width;
					v[0].__y=(Xiuzhengs.d+y+0.5)/effect.uploadBmd.height;
					oc.__x=NaN;
					oc.__y=NaN;
					oc.__z=NaN;
					oc.__w=NaN;
					evaluatePixel();
					var a:Number=oc.__w;
					var r:Number=oc.__x;
					var g:Number=oc.__y;
					var b:Number=oc.__z;
					if(isNaN(a)||isNaN(r)||isNaN(g)||isNaN(b)){
						throw new Error("a="+a+"，r="+r+"，g="+g+"，b="+b);
					}else{
						outputBmd.setPixel32(x,y,(int(a*0xff)<<24)|(int(r*0xff)<<16)|(int(g*0xff)<<8)|int(b*0xff));
					}
				}else{
					stopRenderBmp();
					break;
				}
			}
			//trace("y="+y);
			//trace("耗时："+(getTimer()-t)+" 毫秒");
		}
		
		private function getRegisterV(len:int,name:String,readable:Boolean,writeable:Boolean):Vector.<Register>{
			var v:Vector.<Register>=new Vector.<Register>(len);
			v.fixed=true;
			for(var i:int=0;i<len;i++){
				v[i]=new Register(name,i,readable,writeable);
			}
			return v;
		}
		
		protected function updateParams():void{
			u_d=Xiuzhengs.d/effect.uploadBmd.width;
			v_d=Xiuzhengs.d/effect.uploadBmd.height;
			u_wid=(effect.bmd.width+Xiuzhengs.uvxiuzheng)/effect.uploadBmd.width;
			v_hei=(effect.bmd.height+Xiuzhengs.uvxiuzheng)/effect.uploadBmd.height;
			if(center){
				u_center=(Xiuzhengs.d+center.x)/effect.uploadBmd.width;
				v_center=(Xiuzhengs.d+center.y)/effect.uploadBmd.height;
			}
		}
		protected function evaluatePixel():void{}
		
		protected function constant(...constValues):void{
			for each(var constValue:String in constValues){
				if(constValue==null){
				}else{
					if(fcMark[constValue]>-1){
						throw new Error("重复的 constValue："+constValue);
					}
				}
				fcMark[constValue]=++fcId;
				if(fcId%4==0){
					var i:int=int(fcId/4);
					fc[i]=new Register("fc",i,true,false);
				}
			}
		}
		
		private var fcMark:Object;
		private var fcId:int;
		private function getRegisterAndAccessor(arr:Array):Array{
			//常量 Array
			var accessor:String="";
			var I:int=-1;
			for each(var constValue:* in arr){
				if(fcMark[constValue]>-1){
					var _fcId:int=fcMark[constValue];
					var i:int=int(_fcId/4);
					var j:int=_fcId%4;
				}else{
					fcMark[constValue]=_fcId=++fcId;
					i=int(_fcId/4);
					j=_fcId%4;
					if(j==0){
						fc[i]=new Register("fc",i,true,false);
					}
				}
				if(I>-1){
					if(I==i){
					}else{
						throw new Error("请组织好 constValue 们为4个一组");
					}
				}else{
					I=i;
				}
				switch(j){
					case 0:
						var c:String="x";
					break;
					case 1:
						c="y";
					break;
					case 2:
						c="z";
					break;
					case 3:
						c="w";
					break;
				}
				accessor+=c;
				//trace("i="+i,"c="+c,constValue);
				if(constValue is String){
					fc[i]["__"+c]=this[constValue];
				}else{
					fc[i]["__"+c]=constValue;
				}
			}
			return [fc[i],accessor];
		}
		private function checkAccessorLen(accessor1:String,accessor2:String):void{
			if(accessor1.length==accessor2.length){
			}else{
				throw new Error(accessor1+"，"+accessor2+"，accessor1.length!=accessor2.length");
			}
		}
		//[opcode][destination][source1][source2 or sampler]
		protected function line(
			opcode:String,
			destination:*,
			source1:*,
			source2_or_sampler:*=null,
			flags:String=null
		):void{
			
			//if(oc){oc.__x=1;oc.__y=alpha;oc.__z=0;oc.__w=0;return;}//耗时：70毫秒
			
			switch(destination["constructor"]){
				case Register:
					var register0:Register=destination;
					var accessor0:String="xyzw";
				break;
				case Object:
					register0=destination.register;
					accessor0=destination.accessor;
				break;
				case Array:
					//常量 Array
					destination=getRegisterAndAccessor(destination);
					register0=destination[0];
					accessor0=destination[1];
				break;
				default:
					throw new Error("不支持的 destination："+destination);
				break;
			}
			
			//if(oc){oc.__x=1;oc.__y=alpha;oc.__z=0;oc.__w=0;return;}//耗时：120毫秒
			
			switch(source1["constructor"]){
				case Register:
					var register1:Register=source1;
					var accessor1:String="xyzw";
				break;
				case Object:
					register1=source1.register;
					accessor1=source1.accessor;
				break;
				case Array:
					//常量 Array
					source1=getRegisterAndAccessor(source1);
					register1=source1[0];
					accessor1=source1[1];
				break;
				default:
					throw new Error("不支持的 source1："+source1);
				break;
			}
			
			//if(oc){oc.__x=1;oc.__y=alpha;oc.__z=0;oc.__w=0;return;}//耗时：347毫秒
			
			switch(source2_or_sampler){
				case null:
				case undefined:
					//
				break;
				default:
					if(source2_or_sampler is Sampler){
						var sampler:Sampler=source2_or_sampler;
						if(flags){
						}else{
							throw new Error("sampler 需要 flags，flags："+flags);
						}
					}else{
						switch(source2_or_sampler["constructor"]){
							case Register:
								var register2:Register=source2_or_sampler;
								var accessor2:String="xyzw";
							break;
							case Object:
								register2=source2_or_sampler.register;
								accessor2=source2_or_sampler.accessor;
							break;
							case Array:
								//常量 Array
								source2_or_sampler=getRegisterAndAccessor(source2_or_sampler);
								register2=source2_or_sampler[0];
								accessor2=source2_or_sampler[1];
							break;
							default:
								throw new Error("不支持的 source2："+source2_or_sampler);
							break;
						}
					}
				break;
			}
			
			//if(oc){oc.__x=1;oc.__y=alpha;oc.__z=0;oc.__w=0;return;}//耗时：352毫秒
			
			var value1:Array;
			var value2:Array;
			var value:Array;
			var i:int;
			
			switch(opcode){
				case mov:
					checkAccessorLen(accessor0,accessor1);
					if(register2){
						throw new Error(mov+" 不支持 register2");
					}
					value1=register1.getValue(accessor1);
					register0.setValue(accessor0,value1);
				break;
				case add:
					checkAccessorLen(accessor0,accessor1);
					checkAccessorLen(accessor0,accessor2);
					value1=register1.getValue(accessor1);
					value2=register2.getValue(accessor2);
					i=value1.length;
					value=new Array();
					while(--i>=0){
						value[i]=value1[i]+value2[i];
					}
					register0.setValue(accessor0,value);
				break;
				case sub:
					checkAccessorLen(accessor0,accessor1);
					checkAccessorLen(accessor0,accessor2);
					value1=register1.getValue(accessor1);
					value2=register2.getValue(accessor2);
					i=value1.length;
					value=new Array();
					while(--i>=0){
						value[i]=value1[i]-value2[i];
					}
					register0.setValue(accessor0,value);
				break;
				case mul:
					checkAccessorLen(accessor0,accessor1);
					checkAccessorLen(accessor0,accessor2);
					value1=register1.getValue(accessor1);
					value2=register2.getValue(accessor2);
					i=value1.length;
					value=new Array();
					while(--i>=0){
						value[i]=value1[i]*value2[i];
					}
					register0.setValue(accessor0,value);
				break;
				case div:
					checkAccessorLen(accessor0,accessor1);
					checkAccessorLen(accessor0,accessor2);
					value1=register1.getValue(accessor1);
					value2=register2.getValue(accessor2);
					i=value1.length;
					value=new Array();
					while(--i>=0){
						value[i]=value1[i]/value2[i];
					}
					register0.setValue(accessor0,value);
				break;
				case rcp:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case min:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case max:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case frc:
					checkAccessorLen(accessor0,accessor1);
					if(register2){
						throw new Error(frc+" 不支持 register2");
					}
					value1=register1.getValue(accessor1);
					i=value1.length;
					value=new Array();
					while(--i>=0){
						value[i]=value1[i]-Math.floor(value1[i]);
					}
					register0.setValue(accessor0,value);
				break;
				case sqt:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case rsq:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case pow:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case log:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case exp:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case nrm:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case sin:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case cos:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case crs:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case dp3:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case dp4:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case abs:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case neg:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case sat:
					checkAccessorLen(accessor0,accessor1);
					if(register2){
						throw new Error(mov+" 不支持 register2");
					}
					value1=register1.getValue(accessor1);
					i=value1.length;
					value=new Array();
					while(--i>=0){
						if(value1[i]<0){
							value[i]=0;
						}else if(value1[i]>1){
							value[i]=1;
						}else{
							value[i]=value1[i];
						}
					}
					register0.setValue(accessor0,value);
				break;
				case m33:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case m44:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case m34:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case kil:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case tex:
					if(sampler){
						if(accessor0=="xyzw"){
						}else{
							throw new Error('accessor0!="xyzw"，accessor0：'+accessor0);
						}
					}else{
						throw new Error(tex+" 需要 sampler，sampler："+sampler);
					}
					//var color:uint=sampler.bmd.getPixel32(
					var color:uint=effect.uploadBmd.getPixel32(
						Math.floor(register1.getValue("x")[0]*effect.uploadBmd.width),
						Math.floor(register1.getValue("y")[0]*effect.uploadBmd.height)
					);
					register0.setValue("xyzw",[
						((color>>16)&0xff)/0xff,
						((color>>8)&0xff)/0xff,
						(color&0xff)/0xff,
						((color>>24)&0xff)/0xff
					]);
				break;
				case sge:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case slt:
					throw new Error("暂不支持的 opcode："+opcode);
				break;
				case seq:
					checkAccessorLen(accessor0,accessor1);
					checkAccessorLen(accessor0,accessor2);
					value1=register1.getValue(accessor1);
					value2=register2.getValue(accessor2);
					i=value1.length;
					value=new Array();
					while(--i>=0){
						value[i]=value1[i]==value2[i]?1:0;
					}
					register0.setValue(accessor0,value);
				break;
				case sne:
					checkAccessorLen(accessor0,accessor1);
					checkAccessorLen(accessor0,accessor2);
					value1=register1.getValue(accessor1);
					value2=register2.getValue(accessor2);
					i=value1.length;
					value=new Array();
					while(--i>=0){
						value[i]=value1[i]==value2[i]?0:1;
					}
					register0.setValue(accessor0,value);
				break;
				default:
					throw new Error("未知 opcode："+opcode);
				break;
			}
		}
	}
}
import flash.display.BitmapData;

class Register{
	
	public var name:String;
	public var id:int;
	
	public var __x:Number;
	public var __y:Number;
	public var __z:Number;
	public var __w:Number;
	
	public var readableMark:Object;
	public var writeableMark:Object;
	
	public var x:Object={register:this,accessor:"x"};
	public var y:Object={register:this,accessor:"y"};
	
	public var xx:Object={register:this,accessor:"xx"};
	public var xy:Object={register:this,accessor:"xy"};
	public var yy:Object={register:this,accessor:"yy"};
	public var zw:Object={register:this,accessor:"zw"};
	
	public var xyz:Object={register:this,accessor:"xyz"};
	
	public var xxxx:Object={register:this,accessor:"xxxx"};
	
	public function Register(_name:String,_id:int,readable:Boolean,writeable:Boolean){
		name=_name;
		id=_id;
		readableMark={x:readable,y:readable,z:readable,w:readable}
		writeableMark={x:writeable,y:writeable,z:writeable,w:writeable}
	}
	
	public function getValue(accessor:String):Array{
		//accessor=accessor.replace(/r/g,"x").replace(/g/g,"y").replace(/b/g,"z").replace(/a/g,"w");
		var value:Array=new Array();
		var i:int=-1;
		for each(var c:String in accessor.split("")){
			i++;
			if(readableMark[c]){
				if(isNaN(this["__"+c])){
					throw new Error("正在读取未初始化的值："+c+"="+this["__"+c]);
				}else{
					value[i]=this["__"+c];
				}
			}else{
				throw new Error(c+"不可读");
			}
		}
		//trace("getValue accessor="+accessor+"，value="+value);
		return value;
	}
	public function setValue(accessor:String,value:Array):void{
		//accessor=accessor.replace(/r/g,"x").replace(/g/g,"y").replace(/b/g,"z").replace(/a/g,"w");
		//trace("setValue accessor="+accessor+"，value="+value);
		var i:int=-1;
		for each(var c:String in accessor.split("")){
			i++;
			if(writeableMark[c]){
				this["__"+c]=value[i];
				if(isNaN(this["__"+c])){
					throw new Error("正在写入不合法的值："+value[i]);
				}
			}else{
				throw new Error(c+"不可写");
			}
		}
	}
}
class Sampler{
	public var bmd:BitmapData;
	public function Sampler(_bmd:BitmapData){
		bmd=_bmd;
	}
}