///////////////////////////////////////////////////////////
//  ImageSizeInfo.as
//  Macromedia ActionScript Implementation of the Class ImageSizeInfo
//  Created on:      2018-4-19 下午8:50:59
//  Original author: Aman
///////////////////////////////////////////////////////////

package edit
{
	import flash.display.BitmapData;
	
	/**
	 * 
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-4-19 下午8:50:59
	 */
	public class ImageSizeInfo
	{
		public var width:int;
		public var height:int;
		public var name:String;
		
		public function ImageSizeInfo($b:BitmapData){
			width = $b.width;
			height = $b.height;
			name = $b.width + "X" + $b.height;
		}
		
		
		public function get size():int{
			return width * height;
		}
	}
}