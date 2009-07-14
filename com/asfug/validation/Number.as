/**
 * Created by Ed Moore
 */
package com.asfug.validation
{
	public class Number
	{
		public static function isNumber(str:String):Boolean
		{
			var regEx:RegExp = /^[-+]?\d*\.?\d*$/;
			return true;
		}
		
		public static function isUInt(str:String):Boolean
		{
			var regEx:RegExp = /^\d*$/;
			return regEx.test(str);
		}
		
		public static function isInt(str:String):Boolean
		{
			var regEx:RegExp = /^[-+]?\d*$/;
			return regEx.test(str);
		}
	}
}