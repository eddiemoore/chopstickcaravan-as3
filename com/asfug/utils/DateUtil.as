package com.asfug.utils 
{
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class DateUtil
	{
		
		public static function getDateTime():String
		{
			var d:Date = new Date();
			var year:String = d.getFullYear().toString();
			var month:String = d.getMonth() + 1 < 10 ? StringUtil.addLeadingZero(d.getMonth() + 1) : int(d.getMonth() + 1).toString();	
			var day:String = d.getDate() < 10 ? StringUtil.addLeadingZero(d.getDate()) : d.getDate().toString();	
			var hours:String = d.getHours() + 1 < 10 ? StringUtil.addLeadingZero(d.getHours() + 1) : int(d.getHours() + 1).toString();	
			var min:String = d.getMinutes() < 10 ? StringUtil.addLeadingZero(d.getMinutes()) : d.getMinutes().toString();	
			var sec:String = d.getSeconds() < 10 ? StringUtil.addLeadingZero(d.getSeconds()) : d.getSeconds().toString();	
			return year + month + day + hours + min + sec;
		}
		
	}

}