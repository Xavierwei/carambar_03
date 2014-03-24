/**
 * 
 * QQ微博:http://t.qq.com/maoyexing
 * e-mail:maoyexing@gmail.com
 * 
 * */
package com.util
{
	import com.hurlant.crypto.Crypto;
	import com.hurlant.crypto.hash.HMAC;
	import com.hurlant.util.Base64;
	import com.hurlant.util.Hex;
	import com.util.http.HttpParameter;
	
	import flash.utils.ByteArray;

	/**
	 * Microblogs api - Oauth
	 * ---
	 * 微博《oauth授权URL工具类》。by 毛业兴 
	 * 
	 * @since 2011-4-10
	 * @author 毛业兴
	 * 
	 */
	public class OauthUrlUtil
	{
		private static const OAuthVersionKey:String = "oauth_version";
		private static const OAuthVersion:String = "1.0";
		
		private static const OAuthQParameterPrefix:String = "oauth_";
		private static const OAuthConsumerKeyKey:String = "oauth_consumer_key";
		private static const OAuthCallbackKey:String = "oauth_callback";
		private static const OAuthSignatureMethodKey:String = "oauth_signature_method";
		private static const OAuthSignatureKey:String = "oauth_signature";
		private static const OAuthTimestampKey:String = "oauth_timestamp";
		private static const OAuthNonceKey:String = "oauth_nonce";
		private static const OAuthTokenKey:String = "oauth_token";
		private static const oAauthVerifier:String = "oauth_verifier";
		private static const OAuthTokenSecretKey:String = "oauth_token_secret";
		private static const HMACSHA1SignatureType:String = "sha1";
		private static const HMACSHA1SignatureType_TEXT:String = "HMAC-SHA1";
		
		public function OauthUrlUtil()
		{
		}
		
		//生产URL
		public static function getOauthUrl(url:String, httpMethod:String, customKey:String,
									 customSecrect:String, tokenKey:String, tokenSecrect:String,
									 verify:String, callbackUrl:String, parameters:Array):String 
		{
			//trace("getOauthUrl:", httpMethod, customKey, customSecrect, tokenKey, tokenSecrect, verify, callbackUrl);
			var nonce:String = generateNonce();
			var timeStamp:String = generateTimeStamp();
			
			parameters.push(new HttpParameter(OAuthVersionKey, OAuthVersion));
			parameters.push(new HttpParameter(OAuthNonceKey, nonce));
			parameters.push(new HttpParameter(OAuthTimestampKey, timeStamp));
			parameters.push(new HttpParameter(OAuthSignatureMethodKey, HMACSHA1SignatureType_TEXT));
			parameters.push(new HttpParameter(OAuthConsumerKeyKey, customKey));
			
			if (tokenKey != null && tokenKey != "") {
				parameters.push(new HttpParameter(OAuthTokenKey, tokenKey));
			}
			
			if (verify != null && verify != "") {
				parameters.push(new HttpParameter(oAauthVerifier, verify));
			}
			
			if (callbackUrl != null && callbackUrl != "") {
				parameters.push(new HttpParameter(OAuthCallbackKey, callbackUrl));
			}
			parameters.sortOn("mName");
			
			var signature:String = generateSignature(url, customSecrect, tokenSecrect,
				httpMethod, parameters);
			signature = executeString(signature);
			
			var parameterString:String = normalizeRequestParameters(parameters);
			var urlWithQParameter:String = url;
			if (parameterString != null && !parameterString == "") {
				urlWithQParameter += "?" + parameterString;
			}
			
			urlWithQParameter += "&oauth_signature=";
			urlWithQParameter += executeString(signature);
			return urlWithQParameter;
		}
		
		//生产URL的参数串
		public static function getOauthWithoutUrl(url:String, httpMethod:String, customKey:String,
										   customSecrect:String, tokenKey:String, tokenSecrect:String,
										   verify:String, callbackUrl:String, parameters:Array):String 
		{
			//trace("getOauthUrl:", httpMethod, customKey, customSecrect, tokenKey, tokenSecrect, verify, callbackUrl);
			var nonce:String = generateNonce();
			var timeStamp:String = generateTimeStamp();
			
			parameters.push(new HttpParameter(OAuthVersionKey, OAuthVersion));
			parameters.push(new HttpParameter(OAuthNonceKey, nonce));
			parameters.push(new HttpParameter(OAuthTimestampKey, timeStamp));
			parameters.push(new HttpParameter(OAuthSignatureMethodKey, HMACSHA1SignatureType_TEXT));
			parameters.push(new HttpParameter(OAuthConsumerKeyKey, customKey));
			
			if (tokenKey != null && tokenKey != "") {
				parameters.push(new HttpParameter(OAuthTokenKey, tokenKey));
			}
			
			if (verify != null && verify != "") {
				parameters.push(new HttpParameter(oAauthVerifier, verify));
			}
			
			if (callbackUrl != null && callbackUrl != "") {
				parameters.push(new HttpParameter(OAuthCallbackKey, callbackUrl));
			}
			parameters.sortOn("mName");
			
			var signature:String = generateSignature(url, customSecrect, tokenSecrect,
				httpMethod, parameters);
			signature = executeString(signature);
			
			var parameterString:String = normalizeRequestParameters(parameters);
			
			parameterString += "&oauth_signature=";
			parameterString += executeString(signature);
			return parameterString;
		}
		
		//生产POST参数
		public static function getOauthPostParas(url:String, httpMethod:String, customKey:String,
										   customSecrect:String, tokenKey:String, tokenSecrect:String,
										   verify:String, callbackUrl:String, parameters:Array):Array 
		{
			//trace("getOauthUrl:", httpMethod, customKey, customSecrect, tokenKey, tokenSecrect, verify, callbackUrl);
			var nonce:String = generateNonce();
			var timeStamp:String = generateTimeStamp();
			
			parameters.push(new HttpParameter(OAuthVersionKey, OAuthVersion));
			parameters.push(new HttpParameter(OAuthNonceKey, nonce));
			parameters.push(new HttpParameter(OAuthTimestampKey, timeStamp));
			parameters.push(new HttpParameter(OAuthSignatureMethodKey, HMACSHA1SignatureType_TEXT));
			parameters.push(new HttpParameter(OAuthConsumerKeyKey, customKey));
			
			if (tokenKey != null && tokenKey != "") {
				parameters.push(new HttpParameter(OAuthTokenKey, tokenKey));
			}
			
			if (verify != null && verify != "") {
				parameters.push(new HttpParameter(oAauthVerifier, verify));
			}
			
			if (callbackUrl != null && callbackUrl != "") {
				parameters.push(new HttpParameter(OAuthCallbackKey, callbackUrl));
			}
			parameters.sortOn("mName");
			
			var signature:String = generateSignature(url, customSecrect, tokenSecrect,
				httpMethod, parameters);
			signature = executeString(signature);
			
			parameters.push(new HttpParameter(OAuthSignatureKey, signature));
			return parameters;
		}
		
		/**
		 * Normalizes the request parameters according to the spec.
		 * 
		 * @param parameters
		 *            The list of parameters already sorted
		 * @return a string representing the normalized parameters
		 */
		public static function normalizeRequestParameters(parameters:Array):String 
		{
			var sb:String = "";
			var p:HttpParameter = null;
			for (var i:int = 0, size:int = parameters.length; i < size; i++)
			{
				p = parameters[i];
				sb += p.mName;
				sb += "=";
				sb += p.mValue;
				
				if (i < size - 1) {
					sb += "&";
				}
			}
			return sb;
		}
		
		/**
		 * Generate the timestamp for the signature.
		 * 
		 * @return
		 */
		private static function generateTimeStamp():String {
			var date:Date = new Date();
			//var timestamp:String = String(date.getTime()).substr(0, 10);
			var timestamp:String = Math.floor(date.getTime() / 1000).toString();
			return timestamp;
		}
		
		private static function generateNonce():String {
			//return String(int(Math.random() * 100000) + 123400);
			return String(new Date().getTime()).substr(6);
		}
		
		private static function generateSignature(baseUrl:String, consumerSecret:String,
										   tokenSecret:String, httpMethod:String, parameters:Array):String {
			
			var signatureBase:String = generateSignatureBase(baseUrl, httpMethod,
				parameters);
//			trace("signatureBase:", signatureBase);
			var mac:HMAC = Crypto.getHMAC(HMACSHA1SignatureType);
			var oauthKey:String = executeString(consumerSecret)
				+ "&"
				+ ((tokenSecret == null || tokenSecret == "") ? ""
					: executeString(tokenSecret));
//			trace("tokenSecret:", oauthKey);
			var key:ByteArray = Hex.toArray(Hex.fromString(oauthKey));
			
			var message:ByteArray = Hex.toArray(Hex.fromString(signatureBase));
			
			var result:ByteArray = mac.compute(key,message);
			var res:String = Base64.encodeByteArray(result);
			
			return res;
		}
		
		private static function generateSignatureBase(url:String, httpMethod:String,
											   parameters:Array):String {
			
			parameters.sortOn("mName");
			
//			url = encodeURI(url);
			url = executeString(url);
			
			var normalizedRequestParameters:String = formEncodeParameters(parameters);
			normalizedRequestParameters = encodeURI(normalizedRequestParameters);
			normalizedRequestParameters = executeString(normalizedRequestParameters);
			
			var signatureBase:String = httpMethod.toUpperCase();
			signatureBase += "&";
			signatureBase += url;
			signatureBase += "&";
			signatureBase += normalizedRequestParameters;
			
			return signatureBase;
		}
		
		/**
		 * Encode each parameters in list.
		 * 
		 * @param parameters
		 *            List of parameters
		 * @return Encoded parameters
		 */
		private static function formEncodeParameters(parameters:Array):String {
			var encodeParams:Array = new Array();
			for each(var a:HttpParameter in parameters) {
				encodeParams.push(new HttpParameter(a.mName, executeString(a.mValue)));
			}
			return normalizeRequestParameters(encodeParams);
		}
		
		public static function executeString(encoded:String):String {
			var buf:String = "";
			var focus:String;
			for (var i:int = 0; i < encoded.length; i++) {
				focus = encoded.charAt(i);
				if (focus == "*") {
					buf += "%2A";
				} else if (focus == " ") {
					buf += "%20";
				}else if (focus == "+") {
					buf += "%2B";
				} else if (focus == "$") {
					buf += "%24";
				} else if (focus == ",") {
					buf += "%2C";
				} else if (focus == ":") {
					buf += "%3A";
				} else if (focus == ";") {
					buf += "%3B";
				} else if (focus == "?") {
					buf += "%3F";
				} else if (focus == "@") {
					buf += "%40";
				} else if (focus == "/") {
					buf += "%2F";
				} else if (focus == "&") {
					buf += "%26";
				} else if (focus == "=") {
					buf += "%3D";
				} else if (focus == "~") {
					buf += "%7E";
				} else if (focus == "'") {
					buf += "%27";
				} else {
					buf += focus;
				}
			}
			return buf;
		}
	}
}