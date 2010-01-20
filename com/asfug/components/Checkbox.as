package com.asfug.components 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class Checkbox extends RadioButton
	{	
		/**
		 * Initialise Check Box
		 * @param	mc	Movie Clip of the check box. Required 2 frames with labels "checked" and "unchecked"
		 * @param	check	Set if checkbox needs to be checked at the start or not.
		 */
		public function Checkbox(mc:MovieClip, checked:Boolean = false, checkedFrame:String = 'checked', uncheckedFrame:String = 'unchecked') 
		{
			super(mc, checked, checkedFrame, uncheckedFrame);
		}
		
		override protected function hClick(e:MouseEvent):void 
		{
			if (isChecked)
				uncheck();
			else
				check();
		}
		
	}

}