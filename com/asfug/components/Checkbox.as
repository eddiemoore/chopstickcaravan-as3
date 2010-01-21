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
		 * Check Box
		 * @param	mc				Movie Clip to be the check box
		 * @param	checked			Sets if check box should be selected by default
		 * @param	checkedFrame	Frame label for checked frame. DEFAULT : 'checked'
		 * @param	uncheckedFrame	Frame label for unchecked frame. DEFAULT : 'unchecked'
		 */
		public function Checkbox(mc:MovieClip, checked:Boolean = false, checkedFrame:String = 'checked', uncheckedFrame:String = 'unchecked') 
		{
			super(mc, checked, checkedFrame, uncheckedFrame);
		}
		/**
		 * If checkbox is checked, uncheck it.
		 * If checkbox is uncheckes, check it.
		 * @param	e
		 */
		override protected function hClick(e:MouseEvent):void 
		{
			if (isChecked)
				uncheck();
			else
				check();
		}
		
	}

}