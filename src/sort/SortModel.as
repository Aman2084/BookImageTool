///////////////////////////////////////////////////////////
//  SortModel.as
//  Macromedia ActionScript Implementation of the Class SortModel
//  Created on:      2019-3-22 下午9:58:16
//  Original author: Administrator
///////////////////////////////////////////////////////////

package sort
{
	import com.aman.event.ZEvent;
	import com.aman.utils.Utils;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	import utils.ToolsValues;
	
	
	/**
	 * 批量移动Model
	 * @author Administrator
	 * @version 1.0
	 * 
	 * @created  2019-3-22 下午9:58:16
	 */
	public class SortModel extends EventDispatcher
	{
		
		public var moved:Boolean = false;
		[Bindable]
		public var url_srcBase:String = ToolsValues.Sort_BaseUrl;
		[Bindable]
		public var url_src:String;
		[Bindable]
		public var url_targetBase:String = ToolsValues.Sort_TargetUrl;
		[Bindable]
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
		
//move 
		public function move():void{
			if(this.moved){
				return
			}
			if(!url_srcBase || !url_src || !url_targetBase){
				return
			}
			var s:String = this.url_src.replace(this.url_srcBase , "");
			s = this.url_targetBase + s;
			url_target = s;
			
			var f:File = new File(url_src);
			var ft:File = new File(url_target);
			f.addEventListener(Event.COMPLETE , onMoved);
			f.moveToAsync(ft , true);
		}
		
		private function onMoved($e:Event):void{
			this.moved = true;
			var e:ZEvent = new ZEvent(ZEvent.Move);
			this.dispatchEvent(e);
		}		
		
		public function next():Boolean{
			var b:Boolean = false;
			if(this.url_src){
				var f:File = new File(url_src);
				var p:File = f.parent;
				var a:Array = p.getDirectoryListing();
				a.sortOn("name");
				var s:String = "";
				for (var i:int = 0; i < a.length; i++){
					var r:File = a[i];
					if(!r.isDirectory){
						continue
					}
					if(r.name==f.name){
						if(i<a.length-1){
							r = a[i+1]
						}else{
							r= a[0]
						}
						s =r.nativePath;
						break
					}
				}
				
				if(s && s!=this.url_src) {
					this.url_src = s
					b = true
				}
			}
			return b
		}


	}
}