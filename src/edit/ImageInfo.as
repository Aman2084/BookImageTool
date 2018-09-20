///////////////////////////////////////////////////////////
//  ImageInfo.as
//  Macromedia ActionScript Implementation of the Class ImageInfo
//  Created on:      2018-4-19 下午8:50:47
//  Original author: Aman
///////////////////////////////////////////////////////////

package edit
{
	import flash.filesystem.File;
	
	/**
	 * 图片信息
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-4-19 下午8:50:47
	 */
	public class ImageInfo
	{
		public var path:String;
		public var num:int;
		
		public function ImageInfo($f:File){
			path = $f.nativePath;
			var s:String = $f.name.replace($f.type , "");
			num = int(s)
		}
	}
}