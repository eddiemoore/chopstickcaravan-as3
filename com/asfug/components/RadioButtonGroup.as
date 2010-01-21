package com.asfug.components 
{
	import com.asfug.events.ToggleButtonEvent;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class RadioButtonGroup
	{
		//private var _name:String;
		private var _radioButtons:Array;
		private var _currentIndex:int = -1;
		
		public function RadioButtonGroup() 
		{
			//_name = name;
			_radioButtons = new Array();
		}
		
		public function addRadioButton(rb:RadioButton, data:String = ''):void
		{
			rb.addEventListener(ToggleButtonEvent.TOGGLE_BUTTON_CHECKED, radioButtonChecked);
			_radioButtons.push( { rb:rb, data:data } );
		}
		
		private function radioButtonChecked(e:ToggleButtonEvent):void 
		{
			var rb:RadioButton = e.currentTarget as RadioButton;
			for (var i:int = 0; i < _radioButtons.length; ++i) 
			{
				var current:RadioButton = _radioButtons[i].rb as RadioButton;
				if (current != rb) current.uncheck();
				else _currentIndex = i;
			}
		}
		
		public function reset():void 
		{
			for (var i:int = 0; i < _radioButtons.length; ++i) 
			{
				var rb:RadioButton = _radioButtons[i].rb as RadioButton;
				rb.defaultChecked ? rb.check() : rb.uncheck();
			}
		}
		
		//public function get name():String { return _name; }
		
		public function get radioButtons():Array { return _radioButtons; }
		
		public function get currentIndex():int { return _currentIndex; }
		
	}

}