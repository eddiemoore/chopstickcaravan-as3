/**
 * Created by Ed Moore
 */
package com.asfug.validation
{
	public class CreditCard
	{
		
		public static function isVisa(str:String):Boolean
		{
			var regEx:RegExp = /^4[0-9]{12}(?:[0-9]{3})?$/;
			return regEx.test(str);
		}
		
		public static function isMasterCard(str:String):Boolean
		{
			var regEx:RegExp = /^5[1-5][0-9]{14}$/;
			return regEx.test(str);
		}
		
		public static function isAmericanExpress(str:String):Boolean
		{
			var regEx:RegExp = /^3[47][0-9]{13}$/;
			return regEx.test(str);
		}
		
		public static function isDinersClub(str:String):Boolean
		{
			var regEx:RegExp = /^3(?:0[0-5]|[68][0-9])[0-9]{11}$/;
			return regEx.test(str);
		}
		
		public static function isDiscover(str:String):Boolean
		{
			var regEx:RegExp = /^6(?:011|5[0-9]{2})[0-9]{12}$/;
			return regEx.test(str);
		}
		
		public static function isJCB(str:String):Boolean
		{
			var regEx:RegExp = /^(?:2131|1800|35\d{3})\d{11}$/;
			return regEx.test(str);
		}
	}
}