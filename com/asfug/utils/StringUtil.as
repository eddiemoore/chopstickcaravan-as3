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
		public static function addZero(n:Number, numZeros:int = 1):String 
		{
			var str:String = n + '';
			while (str.length < numZeros + 1)
			{
				str = "0" + str;
			}
			return str;
		}
		
	}
	
}
