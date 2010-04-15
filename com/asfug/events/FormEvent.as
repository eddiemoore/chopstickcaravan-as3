package com.asfug.events 
{
	import flash.display.DisplayObject;
	import flash.events.DataEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class FormEvent extends DataEvent
	{
		public static const FIELD_ERROR:String = 'fielderror';
		public static const FIELD_OUTOFRANGE:String = 'outOfRange';
		public static const FORM_SUBMITTED:String = 'formSubmitted';
		public static const FORM_ERROR:String = 'formerror';
		public static const FORM_VALID:String = 'formvalid';
		private var _field:TextField;
		private var _data:String;
		
		public function FormEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:String = "", field:TextField = null)
		{
			_field = field;
			_data = data;
			super(type, bubbles, cancelable, data);
		}
		
		public function get field():TextField { return _field; }
		
		override public function get data():String { return _data; }
		
	}

}