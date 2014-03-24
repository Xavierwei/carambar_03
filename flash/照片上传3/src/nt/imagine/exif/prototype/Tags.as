/*@
***summary***
Copyright (c) 2007 Frank@2solo.cn
URL:www.2solo.cn
Create date:2008.03.18
Last modified by:frank
Last modified at:2008.03.28
File version:v1.02
Framework ID:Novattack Ver3.0.1
Path:nt.imagine.exif.prototype
Info:All tags
Location:shanghai,china

使用本代码库请参照GNU GENERAL PUBLIC LICENSE(通用公共授权).
允许每个人复制和发布本授权文件的完整副本，但不允许对它进行任何修改。
如果您有好的建议，欢迎来http://code.google.com/p/exif-as3/留言.

Please use this library with the GNU GENERAL PUBLIC LICENSE(GNU GPL)
Everyone is permitted to copy and distribute verbatim copies of this license document, but changing it is not allowed.
If you have any suggestion,You're welcome to leave a message at http://code.google.com/p/exif-as3/

GNU General Public License
http://www.gnu.org/licenses/gpl.html

Exif2-2
http://www.exif.org/Exif2-2.PDF
*/
package nt.imagine.exif.prototype{
	public class Tags {
		public static  const EXIF_TAGS:Object={
		0:{EN:"GPSVersionID",CN:"GPS版本ID"},
		1:{EN:"GPSLatitudeRef",CN:"GPS南北纬度"},
		2:{EN:"GPSLatitude",CN:"GPS纬度数"},
		3:{EN:"GPSLongitudeRef",CN:"GPS东西经度"},
		4:{EN:"GPSLongitude",CN:"GPS经度数"},
		5:{EN:"GPSAltitudeRef",CN:"GPS海拔引用"},
		6:{EN:"GPSAltitude",CN:"GPS海拔"},
		7:{EN:"GPSTimeStamp",CN:"GPS时间戳"},
		8:{EN:"GPSSatellites",CN:"GPS卫星"},
		9:{EN:"GPSStatus",CN:"GPS接收状态"},
		10:{EN:"GPSMeasureMode",CN:"GPS尺度模式"},
		11:{EN:"GPSDOP",CN:"GPS测量精度"},
		12:{EN:"GPSSpeedRef",CN:"GPS速度单位"},
		13:{EN:"GPSSpeed",CN:"GPS速度"},
		14:{EN:"GPSTrackRef",CN:"GPS方向单位"},
		15:{EN:"GPSTrack",CN:"GPS方向"},
		16:{EN:"GPSImgDirectionRef",CN:"GPS图片方向单位"},
		17:{EN:"GPSImgDirection",CN:"GPS图片方向"},
		18:{EN:"GPSMapDatum",CN:"GPS地图数据"},
		19:{EN:"GPSDestLatitudeRef",CN:"GPS目的地南北纬度"},
		20:{EN:"GPSDestLatitude",CN:"GPS目的地纬度数"},
		21:{EN:"GPSDestLongitudeRef",CN:"GPS目的地东西经度"},
		22:{EN:"GPSDestLongitude",CN:"GPS目的地经度数"},
		23:{EN:"GPSDestBearingRef",CN:"GPS目的地相对位置单位"},
		24:{EN:"GPSDestBearing",CN:"GPS目的地相对位置方向"},
		25:{EN:"GPSDestDistanceRef",CN:"GPS目的地相对距离单位"},
		26:{EN:"GPSDestDistance",CN:"GPS目的地相对距离"},
		27:{EN:"GPSProcessingMethod",CN:"GPS技术名称"},
		28:{EN:"GPSAreaInformation",CN:"GPS地点信息"},
		29:{EN:"GPSDateStamp",CN:"GPS日期戳"},
		30:{EN:"GPSDifferential",CN:"GPS修正"},
		256:{EN:"ImageWidth",CN:"图片宽度"},
		257:{EN:"ImageLength",CN:"图片高度"},
		258:{EN:"BitsPerSample",CN:"构成比特数"},
		259:{EN:"Compression",CN:"压缩方案"},
		262:{EN:"PhotometricInterpretation",CN:"象素合成"},
		266:{EN:"FillOrder",CN:"填充顺序"},
		269:{EN:"DocumentName",CN:"文档名"},
		270:{EN:"ImageDescription",CN:"图片信息"},
		271:{EN:"Make",CN:"设备制造商"},
		272:{EN:"Model",CN:"使用设备"},
		273:{EN:"StripOffsets",CN:"图片数据位置"},
		274:{EN:"Orientation",CN:"图片方向"},
		277:{EN:"SamplesPerPixel",CN:"构成数"},
		278:{EN:"RowsPerStrip",CN:"行数/扫描行"},
		279:{EN:"StripByteCounts",CN:"字节数/扫描行"},
		282:{EN:"XResolution",CN:"X分辨率"},
		283:{EN:"YResolution",CN:"Y分辨率"},
		284:{EN:"PlanarConfiguration",CN:"图片数据组成"},
		296:{EN:"ResolutionUnit",CN:"分辨率单位"},
		301:{EN:"TransferFunction",CN:"传输方法"},
		305:{EN:"Software",CN:"软件"},
		306:{EN:"DateTime",CN:"修改日期"},
		315:{EN:"Artist",CN:"创建者"},
		318:{EN:"WhitePoint",CN:"白点染色性"},
		319:{EN:"PrimaryChromacities",CN:"主染色性"},
		342:{EN:"TransferRange",CN:"转移范围"},
		512:{EN:"JPEGProc",CN:"JPEG压缩进程"},
		513:{EN:"JPEGInterchangeFormat",CN:"SOI位置"},
		514:{EN:"JPEGInterchangeFormatLength",CN:"字节数"},
		529:{EN:"YCbCrCoefficients",CN:"颜色空间转移矩阵"},
		530:{EN:"YCbCrSubSampling",CN:"取样比率"},
		531:{EN:"YCbCrPositioning",CN:"颜色空间布置"},
		532:{EN:"ReferenceBlackWhite",CN:"黑白比对"},
		33421:{EN:"CFARepeatPatternDim",CN:"CFA模式定义"},
		33422:{EN:"CFAPattern",CN:"CFA模式"},
		33423:{EN:"BatteryLevel",CN:"电池级别"},
		33432:{EN:"Copyright",CN:"版权"},
		33434:{EN:"ExposureTime",CN:"暴光时间"},
		33437:{EN:"FNumber",CN:"F指数(光圈)"},
		33723:{EN:"IPTC/NAA",CN:"IPTC/NAA指数"},
		34665:{EN:"Exif IFD Pointer",CN:"Exif数据集"},
		34675:{EN:"InterColorProfile",CN:"颜色剖面"},
		34850:{EN:"ExposureProgram",CN:"暴光程序"},
		34852:{EN:"SpectralSensitivity",CN:"光谱灵敏性"},
		34853:{EN:"GPSInfo",CN:"GPS数据集"},
		34855:{EN:"ISOSpeedRatings",CN:"ISO值"},
		34856:{EN:"OECF",CN:"OECF"},
		36864:{EN:"ExifVersion",CN:"Exif版本信息"},
		36867:{EN:"DateTimeOriginal",CN:"原始创建日期"},
		36868:{EN:"DateTimeDigitized",CN:"转为数码数据时间"},
		37121:{EN:"ComponentsConfiguration",CN:"构成配置"},
		37122:{EN:"CompressedBitsPerPixel",CN:"压缩比特/象素"},
		37377:{EN:"ShutterSpeedValue",CN:"快门速度"},
		37378:{EN:"ApertureValue",CN:"光圈"},
		37379:{EN:"BrightnessValue",CN:"]亮度"},
		37380:{EN:"ExposureBiasValue",CN:"暴光曲线"},
		37381:{EN:"MaxApertureValue",CN:"最大光圈"},
		37382:{EN:"SubjectDistance",CN:"目标距离"},
		37383:{EN:"MeteringMode",CN:"测量模式"},
		37384:{EN:"LightSource",CN:"光源"},
		37385:{EN:"Flash",CN:"闪光灯"},
		37386:{EN:"FocalLength",CN:"焦距"},
		37500:{EN:"MakerNote",CN:"设备商附加信息"},
		37510:{EN:"UserComment",CN:"用户评论"},
		37520:{EN:"SubSecTime",CN:"日期(微秒)"},
		37521:{EN:"SubSecTimeOriginal",CN:"创建日期(微秒)"},
		37522:{EN:"SubSecTimeDigitized",CN:"数码化日期(微秒)"},
		40960:{EN:"FlashPixVersion",CN:"Flashpix版本"},
		40961:{EN:"ColorSpace",CN:"颜色空间"},
		40962:{EN:"PixelXDimension",CN:"有效图片宽"},
		40963:{EN:"PixelYDimension",CN:"有效图片高"},
		40963:{EN:"RelatedSoundFile",CN:"相关声音文件"},
		40965:{EN:"InteroperabilityOffset",CN:"互用性标签位置"},
		41483:{EN:"FlashEnergy",CN:"闪光灯电量"},
		41484:{EN:"SpatialFrequencyResponse",CN:"空间响应频率"},
		41486:{EN:"FocalPlaneXResolution",CN:"焦点平面X分辨率"},
		41487:{EN:"FocalPlaneYResolution",CN:"焦点平面分辨率"},
		41488:{EN:"FocalPlaneResolutionUnit",CN:"分辨率单位"},
		41492:{EN:"SubjectLocation",CN:"主题位置"},
		41493:{EN:"ExposureIndex",CN:"暴光顺序"},
		41495:{EN:"SensingMethod",CN:"感应技术"},
		41728:{EN:"FileSource",CN:"文件源"},
		41729:{EN:"SceneType",CN:"场景"},
		41730:{EN:"CFAPattern",CN:"CFA模式"},
		41985:{EN:"CustomRendered",CN:"图片进程"},
		41986:{EN:"ExposureMode",CN:"暴光模式"},
		41987:{EN:"WhiteBalance",CN:"白平衡"},
		41988:{EN:"DigitalZoomRatio",CN:"数码缩放比"},
		41989:{EN:"FocalLengthIn35mmFilm",CN:"等价于35mm焦段的焦长"},
		41990:{EN:"SceneCaptureType",CN:"场景捕捉类型"},
		41991:{EN:"GainControl",CN:"获取控制"},
		41992:{EN:"Contrast",CN:"对比度"},
		41993:{EN:"Saturation",CN:"饱和度"},
		41994:{EN:"Sharpness",CN:"锐度"},
		41995:{EN:"DeviceSettingDescription",CN:"设备设定"},
		41996:{EN:"SubjectDistanceRange",CN:"目标距离范围"},
		42016:{EN:"ImageUniqueID",CN:"图片标示符"},
		50341:{EN:"PrintIM",CN:"印刷数据位置"}
		};
	}
}