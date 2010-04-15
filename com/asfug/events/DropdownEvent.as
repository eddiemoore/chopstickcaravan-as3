package com.asfug.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class DropdownEvent extends Event
	{
		public static const ITEM_CHANGED:String = 'itemChanged';
		public static const OPENED_DROP_DOWN:String = "openedDropDown";
		public static const CLOSED_DROP_DOWN:String = "closedDropDown";
		
		public function DropdownEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
	}

}