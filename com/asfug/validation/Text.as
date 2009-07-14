/**
 * Created by Ed Moore
 */
package com.asfug.validation
{
	public class Text
	{
		public static function isEmpty(str:String):Boolean
		{
			if(str == '')	return true;
			else 			return false;
		}
	}
}