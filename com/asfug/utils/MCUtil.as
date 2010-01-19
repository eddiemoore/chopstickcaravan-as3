package com.asfug.utils
{
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	
	/**
	 * Utilities for MovieClips
	 * @author Ed Moore
	 */
	public class MCUtil 
	{
		/**
		 * Adds script at frame given frame label
		 * @param	mc			Movie Clip to add script to
		 * @param	frameLabel	Frame label to add script to
		 * @param	func		Function to add to frame
		 */
		public static function addFrameAction(mc:MovieClip, frameLabel:String, func:Function):void
		{
			for (var i:int = 0; i < mc.currentLabels.length; i++) 
			{
				if (mc.currentLabels[i].name == frameLabel)
					mc.addFrameScript(mc.currentLabels[i].frame-1, func);
			}
		}
		/**
		 * check whether the movieclip has a perticular frame 
		 * @param	mc					movieclip to check
		 * @param	labelName		label name ( frame name, as normally called )
		 * @return								whether the frame is found in the button movieclip
		 */
		public static function hasLabel(mc:MovieClip, labelName:String):Boolean 
		{
			var labels:Array = mc.currentLabels;
			for (var i:int = 0; i < labels.length; i++) {
				var la:FrameLabel = labels[i] as FrameLabel;
				if (la.name == labelName) {
					return true;
				}
			}
			return false;
		}
		/**
		 * Remove all children in a DisplayObjectContainer
		 * @param	mc
		 */
		public static function removeAllChildren(doc:DisplayObjectContainer):void
		{
			while (doc.numChildren > 0)	doc.removeChildAt(0);
		}
	}
	
}