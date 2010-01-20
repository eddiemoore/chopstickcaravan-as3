package com.asfug.components 
{
	import com.asfug.events.ToggleButtonEvent;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class RadioButton extends EventDispatcher
	{
		private var _mc:MovieClip;
		public var isChecked:Boolean;
		internal var name:String;
		private var _uncheckedFrame:String;
		private var _checkedFrame:String;
		
		public function RadioButton(mc:MovieClip, checked:Boolean = false, checkedFrame:String = 'checked', uncheckedFrame:String = 'unchecked') 
		{
			_mc = mc;
			isChecked = checked;
			name = _mc.name;
			_checkedFrame = checkedFrame;
			_uncheckedFrame = uncheckedFrame;
			
			if (isChecked)	check();
			else			uncheck();
			
			_mc.addEventListener(MouseEvent.CLICK, hClick);
			_mc.mouseChildren = false;
			_mc.buttonMode = true;
		}
		
		protected function hClick(e:MouseEvent):void 
		{
			if (!isChecked) check();
		}
		/**
		 * Check the Toggle button
		 */
		public function check():void
		{
			_mc.gotoAndStop(_checkedFrame);
			isChecked = true;
			dispatchEvent(new ToggleButtonEvent(ToggleButtonEvent.TOGGLE_BUTTON_CHECKED));
		}
		/**
		 * Uncheck the Toggle button
		 */
		public function uncheck():void
		{
			_mc.gotoAndStop(_uncheckedFrame);
			isChecked = false;
			dispatchEvent(new ToggleButtonEvent(ToggleButtonEvent.TOGGLE_BUTTON_UNCHECKED));
		}
		
	}

}