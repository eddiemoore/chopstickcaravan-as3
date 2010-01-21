package com.asfug.utils {

	/**
	 * string utility class
	 */
	public class StringUtil {
		/**
		 * remove white spaces at the beginning and the end of a string
		 * @param	str		input string
		 */
		
		
		public static function trim(str:String, char:String):String 
		{
			return trimBack(trimFront(str, char), char);
		}

		public static function trimFront(str:String, char:String):String 
		{
			char = stringToCharacter(char);
			if (str.charAt(0) == char)
				str = trimFront(str.substring(1), char);
				
			return str;
		}

		public static function trimBack(str:String, char:String):String 
		{
			char = stringToCharacter(char);
			if (str.charAt(str.length - 1) == char)
				str = trimBack(str.substring(0, str.length - 1), char);
				
			return str;
		}
		
		public static function stringToCharacter(str:String):String 
		{
			if (str.length == 1) 
				return str;
			return str.slice(0, 1);
		}
		
		public static function removeDoubleSpaceing(str:String):String
		{
			str = str.replace(/[  ]+/g, ' ');
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
