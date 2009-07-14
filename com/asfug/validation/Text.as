package com.asfug.validation
{
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class Text
	{
		/**
		 * Checks if string is empty
		 * @param	str	String to check
		 * @return	true or false
		 */
		public static function isEmpty(str:String):Boolean
		{
			if(str == '')	return true;
			else 			return false;
		}
	}
}