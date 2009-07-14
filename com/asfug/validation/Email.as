package com.asfug.validation
{
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class Email
	{
		/**
		 * Checks if string is an email address
		 * @param	email	String to check
		 * @return	true or false
		 */
		public static function isEmail(email:String):Boolean
		{
			var regEx:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			return regEx.test(email);
		}
	}
}