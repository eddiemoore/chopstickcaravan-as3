package com.asfug.validation
{
	/**
	 * ...
	 * @author Ed Moore
	 * Based off javascript code by Samuel Liew (http://www.samliew.com)
	 */
	public class SingaporeNRIC
	{
		/**
		 * Checks if string is a Singapore NRIC or FIN number
		 * Format: SXXXXXXXA
		 * Where # is a number, and the first letter is either S,T,F,G.
		 * @param	str	String to check
		 * @return	true or false
		 */
		public static function isNRIC(str:String):Boolean
		{
			if (str.length != 9)	
				return false;
			
			str = str.toUpperCase();
			
			var icArray:Array = new Array();
			for(var i:int = 0; i < 9; i++) 
				icArray[i] = str.charAt(i);
			
			icArray[1] = Number(icArray[1]) * 2;
			icArray[2] = Number(icArray[2]) * 7;
			icArray[3] = Number(icArray[3]) * 6;
			icArray[4] = Number(icArray[4]) * 5;
			icArray[5] = Number(icArray[5]) * 4;
			icArray[6] = Number(icArray[6]) * 3;
			icArray[7] = Number(icArray[7]) * 2;
			
			var weight:int = 0;
			for(i = 1; i < 8; i++) {
				weight += int(icArray[i]);
			}
			
			var offset:int = (icArray[0]=="T"||icArray[0]=="G") ? 4:0;
			var temp:Number = (offset+weight)%11;
			
			var st:Array = new Array("J","Z","I","H","G","F","E","D","C","B","A");
			var fg:Array = new Array("X","W","U","T","R","Q","P","N","M","L","K");
			
			var theAlpha:String;
			if     (icArray[0]=="S"||icArray[0]=="T") { theAlpha=st[temp]; }
			else if(icArray[0]=="F"||icArray[0]=="G") { theAlpha=fg[temp]; }
			
			if (icArray[8] != theAlpha) 
				return false
			else 
				return true;
		}
		
	}
}