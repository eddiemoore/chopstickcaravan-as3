
package com.asfug.utils {

	/**
	 * @author Shang Liang
	 */
	public class NumberUtil {
		/**
		 * generate a random number tween min value and max value
		 * @see 	#randomInt()	randomInt function
		 * @param	min				minumum number
		 * @param	max				maximum number
		 * @return					a random number between min and max
		 */
		public static function random(min:Number,max:Number):Number {
			var range:Number=max-min;
			return min+Math.random()*range;
		}
		/**
		 * generate a random integer tween min value and max value
		 * @see 	#random()		random function
		 * @param	min				minumum number
		 * @param	max				maximum number
		 * @return					a random integer between min and max
		 */
		public static function randomInt(min:Number,max:Number):int {
			return Math.floor(random(min,max));
		}
		/**
		 * generate an array of sequential number, but randomly shuffled
		 * @param	min				minimum number
		 * @param	max				maximum number
		 * @return					shuffled array of sequential number
		 */
		public static function randomSequence(min:int,max:int):Array {
			var arr:Array = new Array();
			var len:int = max - min;
			var i:int = 0;
			for (i = 0; i < len; i++) {
				arr[i] = min+i;
			}
			for (i = 0; i < len*2; i++) {
				var temp:int = arr[i%len] as int;
				var p:int = randomInt(0, len-1);
				arr[i%len] = arr[p];
				arr[p] = temp;
			}
			return arr;
		}
		/**
		 * normalizes a number from another range into a value between 0 and 1
		 * @see 	#map()			map function
		 * @param	value			value to be normalized
		 * @param	min				minimum value in value's current range
		 * @param	max				maximum value in value's current range
		 * @return					normalized value
		 */
		public static function normalize(value:Number, min:Number, max:Number):Number{
            return (value - min) / (max - min);
        }
		/**
		 * linear interpolate a fraction between 2 values
		 * @param	#normValue()	normalized value
		 * @param	min				minimum value in target range
		 * @param	max				maximum value in target range
		 * @return					linearly interpolated value
		 */
        public static function interpolate(normValue:Number, min:Number, max:Number):Number {
            return min + (max - min) * normValue;
		}
		/**
		 * map a value from one range to another range
		 * @see 	#normalize()	normailze function
		 * @param	value			value to be mapped
		 * @param	min1			minimum value in value's current range
		 * @param	max1			maximum value in value's current range
		 * @param	min2			minimum value in target range
		 * @param	max2			maximum value in target range
		 * @return					mapped value
		 */
        public static function map(value:Number, min1:Number, max1:Number, min2:Number, max2:Number):Number {
            return interpolate( normalize(value, min1, max1), min2, max2);
		}
	}
	
}
