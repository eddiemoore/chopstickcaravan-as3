/**
 * Created by Ed Moore
 */
package com.asfug.validation
{
	public class Email
	{
		public static function isEmail(email:String):Boolean
		{
			var regEx:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			return regEx.test(email);
		}
	}
}