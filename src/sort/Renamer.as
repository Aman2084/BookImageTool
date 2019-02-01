///////////////////////////////////////////////////////////
//  Renamer.as
//  Macromedia ActionScript Implementation of the Class Renamer
//  Created on:      2018-9-28 下午3:30:07
//  Original author: Aman
///////////////////////////////////////////////////////////

package sort
{
	import com.aman.event.ZEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	
	/**
	 * 
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-28 下午3:30:07
	 */
	public class Renamer extends EventDispatcher
	{
		private var _file_source:File;
		private var _file_temp:File;
		private var _mover:FileMover;
		private var _arr_remame:Array;
		private var _arr_moveBack:Array;
		
		public function Renamer(){
			super();
			_arr_moveBack = new Array();
			_mover = new FileMover();
		}
		
//delete
		private function deleteImgs($a:Array):void{
			for (var i:int = 0; i < $a.length; i++){
				var f:File = new File($a[i]);
				f.moveToTrashAsync();
			}
		}
		
//rename
		private function renameImgs($a:Array):void{
			if($a.length==0){
				return
			}
			var o:VoRename = $a[0]
			var f:File = new File(o.url);
			_file_source = f.parent;
			_arr_remame = $a;
			_file_temp = File.createTempDirectory();
			_mover.targetDir = _file_temp
			_mover.addEventListener(ZEvent.Complete , onRenameAndMove);
			onRenameAndMove()
		}
		
		//重命名后移入临时文件夹
		private function onRenameAndMove($e:ZEvent=null):void{
			if($e){
				_arr_moveBack.push($e.data);
			}
			if(!_arr_remame.length){
				_mover.removeEventListener(ZEvent.Complete , onRenameAndMove);
				_mover.addEventListener(ZEvent.Complete , onMoveBack);
				_mover.targetDir = _file_source;
				onMoveBack();
				return
			}
			var o:VoRename = _arr_remame.shift();
			_mover.renameAndMove(o);
		}
		
		//从临时文件夹移动回源文件夹
		private function onMoveBack($e:ZEvent=null):void{
			if(!_arr_moveBack.length){
				_mover.removeEventListener(ZEvent.Complete , onMoveBack);
				_file_temp.addEventListener(Event.COMPLETE , onTemp)
				_file_temp.deleteDirectoryAsync(true);
				return
			}
			var f:File = _arr_moveBack.shift();
			_mover.moveTo(f);
		}
		
		private function onTemp($e:Event):void{
			_file_temp.removeEventListener(Event.COMPLETE , onTemp)
			var evt:ZEvent = new ZEvent(ZEvent.Complete)
			this.dispatchEvent(evt)
		}
		
//instance
		public function rename($delete:Array , $rename:Array):void{
			deleteImgs($delete);
			renameImgs($rename);
		}
	}
}