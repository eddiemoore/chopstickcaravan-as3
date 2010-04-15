package com.asfug.components
{
	import com.asfug.events.ScrollBarEvent;
	import flash.display.*;
	import flash.events.*;
	import caurina.transitions.*;
	
	public class ScrollBox extends EventDispatcher
	{
		private var _mc:MovieClip;
		private var _scrollbar:ScrollBar;
		private var _sb:MovieClip;
		private var _mask:MovieClip;
		private var _content:MovieClip;
		
		public function ScrollBox(mc:MovieClip, stage:Stage):void 
		{
			_mc = mc;
			_content = _mc.getChildByName("content") as MovieClip;
			_mask = _mc.getChildByName("masker") as MovieClip;
			
			_content.mask = _mask;
			
			_sb = _mc.getChildByName("sb") as MovieClip;
			_scrollbar = new ScrollBar(_sb, stage);
			_scrollbar._thumb.buttonMode = true;
			_scrollbar.addEventListener(ScrollBarEvent.VALUE_CHANGED, sbChange);
			_mc.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelEvent, true);
		}

		private function sbChange(e:ScrollBarEvent)
		{
			var scrollPercent = e.getScrollPercent();
			scrollbar.scroll(scrollPercent);
			Tweener.addTween(_content, { y:( -scrollPercent * (_content.height - _mask.height)) + _mask.y, time: 1 } );
			
		}
		
		public function scroll(scroll_to:Number):void
		{
			_scrollbar.dispatchEvent(new ScrollBarEvent(scroll_to));
		}
		
		public function scrollamt(scroll_to:Number):void{
			var curamt = -((_content.y - _sb.y) / (_content.height - _mask.height));
			curamt -= (scroll_to / 10);
			if(curamt>1){
				curamt=1;
			}
			else if(curamt<0){
				curamt=0;
			}
			scroll(curamt)
			_scrollbar.scroll(curamt)
		}
		
		public function validate():void
		{
			if (_content.height > _mask.height)	_scrollbar.show();
			else								_scrollbar.hide();
			
			if (_content.height > _mask.height)
			{
				if ((_content.y + _content.height) < _mask.height)
				{
					var diff:Number = this._mask.height - (this._content.y + this._content.height);
					Tweener.addTween(this._content, { y: this._content.y + diff, time: .5, transition: 'easeOutQuart' } );
				}
				else
				{
					var percentScrolled:Number = (_mask.y - _content.y) / (_content.height - _mask.height);
					_scrollbar.scroll(percentScrolled);
				}
			}
			else if (_content.height < _mask.height && _content.y < _mask.y)
			{
				scroll(0);
				_scrollbar.reset();
			}
		}
		
		function onMouseWheelEvent(event:MouseEvent):void
		{
			if (_content.height > _mask.height )
			{
				var d=event.delta;
				scrollamt(d);
			}
		}
		
		public function get scrollbar():ScrollBar { return _scrollbar; }
		
		public function get content():MovieClip { return _content; }
		
		public function get mask():MovieClip { return _mask; }
	}
}