package com.asfug.components 
{
	import com.asfug.events.ToggleButtonEvent;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class RadioButtonGroup
	{
		private var _name:String;
		private var _radioButtons:Array;
		
		public function RadioButtonGroup(name:String = 'rbg') 
		{
			_name = name;
			_radioButtons = new Array();
		}
		
		public function addRadioButton(rb:RadioButton):void
		{
			rb.addEventListener(ToggleButtonEvent.TOGGLE_BUTTON_CHECKED, radioButtonChecked);
			_radioButtons.push(rb);
		}
		
		private function radioButtonChecked(e:ToggleButtonEvent):void 
		{
			var rb:RadioButton = e.currentTarget as RadioButton;
			for (var i:int = 0; i < _radioButtons.length; ++i) 
			{
				var current:RadioButton = _radioButtons[i] as RadioButton;
				if (current != rb) current.uncheck();
			}
		}
		
		public function get name():String { return _name; }
		
		public function get radioButtons():Array { return _radioButtons; }
		
	}

}