///////////////////////////////////////////////////////////
//  SortModel.as
//  Macromedia ActionScript Implementation of the Class SortModel
//  Created on:      2019-3-22 下午9:58:16
//  Original author: Administrator
///////////////////////////////////////////////////////////

package sort
{
	import com.aman.utils.Utils;
	
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	
	/**
	 * 批量移动Model
	 * @author Administrator
	 * @version 1.0
	 * 
	 * @created  2019-3-22 下午9:58:16
	 */
	public class SortModel extends EventDispatcher
	{
		public var url_src:String;
		public var url_target:String;
		private var _index:int;
		
		public function SortModel(){
			super();
		}
		
//interface
		public function getFiles():Array{
			if(!url_src){
				return null;
			}
			var f:File = new File(url_src)
			if(!f.exists){
				return null;
			}
			var a:Array = f.getDirectoryListing();
			
			for (var i:int = 0; i < a.length; i++){
				f = a[i];
				if(f.isDirectory || !Utils.isImage(f.extension)){
					a.splice(i , 1);
					i--;
				}
			}
			return a;
		}
		
		
		public function next():void{
			//TODO...
		}
		
		
		
	}
}