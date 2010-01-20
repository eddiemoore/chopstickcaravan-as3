package com.asfug.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class ToggleButtonEvent extends Event
	{
		public static const TOGGLE_BUTTON_CHECKED:String = 'toggleButtonChecked';
		public static const TOGGLE_BUTTON_UNCHECKED:String = 'toggleButtonUnchecked';
		
		public function ToggleButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
	}

}