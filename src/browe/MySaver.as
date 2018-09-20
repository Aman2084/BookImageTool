///////////////////////////////////////////////////////////
//  MySaver.as
//  Macromedia ActionScript Implementation of the Class MySaver
//  Created on:      2018-5-14 下午5:37:53
//  Original author: Aman
///////////////////////////////////////////////////////////

package browe
{
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.graphics.codec.JPEGEncoder;
	
	import utils.ZEvent;
	
	/**
	 * 
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-5-14 下午5:37:53
	 */
	public class MySaver extends EventDispatcher{
		
		public var doing:Boolean = false;
		private var _index:int;
		private var _arr_bmd:Array;
		//本地保存文件夹
		private var _file_address:File;
		private var _encoder:JPEGEncoder = new JPEGEncoder()
		private var _stream:FileStream = new FileStream();
		private var _file_single:File;
		private var _bmd_single:BitmapData;
		
		public function MySaver(){
			super(null);
		}
		
		private function onAlert($e:CloseEvent):void{
			var d:EventDispatcher = $e.currentTarget as EventDispatcher;
			d.removeEventListener($e.type , onAlert);
			switch($e.detail){
				case Alert.NO:
					_file_address.openWithDefaultApplication();
					break
				case Alert.YES:
					doing = true;
					saveNext();
					return
			}
			end();
		}
		
		public function save($src:Array , $adress:String):void{
			_file_address = new File($adress);
			_arr_bmd = $src;
			if(_file_address.exists){
				Alert.yesLabel = "仍然下载"
				Alert.noLabel = "查看"
				Alert.show("文件夹已存在！" ,"" , Alert.OK|Alert.NO|Alert.YES , null, onAlert);
				return
			}
			
			doing = true;
			_index = 0;
			saveNext();
		}
		
		private function saveNext():void{
			if(!_arr_bmd || _arr_bmd.length<1){
				end();
				return;
			}
			
			var s:String = _index<10 ? "0"+_index : _index.toString();
			s += ".jpg";
			var f:File = _file_address.resolvePath(s);
			
			var b:ByteArray = _encoder.encode(_arr_bmd.shift());
			_stream.open(f , FileMode.WRITE);
			_stream.writeBytes(b);
			_stream.close();
			b.clear();
			_index ++;
			setTimeout(saveNext , 50);
		}
		
		private function end():void{
			doing = false;
			var evt:ZEvent = new ZEvent(ZEvent.Complete);
			this.dispatchEvent(evt);
		}
		
		public function saveSingle($f:File, $b:BitmapData):void{
			if($f.exists){
				_file_single = $f;
				_bmd_single = $b;
				
				Alert.yesLabel = "仍然下载"
				Alert.noLabel = "查看"
				Alert.show("文件夹已存在！" ,"" , Alert.OK|Alert.NO|Alert.YES , null, onSingleAlert);
				return
			}
			saveSingleImage($f , $b);
		}
		
		private function onSingleAlert($e:CloseEvent):void{
			var d:EventDispatcher = $e.currentTarget as EventDispatcher;
			d.removeEventListener($e.type , onAlert);
			switch($e.detail){
				case Alert.NO:
					_file_address.openWithDefaultApplication();
					break
				case Alert.YES:
					saveSingleImage(_file_single , _bmd_single);
					break
			}
		}
		
		private function saveSingleImage($f:File, $b:BitmapData):void{
			var b:ByteArray = _encoder.encode($b);
			_stream.open($f , FileMode.WRITE);
			_stream.writeBytes(b);
			_stream.close();
			b.clear();
		}
		
		
	}
}