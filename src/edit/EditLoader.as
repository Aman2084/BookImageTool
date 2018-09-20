///////////////////////////////////////////////////////////
//  EditLoader.as
//  Macromedia ActionScript Implementation of the Class EditLoader
//  Created on:      2018-4-19 下午8:09:58
//  Original author: Aman
///////////////////////////////////////////////////////////

package edit
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	
	/**
	 * 图片扫描器，用于获取图片的尺寸、名称等相关信息
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-4-19 下午8:09:58
	 */
	public class EditLoader extends Loader
	{
		private var _arr_types:Array = [".jpg" , ".jpeg" , ".png" , ".bmp"]
		private var _arr:Array;
		private var _lastFile:File;
		private var _obj_size:Object;
		private var _arr_info:Array;
		
		public function EditLoader(){
			super();
			_obj_size = new Object();
			this.contentLoaderInfo.addEventListener(Event.COMPLETE , onLoad);
			this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR , onError);
		}
		
		public function startLoad($a:Array):void{
			_arr = $a;
			_obj_size = new Object();
			_arr_info = new Array();
			loadImage();
		}
			
		private function loadImage():void{
			if(_arr.length==0){
				var e:Event = new Event(Event.COMPLETE);
				this.dispatchEvent(e);
				return
			}
			var file:File = _arr.shift() as File;
			var s:String = file.type.toLocaleLowerCase()
			var b:Boolean = _arr_types.indexOf(s)>-1;
			if(b){
				_lastFile = file;
				var r:URLRequest = new URLRequest(file.nativePath);
				load(r);
			}
		}
		
		private function onError($e:Event):void{
			loadImage();
		}
		
		private function onLoad($e:Event=null):void{
			var b:Bitmap = this.content as Bitmap;
			var d:BitmapData = b.bitmapData;
			var o:ImageSizeInfo = new ImageSizeInfo(d);
			if(!_obj_size.hasOwnProperty(o.name)){
				_obj_size[o.name] = o;
			}
			
			var info:ImageInfo = new ImageInfo(_lastFile);
			_arr_info.push(info);
			
			d.dispose();
			unload();
			loadImage();
		}
		
		public function get size():Array{
			var a:Array = new Array();
			for each (var s:ImageSizeInfo in _obj_size){
				a.push(s);
			}
			a.sortOn("size" ,Array.NUMERIC);
			return a;
		}
		
		public function get info():Array{
			var a:Array = _arr_info.concat();
			return a;
		}
	}
}