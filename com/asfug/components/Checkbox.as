package com.asfug.components 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class Checkbox
	{
		private var _mc:MovieClip;
		public var checked:Boolean;
		internal var name:String;
		
		/**
		 * Initialise Check Box
		 * @param	mc	Movie Clip of the check box. Required 2 frames with labels "checked" and "unchecked"
		 * @param	check	Set if checkbox needs to be checked at the start or not.
		 */
		public function Checkbox(mc:MovieClip, check:Boolean = false) 
		{
			_mc = mc;
			checked = check;
			name = _mc.name;
			
			if (check) 
				_mc.gotoAndStop('checked');
			else
				_mc.gotoAndStop('unchecked');
			
			_mc.addEventListener(MouseEvent.CLICK, hClick);
			_mc.mouseChildren = false;
			_mc.buttonMode = true;
		}
		
		private function hClick(e:MouseEvent):void 
		{
			if (checked)
			{
				_mc.gotoAndStop('unchecked');
				checked = false;
			}
			else
			{
				_mc.gotoAndStop('checked');
				checked = true;
			}
		}
		
	}

}