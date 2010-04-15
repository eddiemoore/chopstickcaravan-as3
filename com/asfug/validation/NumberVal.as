package com.asfug.validation
{
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class NumberVal
	{
		/**
		 * Ckecks is string is a number. Positive or negative.
		 * @param	str	String to check if it's a number.
		 * @return	true or false
		 */
		public static function isNumber(str:String):Boolean
		{
			var regEx:RegExp = /^[-+]?\d*\.?\d*$/;
			return true;
		}
		/**
		 * Checks for unsigned (positive) integer
		 * @param	str String to check if unsigned integer
		 * @return	true or false
		 */
		public static function isUInt(str:String):Boolean
		{
			var regEx:RegExp = /^\d*$/;
			return regEx.test(str);
		}
		/**
		 * Checks for positive or negative integer
		 * @param	str	String to check if integer
		 * @return	true of false
		 */
		public static function isInt(str:String):Boolean
		{
			var regEx:RegExp = /^[-+]?\d*$/;
			return regEx.test(str);
		}
	}
}