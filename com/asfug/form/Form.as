package com.asfug.form 
{
	import com.asfug.components.Checkbox;
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
	import flash.utils.Dictionary;
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
		
		public function addAdditionalVariable(string:String, variable:String, manditory:Boolean = true, error_text:String = '' ):void 
		{
			for (var i:int = 0; i < _fields.length; ++i) 
			{
				if (_fields[i].variable == variable)
					_fields.splice(i, 1);
			}
			var t:TextField = new TextField();
			t.text = string == null ? '' : string;
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
		
		private function validate():Boolean
		{
			var valid:Boolean = true;
			_formVars = new URLVariables();
			//for each (var key:Object in _fields)
			for (var i:int = 0; i < _fields.length; ++i)
			{
				//trace(_fields[i].variable);
				//switch (key.type)
				switch (_fields[i].type)
				{
					case FormFieldTypes.TEXT_FIELD :
						if (_fields[i].manditory)
						{
							if (_fields[i].field.text == '' || _fields[i].field.text == _fields[i].defaultText)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, _fields[i].error, _fields[i].field));
								return false;
							}
							if (_fields[i].min > 0)
							{
								if (_fields[i].field.text.length > _fields[i].max || _fields[i].field.text.length < _fields[i].min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, _fields[i].error, _fields[i].field));
									return false;
								}
							}
						}
						_formVars[_fields[i].variable] = _fields[i].field.text;
					break;
					case FormFieldTypes.EMAIL_FIELD :
						if (_fields[i].manditory)
						{
							if (_fields[i].field.text == '' || _fields[i].field.text == _fields[i].defaultText || !Email.isEmail(_fields[i].field.text))
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, _fields[i].error, _fields[i].field));
								return false;
							}
							if (_fields[i].min > 0)
							{
								if (_fields[i].field.text.length > _fields[i].max || _fields[i].field.text.length < _fields[i].min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, _fields[i].error, _fields[i].field));
									return false;
								}
							}
						}
						_formVars[_fields[i].variable] = _fields[i].field.text;
					break;
					case FormFieldTypes.NUMBER_FIELD :
						if (_fields[i].manditory)
						{
							if (_fields[i].field.text == '' || _fields[i].field.text == _fields[i].defaultText || !NumberVal.isNumber(_fields[i].field.text))
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, _fields[i].error, _fields[i].field));
								return false;
							}
							if (_fields[i].min > 0)
							{
								if (_fields[i].field.text.length > _fields[i].max || _fields[i].field.text.length < _fields[i].min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, _fields[i].error, _fields[i].field));
									return false;
								}
							}
						}
						_formVars[_fields[i].variable] = _fields[i].field.text;
					break;
					case FormFieldTypes.NRIC_FIELD :
						if (_fields[i].manditory)
						{
							if (_fields[i].field.text == '' || _fields[i].field.text == _fields[i].defaultText || !SingaporeNRIC.isNRIC(_fields[i].field.text))
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, _fields[i].error, _fields[i].field));
								return false;
							}
							if (_fields[i].min > 0)
							{
								if (_fields[i].field.text.length > _fields[i].max || _fields[i].field.text.length < _fields[i].min)
								{
									valid = false;
									dispatchEvent(new FormEvent(FormEvent.FIELD_OUTOFRANGE, false, false, _fields[i].error, _fields[i].field));
									return false;
								}
							}
						}
						_formVars[_fields[i].variable] = _fields[i].field.text;
					break;
					case FormFieldTypes.CHECKBOX :
						var f:Checkbox = _fields[i].field as Checkbox;
						if (_fields[i].manditory)
						{
							if (!f.checked)
							{
								valid = false;
								dispatchEvent(new FormEvent(FormEvent.FIELD_ERROR, false, false, _fields[i].error));
								return false;
							}
						}
						if (f.checked)
							_formVars[_fields[i].variable] = 'Y';
						else
							_formVars[_fields[i].variable] = 'N';
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
			//if (f.text == _fields[f.name].defaultText)
				//f.text = '';
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
			//if (f.text == '')
				//f.text = _fields[f.name].defaultText;
		}
		
		
	}

}