///////////////////////////////////////////////////////////
//  SMoveMode.as
//  Macromedia ActionScript Implementation of the Class SMoveMode
//  Created on:      2019-3-23 下午3:04:55
//  Original author: Administrator
///////////////////////////////////////////////////////////

package smove
{
	import com.aman.event.ZEvent;
	import com.aman.utils.Utils;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	
	/**
	 * 
	 * @author Administrator
	 * @version 1.0
	 * 
	 * @created  2019-3-23 下午3:04:55
	 */
	public class SMoveMode extends EventDispatcher
	{
		private var _url:String;
		private var _data:Array;
		private var _index:int;
		public function SMoveMode(target:IEventDispatcher=null){
			super(target);
		}
		
		
//interface
		public function removeThis():void{
			_data.splice(_index , 1);
			updata();
		}
		
		public function next():void{
			_index++;
			if(_index>=num){
				_index = 0;
			}
			updata();
		}
		
		public function prev():void{
			_index--;
			if(_index<0){
				_index = num-1;
			}
			updata();
		}
			
		
		public function setData($data:String):void{
			_url = $data;
			var f:File = new File($data);
			var a:Array = f.getDirectoryListing();
			a.sortOn("name")
			for (var i:int = 0; i < a.length; i++){
				f = a[i];
				if(f.isDirectory || !Utils.isImage(f.extension)){
					a.splice(i , 1);
					i--;
				}
			}
			_data = a;
			_index = 0;
		}
		
		public function updata():void{
			var f:File = _data[_index]
			var e:ZEvent = new ZEvent(ZEvent.Change , f.nativePath);
			this.dispatchEvent(e);
		}
		
		
//getter and setter
		public function get index():int{
			return _index;
		}
		public function get num():int{
			return _data.length;
		}
		
	}
}