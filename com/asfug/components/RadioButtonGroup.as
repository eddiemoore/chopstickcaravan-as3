package com.asfug.components 
{
	import com.asfug.events.ToggleButtonEvent;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class RadioButtonGroup
	{
		private var _radioButtons:Array;
		private var _currentIndex:int = -1;
		/**
		 * Generates a Radio Button Group
		 */
		public function RadioButtonGroup() 
		{
			_radioButtons = new Array();
		}
		/**
		 * Adds a radio button to the radio button group
		 * @param	rb		Radio button to add
		 * @param	data	Data that is associated to that radio button
		 */
		public function addRadioButton(rb:RadioButton, data:String = ''):void
		{
			rb.addEventListener(ToggleButtonEvent.TOGGLE_BUTTON_CHECKED, radioButtonChecked);
			_radioButtons.push( { rb:rb, data:data } );
		}
		/**
		 * When toggle button is pressed
		 * @param	e	ToggleButtonEvent
		 */
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
		/**
		 * Resets the radio buttons back to default
		 */
		public function reset():void 
		{
			for (var i:int = 0; i < _radioButtons.length; ++i) 
			{
				var rb:RadioButton = _radioButtons[i].rb as RadioButton;
				rb.defaultChecked ? rb.check() : rb.uncheck();
			}
		}
		/**
		 * Gets the array of radio buttons
		 */
		public function get radioButtons():Array { return _radioButtons; }
		/**
		 * Gets current selected radio button index in the radio buttons array
		 */
		public function get currentIndex():int { return _currentIndex; }
		
	}

}