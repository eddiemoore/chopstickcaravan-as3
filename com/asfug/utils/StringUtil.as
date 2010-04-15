package com.asfug.utils {

	/**
	 * string utility class
	 */
	public class StringUtil {
		/**
		 * remove white spaces at the beginning and the end of a string
		 * @param	str		input string
		 */
		
		/**
		 * Trims character from beginning and end of string.
		 * @param	str		String to remove character from
		 * @param	char	Character to trim.
		 * @return
		 */
		public static function trim(str:String, char:String = ' '):String 
		{
			return trimBack(trimFront(str, char), char);
		}
		/**
		 * Trims character from front of string
		 * @param	str		String to remove character from
		 * @param	char	Character to trim.
		 * @return
		 */
		public static function trimFront(str:String, char:String = ' '):String 
		{
			char = stringToCharacter(char);
			if (str.charAt(0) == char)
				str = trimFront(str.substring(1), char);
				
			return str;
		}
		/**
		 * Trims character from back of string
		 * @param	str		String to remove character from
		 * @param	char	Character to trim.
		 * @return
		 */
		public static function trimBack(str:String, char:String = ' '):String 
		{
			char = stringToCharacter(char);
			if (str.charAt(str.length - 1) == char)
				str = trimBack(str.substring(0, str.length - 1), char);
				
			return str;
		}
		/**
		 * Gets first character from a string
		 * @param	str	String to convert into a single character
		 * @return
		 */
		public static function stringToCharacter(str:String):String 
		{
			if (str.length == 1) 
				return str;
			return str.slice(0, 1);
		}
		/**
		 * Removes all double spacing from a string
		 * @param	str	String to remove double spacing from
		 * @return
		 */
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
			return (new Array(numZeros + 1).join('0')) + n as String;
		}
		
	}
	
}
