///////////////////////////////////////////////////////////
//  BorweButton.as
//  Macromedia ActionScript Implementation of the Class BorweButton
//  Created on:      2019-3-18 上午12:43:27
//  Original author: Administrator
///////////////////////////////////////////////////////////

package com
{
	import com.aman.event.ZEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	import spark.components.Button;
	
	import utils.ToolsValues;
	
	
	/**
	 * 文件夹选择Button
	 * @author Administrator
	 * @version 1.0
	 * 
	 * @created  2019-3-18 上午12:43:27
	 */
	public class BrowseButton extends Button
	{
		private var _file:File = new File(ToolsValues.TargeterUrl);
		
		public function BrowseButton()
		{
			super();
			this.label = "浏览";
			this.addEventListener(MouseEvent.CLICK , onClick);
		}
		
		private function onClick($e:MouseEvent):void{
			var str:String = this.label + "——请选取文件夹";
			_file.browseForDirectory(str);
			_file.addEventListener(Event.SELECT , onFile);
		}
		
		private function onFile($e:Event=null):void{
			var evt:ZEvent = new ZEvent(ZEvent.Selected , url);
			this.dispatchEvent(evt);
		}
		
		public function get url():String{
			return _file.nativePath;
		}
	}
}