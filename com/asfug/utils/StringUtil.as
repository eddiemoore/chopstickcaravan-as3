package com.asfug.utils {

	/**
	 * string utility class
	 */
	public class StringUtil {
		/**
		 * remove white spaces at the beginning and the end of a string
		 * @param	str		input string
		 */
		public static function trim(str:String):String
		{
			str = str.replace(/^(\s\n\r)*/g,"");
			str = str.replace(/(\s\n\r)*$/g,"");
			return str;
		}
		/**
		 * Adds zero in front of single digits
		 * @param	n			number to add zero(s) to
		 * @param	numZeros	number of zeros to add
		 * @return
		 */
		public static function addLeadingZero(n:int, numZeros:int = 1):String 
		{
			return (new Array(numZeros).join('0')) + n;
		}
		
	}
	
}
