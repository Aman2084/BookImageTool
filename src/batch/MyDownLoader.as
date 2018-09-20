///////////////////////////////////////////////////////////
//  MyDownLoader.as
//  Macromedia ActionScript Implementation of the Class MyDownLoader
//  Created on:      2018-4-9 下午5:09:14
//  Original author: Aman
///////////////////////////////////////////////////////////

package batch
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	
	
	/**
	 * 批量下载器
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-4-9 下午5:09:14
	 */
	public class MyDownLoader extends EventDispatcher
	{
		//本地基地址
		public var address:String;
		//本地保存文件夹
		private var _file_address:File;
		
		private var _arr_urls:Array;
		private var _index:int;
		private var _extensionName:String;
		
		private var _loader:URLLoader
		private var _stream:FileStream;
		
		public function MyDownLoader($address:String){
			super();
			_stream = new FileStream();
			address = $address;
			_loader = new URLLoader();
			
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			_loader.addEventListener(Event.COMPLETE , onLoad);
			_loader.addEventListener(IOErrorEvent.IO_ERROR , onLoad);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR , onLoad); 
		}
		
		public function down($folder:String , $urls:Array):Boolean{
			var b:Boolean = false;
			
			_file_address = new File(address);
			if($folder){
				_file_address = _file_address.resolvePath($folder);				
			}
			
			if(!_file_address.exists){
				b = true;
				_file_address.createDirectory();
				_arr_urls = $urls;
				_index = 0;
				load();
			}
			return b;
		}
		
		private function load():void{
			if(_index==_arr_urls.length){
				var evt:Event = new Event(Event.COMPLETE)
				dispatchEvent(evt);
				return
			}
			
			var s:String = _arr_urls[_index]
			var a:Array = s.split(".");
			_extensionName = a.pop();
			var r:URLRequest = new URLRequest(s);
			_loader.load(r);
		}
		
		private function onLoad($e:Event):void{
			var s:String = _index<10 ? "0"+_index : _index.toString();
			s = s + "." + _extensionName;
			var f:File = _file_address.resolvePath(s);
			_stream.open(f , FileMode.WRITE);
			var b:ByteArray =  _loader.data as ByteArray;
			_stream.writeBytes(b);
			_stream.close();
			b.clear();
			
			_index++;
			var evt:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS , false , false , _index , _arr_urls.length);
			dispatchEvent(evt);
			load();
		}
		
		
		public function get num():int{
			var i:int = _arr_urls.length;
			return i;
		}
		
		public function get localDirectory():File{
			return _file_address;
		}
	}
}