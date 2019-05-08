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
		
		public function ImageSizeInfo($b:BitmapData=null){
			if($b){
				setSize($b.width , $b.height);
			}
		}
		
		public function setSize($w:int , $h:int):void{
			width = $w;
			height = $h;
			name = $w + "X" + $h;
		}
		
		public function getHalf():ImageSizeInfo{
			var o:ImageSizeInfo = new ImageSizeInfo();
			o.setSize(this.width/2 , this.height);
			return o;
		}
		
		public function get size():int{
			return width * height;
		}
	}
}