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
		public var defaultChecked:Boolean;
		public var isChecked:Boolean;
		internal var name:String;
		private var _uncheckedFrame:String;
		private var _checkedFrame:String;
		
		/**
		 * Radio Button
		 * @param	mc				Movie Clip to be the radio Button
		 * @param	checked			Sets if radio button should be selected by default
		 * @param	checkedFrame	Frame label for checked frame. DEFAULT : 'checked'
		 * @param	uncheckedFrame	Frame label for unchecked frame. DEFAULT : 'unchecked'
		 */
		public function RadioButton(mc:MovieClip, checked:Boolean = false, checkedFrame:String = 'checked', uncheckedFrame:String = 'unchecked') 
		{
			_mc = mc;
			defaultChecked = checked;
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
		/**
		 * On click, check the Toggle Button
		 * @param	e
		 */
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