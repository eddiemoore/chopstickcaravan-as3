package com.asfug.events
{
	import flash.events.*;
	
	public class ScrollBarEvent extends Event
	{
		public static const VALUE_CHANGED = "valueChanged";
		private var scrollPercent:Number;
		
		public function ScrollBarEvent(sp:Number):void 
		{
			super(VALUE_CHANGED);
			scrollPercent = sp;
		}
		
		public function getScrollPercent():Number
		{
			return scrollPercent;
		}
	}
}