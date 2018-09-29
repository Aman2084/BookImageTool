///////////////////////////////////////////////////////////
//  FileMover.as
//  Macromedia ActionScript Implementation of the Class FileMover
//  Created on:      2018-9-28 下午4:31:09
//  Original author: Aman
///////////////////////////////////////////////////////////

package sort
{
	import com.aman.event.ZEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	
	/**
	 * 文件移动者
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-28 下午4:31:09
	 */
	public class FileMover extends EventDispatcher
	{
		public var targetDir:File
		private var _sourceFile:File
		private var _targetFile:File
		
		public function FileMover(){
			super();
		}
		
//移动并重命名
		public function renameAndMove($o:VoRename):void{
			_sourceFile = new File($o.url);
			_targetFile = targetDir.resolvePath($o.newName + ".jpg");
			_sourceFile.addEventListener(Event.COMPLETE , onMove);
			_sourceFile.copyToAsync(_targetFile , true);
		}
		
		private function onMove($e:Event):void{
			_sourceFile.removeEventListener(Event.COMPLETE , onMove);
			_sourceFile.addEventListener(Event.COMPLETE , onDelete);
			_sourceFile.deleteFileAsync();
		}	
		
		private function onDelete($e:Event):void{
			_sourceFile.removeEventListener(Event.COMPLETE , onDelete);
			var evt:ZEvent = new ZEvent(ZEvent.Complete , _targetFile);
			this.dispatchEvent(evt);
		}
		
//移动至
		public function moveTo($f:File):void{
			_sourceFile = $f;
			_sourceFile.addEventListener(Event.COMPLETE , onMoveTo);
			var f:File = targetDir.resolvePath(_sourceFile.name);
			_sourceFile.moveToAsync(f , true)
		}
		
		private function onMoveTo($e:Event):void{
			_sourceFile.removeEventListener(Event.COMPLETE , onMoveTo);
			var evt:ZEvent = new ZEvent(ZEvent.Complete , _targetFile);
			this.dispatchEvent(evt);
		}
	}
}