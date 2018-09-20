///////////////////////////////////////////////////////////
//  BrowList.as
//  Macromedia ActionScript Implementation of the Class BrowList
//  Created on:      2018-4-25 下午6:23:18
//  Original author: Aman
///////////////////////////////////////////////////////////

package browe
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	
	import mx.containers.Canvas;
	import mx.core.ScrollPolicy;
	import mx.events.ResizeEvent;
	
	import utils.UrlModel;
	import utils.ZEvent;
	
	/**
	 * 图片列表
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-4-25 下午6:23:18
	 */
	public class BrowList extends Canvas{
		
		private var _urls:Array = new Array();
		
		private var _mode:UrlModel = new UrlModel();
		
		private var _scrollTop:Number = 0;
		private var _scrollY:Number = 0;
		private var _mouseY:Number = 0;
		
		public function BrowList(){
			super();
			this.horizontalScrollPolicy = ScrollPolicy.OFF;
			this.verticalScrollPolicy = ScrollPolicy.OFF;
		}
		
		override protected function childrenCreated():void{
			super.createChildren()
			this.addEventListener(ResizeEvent.RESIZE , onResize);
			this.addEventListener(MouseEvent.MOUSE_DOWN , onDown);
		}
		
		
		private function onDown($e:MouseEvent):void{
			if($e.target!=this){
				return
			}
			if(_scrollTop==0){
				return
			}
			_mouseY = this.mouseY;
			stage.addEventListener(MouseEvent.MOUSE_MOVE , onMove);
			stage.addEventListener(MouseEvent.MOUSE_UP , onUp);
		}
		
		private function onMove($e:MouseEvent):void{
			var ypos:Number = this.mouseY - _mouseY;
			_mouseY = this.mouseY;
			ypos = _scrollY + ypos;
			
			ypos = Math.max(_scrollTop , ypos);
			ypos = Math.min(ypos , 0);
			if(ypos==_scrollY){
				return
			}
			_scrollY = ypos;
			
			for (var i:int = 0; i < this.numChildren; i++){
				var item:BrowListItem = this.getChildAt(i) as BrowListItem;
				item.y = item.yos + _scrollY;
			}
		}		
		
		private function onUp($e:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE , onMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP , onUp);
		}
		
		private function load():void{
			if(!_urls.length){
				var evt:ZEvent = new ZEvent(Event.COMPLETE)
				dispatchEvent(evt);
				return
			}
			var item:BrowListItem = new BrowListItem();
			item.width = BrowListItem.W;
			item.height = BrowListItem.H;
			item.name = this.numChildren.toString();
			item.load(_urls.shift());
			item.addEventListener(IOErrorEvent.IO_ERROR , onLoad);
			item.addEventListener(Event.COMPLETE , onLoad);
			this.addChild(item);
			onResize();
		}
		
		private function onLoad($e:Event):void{
			var item:BrowListItem = $e.currentTarget as BrowListItem;
			item.removeEventListener(IOErrorEvent.IO_ERROR , onLoad);
			item.removeEventListener(Event.COMPLETE , onLoad);
			load();
		}
		
		public function onResize($e:ResizeEvent=null):void{
			if(this.numChildren<1){
				return
			}
			
			var w:Number = this.width;
			var gap:Number = 10;
			var w1:Number = w - gap*2;
			var w2:Number = 0;
			var n:int = 0;
			while((w2 += BrowListItem.W + gap)<=w1){
				n++;
			}
			if(n<1){
				return;
			}
			w2 = (w - BrowListItem.W*n - gap*(n-1)) / 2;
			var a:Array = this.getChildren().concat();
			var n1:int = Math.ceil(a.length / n);
			var ypos:Number = gap / 2;
			for (var i:int = 0; i < n1; i++){
				var xpos:Number = w2;
				for (var j:int = 0; j < n; j++){
					if(a.length<1){
						break;
					}
					var c:BrowListItem = a.shift() as BrowListItem;
					c.x = xpos;
					c.y = c.yos =ypos;
					xpos += (BrowListItem.W + gap);
				}
				ypos += BrowListItem.H+gap;
			}
			
			if(ypos>this.height){
				_scrollTop = this.height - ypos;
			}else{
				_scrollTop = 0;
			}
			_scrollY = 0;
		}
		
		public function setData($url:String):void{
			clear();
			_mode.url = $url;
			_urls = _mode.arr_urls.concat();
			load();
		}
		
		public function clear():void{
			while(this.numChildren){
				var item:BrowListItem = this.getChildAt(0) as BrowListItem;
				item.unLoad();
				this.removeChildAt(0);
			}
		}
		
		public function getBmd():Array{
			var a:Array = new Array();
			var arr:Array = this.getChildren();
			for (var i:int = 0; i < arr.length; i++){
				var item:BrowListItem = arr[i];
				var bmd:BitmapData = item.img.bitmapData;
				if(bmd){
					a.push(bmd);					
				}
			}
			return a;
		}
		
		public function get folderName():String{
			return _mode.folderName;
		}
	}
}