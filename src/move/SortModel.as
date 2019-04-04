///////////////////////////////////////////////////////////
//  SortModel.as
//  Macromedia ActionScript Implementation of the Class SortModel
//  Created on:      2019-3-22 下午9:58:16
//  Original author: Administrator
///////////////////////////////////////////////////////////

package move
{
	import com.aman.utils.Utils;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
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
		private var _url_root:String;
		private var _index:int;
		private var _data:Array;
		
		public function SortModel(target:IEventDispatcher=null){
			super(target);
		}
		
		public function setData($data:String):void{
			_url_root = $data;
			var f:File = new File($data);
			var a:Array = f.getDirectoryListing();
			var arr:Array = new Array();
			for (var i:int = 0; i < a.length; i++){
				f = a[i]
				if(f.isDirectory){
					arr.push(f);
				}
			}
			arr.sortOn("name");
			_data = arr;
			_index = 0;
		}
		
		
//interface
		public function deleteCurrect():void{
			_data.splice(_index , 1);
		}
		
		public function next():void{
			_index++;
			if(_data && _index>=_data.length){
				_index = 0;
			}
		}
		
//get Files
		public function get files_currect():Array{
			return getFilesAt(_index);
		}
		
		public function get files_frist():Array{
			return getFilesAt(0);
		}
		
		public function get url_frist():String{
			return getUrlAt(0);
		}
		
		public function get url_currect():String{
			return getUrlAt(_index)
		}
		
		private function getFilesAt($index:int):Array{
			if(!_data || _data.length<=$index){
				return null;
			}
			var f:File = _data[$index] as File
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
		
		private function getUrlAt($index:int):String{
			if(!_data || _data.length<=$index){
				return null;
			}
			var f:File = _data[$index] as File;
			return f.nativePath;
		}
		
		public function get data():Array{
			return _data;
		}
		
		public function get index():int{
			return _index;
		}
		public function get num():int{
			return _data.length;
		}
	}
}