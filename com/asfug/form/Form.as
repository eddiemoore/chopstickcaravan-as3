package com.asfug.form 
{
	import com.asfug.components.Checkbox;
	import com.asfug.components.Dropdown;
	import com.asfug.components.RadioButtonGroup;
	import com.asfug.events.FormEvent;
	import com.asfug.validation.Email;
	import com.asfug.validation.NumberVal;
	import com.asfug.validation.SingaporeNRIC;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	//import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Ed Moore
	 */
	public class Form extends EventDispatcher
	{
		private var _submitURL:String;
		private var _requestMethod:String;
		
		//private var _fields:Dictionary;
		private var _fields:Array;
		private var _formVars:URLVariables;
		
		/**
		 * New Form
		 * @param	submit_url	Url to submit to
		 * @param	method	URL Request Method 'post' or 'get'
		 */
		public function Form(submit_url:String, method:String = URLRequestMethod.POST) 
		{
			//_fields = new Dictionary();
			_fields = new Array();
			_submitURL = submit_url;
			_requestMethod = method;
			_formVars = new URLVariables();
		}
		
		/**
		 * Add Text Field
		 * @param	field		Text field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	restrict	Characters to restrict in textfield
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addTextField(field:TextField, variable:String, manditory:Boolean = true, error_text:String = '', restrict:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.TEXT_FIELD, restrict:restrict, error:error_text, min:minChar, max:maxChar });
			
			if (restrict.length > 0)
				field.restrict = restrict;
			initField(field, maxChar);
		}
		
		/**
		 * Add Email Field
		 * @param	field		Text Field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addEmailField(field:TextField, variable:String, manditory:Boolean = true, error_text:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.EMAIL_FIELD, error:error_text, min:minChar, max:maxChar });
			
			field.restrict = 'a-zA-Z0-9@_\\-\.';
			initField(field, maxChar);
		}
		
		/**
		 * Add Number Field
		 * @param	field		Text Field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addNumberField(field:TextField, variable:String, manditory:Boolean = true, error_text:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.NUMBER_FIELD, error:error_text, min:minChar, max:maxChar });
			
			field.restrict = '0-9';
			initField(field, maxChar);
		}
		/**
		 * Add NRIC/FIN Field
		 * @param	field		Text Field to validate
		 * @param	variable	Variable name to send to server
		 * @param	manditory	If field is manditory
		 * @param	error_text	Error message to display
		 * @param	minChar		Minimum character for field.
		 * @param	maxChar		Maximum character for field. (0 = infinate);
		 */
		public function addNRICField(field:TextField, variable:String, manditory:Boolean = true, error_text:String = '', minChar:int=0, maxChar:int=0):void
		{
			_fields.push( { field:field, variable:variable, defaultText:field.text, manditory:manditory, type:FormFieldTypes.NRIC_FIELD, error:error_text, min:minChar, max:maxChar });
			
			field.restrict = 'a-zA-Z0-9';
			initField(field, maxChar);
		}
		/**
		 * Initialises Fields
		 * @param	field	Field to initialise
		 * @param	maxChar	Maximum characters in field
		 */
		private function initField(field:TextField, maxChar:int = 0):void
		{
			field.type = TextFieldType.INPUT;
			if (maxChar > 0)
				field.maxChars = maxChar;
			field.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			field.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
		}
		/**
		 * Add Checkbox
		 * @param	cb			Checkbox to add.
		 * @param	variable	Variable name to send to server.
		 * @param	manditory	If checkbox is manditory.
		 * @param	error_text	Error message to display.
		 */
		public function addCheckBox(cb:Checkbox, variable:String, manditory:Boolean = true, error_text:String = ''):void 
		{
			//_fields[cb.name] = { field:cb, manditory:manditory, type:'checkbox', error:error_text};
			_fields.push({ field:cb, variable:variable, manditory:manditory, type:FormFieldTypes.CHECKBOX, error:error_text});
		}
		/**
		 * Add Radio Button Group
		 * @param	rbg			Radio button group to add
		 * @param	variable	Variable name to send to server.
		 * @param	manditory	If checkbox is manditory.
		 * @param	error_text	Error message to display.
		 */
		public function addRadioButtonGroup(rbg:RadioButtonGroup, variable:String, manditory:Boolean = true, error_text:String = ''):void
		{
			_fields.push({ field:rbg, variable:variable, manditory:manditory, type:FormFieldTypes.RADIO_BUTTON_GROUP, error:error_text});
		}
		/**
		 * Add Dropdown
		 * @param	dropdown	Dropdown to add
		 * @param	variable	Variable name to send to server.
		 * @param	manditory	If checkbox is manditory.
		 * @param	error_text	Error message to display.
		 */
		public function addDropdown(dropdown:Dropdown, variable, manditory:Boolean = true, error_text:String = ''):void 
		{
			_fields.push({ field:dropdown, variable:variable, manditory:manditory, type:FormFieldTypes.DROPDOWN, error:error_text});
		}
		/**
		 * Add Additional Variable
		 * @param	data		Data to send
		 * @param	variable	Variable name to send to server.
		 * @param	manditory	If checkbox is manditory.
		 * @param	error_text	Error message to display.
		 */
		public function addAdditionalVariable(data:String, variable:String, manditory:Boolean = true, error_text:String = '' ):void 
		{
			for (var i:int = 0; i < _fields.length; ++i) 
			{
				if (_fields[i].variable == variable)
					_fields.splice(i, 1);
			}
			var t:TextField = new TextField();
			t.text = data == null ? '' : data;
			_fields.push({ field:t, variable:variable, manditory:manditory, type:FormFieldTypes.TEXT_FIELD, error:error_text});
		}
		
		/**
		 * Submit Form
		 * First validates and then submits the form
		 */
		public function submit():void
		{
			if (validate())
			{
				dispatchEvent(new FormEvent(FormEvent.FORM_VALID));
				trace(_formVars);
				sendForm();
			}
		}
		/**
		 * Validates Form
		 * @return	Boolean value
		 */
		public function validate():Boolean
		{
			var valid:Boolean = true;
			_formVars = new URLVariables();
			for (var i:int = 0; i < _fields.length; ++i)
			{
				var currentObj:Object = _fields[i] as Object;
				switch (currentObj.type)
				{
					case FormFieldTypes.TEXT_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.min > 0)
							{
								if (currentObj.field.text.length > currentObj.max || currentObj.field.text.length < currentObj.min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
									return false;
								}
							}
						}
						_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.EMAIL_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText || !Email.isEmail(currentObj.field.text))
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.min > 0)
							{
								if (currentObj.field.text.length > currentObj.max || currentObj.field.text.length < currentObj.min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
									return false;
								}
							}
						}
						_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.NUMBER_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText || !NumberVal.isNumber(currentObj.field.text))
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.min > 0)
							{
								if (currentObj.field.text.length > currentObj.max || currentObj.field.text.length < currentObj.min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
									return false;
								}
							}
						}
						_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.NRIC_FIELD :
						if (currentObj.manditory)
						{
							if (currentObj.field.text == '' || currentObj.field.text == currentObj.defaultText || !SingaporeNRIC.isNRIC(currentObj.field.text))
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error, currentObj.field));
								return false;
							}
							if (currentObj.min > 0)
							{
								if (currentObj.field.text.length > currentObj.max || currentObj.field.text.length < currentObj.min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, currentObj.error, currentObj.field));
									return false;
								}
							}
						}
						_formVars[currentObj.variable] = currentObj.field.text;
					break;
					case FormFieldTypes.CHECKBOX :
						var f:Checkbox = currentObj.field as Checkbox;
						if (currentObj.manditory)
						{
							if (!f.isChecked)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error));
								return false;
							}
						}
						if (f.isChecked)
							_formVars[currentObj.variable] = 'Y';
						else
							_formVars[currentObj.variable] = 'N';
					break;
					case FormFieldTypes.RADIO_BUTTON_GROUP :
						var rbg:RadioButtonGroup = currentObj.field as RadioButtonGroup;
						if (currentObj.manditory)
						{
							if (rbg.currentIndex == -1)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error));
								return false;
							}
						}
						if (rbg.currentIndex == -1)
							_formVars[currentObj.variable] = '';
						else
							_formVars[currentObj.variable] = rbg.radioButtons[rbg.currentIndex].data;
					break;
					case FormFieldTypes.DROPDOWN :
						var d:Dropdown = currentObj.field as Dropdown;
						if (currentObj.manditory)
						{
							if (d.getSelectedIndex() == 0)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, currentObj.error));
								return false;
							}
						}
						_formVars[currentObj.variable] = d.getSelectedData();
					break;
				}
			}
			
			return valid;
		}
		
		private function sendForm():void
		{
			var l:URLLoader = new URLLoader();
			l.addEventListener(Event.COMPLETE, formSubmitComplete, false, 0, true);
			l.addEventListener(IOErrorEvent.IO_ERROR, formSubmitError, false, 0, true);
			
			var req:URLRequest = new URLRequest();
			req.method = _requestMethod;
			req.data = _formVars;
			req.url = _submitURL;
			
			l.load(req);
		}
		
		private function formSubmitComplete(e:Event):void 
		{
			dispatchEvent(new FormEvent(FormEvent.FORM_SUBMITTED, false, false, e.currentTarget.data));
		}
		
		private function formSubmitError(e:IOErrorEvent):void 
		{
			dispatchEvent(new FormEvent(FormEvent.FORM_ERROR));
		}
		
		private function focusIn(e:FocusEvent):void 
		{
			var f:TextField = e.currentTarget as TextField;
			for (var i:int = 0; i < _fields.length; ++i) 
			{
				if (f == _fields[i].field)
				{
					if (f.text == _fields[i].defaultText)
						f.text = '';
					break;
				}
			}
		}
		
		private function focusOut(e:FocusEvent):void 
		{
			var f:TextField = e.currentTarget as TextField;
			for (var i:int = 0; i < _fields.length; ++i) 
			{
				if (f == _fields[i].field)
				{
					if (f.text == '')
						f.text = _fields[i].defaultText;
					break;
				}
			}
		}
		
	}

}