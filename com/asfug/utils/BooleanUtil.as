package com.asfug.utils 
{
	
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class BooleanUtil 
	{
		/**
		 * Converts string into boolean value
		 * @param	value	(1,0) (true, false) (yes, no) (y, n)
		 * @return
		 */
		public static function toBool(value:String):Boolean
		{
			switch(value.toLowerCase()) 
			{
				case '1':
				case 'true':
				case 'yes':
				case 'y':
					return true;
				case '0':
				case 'false':
				case 'no':
				case 'n' :
					return false;
				default:
					return Boolean(value);
			}
		}	
	}
	
}