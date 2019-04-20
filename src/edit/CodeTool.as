///////////////////////////////////////////////////////////
//  CodeTool.as
//  Macromedia ActionScript Implementation of the Class CodeTool
//  Created on:      2019-4-20 下午6:20:23
//  Original author: Administrator
///////////////////////////////////////////////////////////

package edit
{
	import com.aman.utils.Utils;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	
	import utils.ToolsValues;
	
	
	/**
	 * 代码管理器
	 * @author Administrator
	 * @version 1.0
	 * 
	 * @created  2019-4-20 下午6:20:23
	 */
	public class CodeTool{
		
		public var url_src:String;
		public var url_target:String = ToolsValues.Edit_CodeUrl;
		private var _arr_imgs:Array;
		private var _stream:FileStream = new FileStream();
		
		public function saveCode($s:ImageSizeInfo):void{
			var str:String = "";
			if(!url_src){
				str = "请设置图片文件夹！"
			}else if(!url_target){
				str = "请设置代码文件夹"
			}
			
			if(str){
				Alert.show(str);
			}
			
			str = creatCode($s)
			saveFile(str);
		}
		
//代码存储部分
		private function saveFile($s:String):void{
			var s:String = "com/myAlbum/AlbumSource.as"
			var f:File = new File(url_target);
			f = f.resolvePath(s);
			
			_stream.open(f , FileMode.WRITE);
			var b:ByteArray = new ByteArray();
			s = $s;
			b.writeMultiByte(s , "utf-8")
			_stream.writeBytes(b);
			_stream.close();
		}
		
//代码生成部分
		private function creatCode($s:ImageSizeInfo):String{
			creatImgInfo()
			
			var a1:Array = [
				"",
				"public static const xml:XML = " + this.code_xml($s) + ";",
				""
			];
			var a2:Array = code_embed();
			var a:Array = a1.concat(a2);	
			
			this.pick(a , "public class AlbumSource");
			this.pick(a , "package com.myAlbum");
			var str:String = a.join("\n")
			return str
		}
		
		private function creatImgInfo():void{
			var f:File = new File(this.url_src);
			var a:Array = f.getDirectoryListing();
			a.sortOn("name");
			var arr:Array = new Array();
			for (var k:int = a.length-1; k>-1; k--){
				f = a[k];
				if(!Utils.isImage(f.extension)){
					a.splice(k , 1);
				}else{
					var o:ImageInfo = new ImageInfo(f);
					arr.unshift(o);
				}
			}
			this._arr_imgs = arr;
		}
		
		private function code_xml($s:ImageSizeInfo):String{
			var a:Array = this._arr_imgs
			var xml:XML = <book/>
			xml.@width = $s.width;
			xml.@height = $s.height;
			
			for (var i:int = 0; i < a.length; i++){
				var o1:ImageInfo = a[i];
				var j:int = i+1;
				var isSimplePage:Boolean = i==0 || j==a.length;
				if(!isSimplePage){
					var o2:ImageInfo = a[j];
					isSimplePage = o2.num==(o1.num+1);
				}
				var xx:XML = <page/>;
				xx.@img = o1.num;
				xx.@direction = "whole";
				xml.appendChild(xx);
				if(!isSimplePage){
					xx.@direction = "left";
					xx = xx.copy();
					xx.@direction = "right";
					xml.appendChild(xx);
				}
			}
			return xml.toString();
		}
		
		
		private function code_embed():Array{
			var a:Array = _arr_imgs;
			var arr:Array = new Array
			for (var i:int = 0; i < a.length; i++) {
				var o:ImageInfo = a[i];
				
				var p:String = o.path.replace(/\\/g , "/");
				var s:String = '[Embed(source="' + p +'")]' 
				arr.push(s);
				s = "public static var IMG" + o.num.toString() + ":Class";
				arr.push(s);
				arr.push("");
			}
			return arr;
		}
		
		private function pick($a:Array , $s:String):void{
			for (var i:int = 0; i < $a.length; i++){
				$a[i] = "	" + $a[i];
			}
			$a.unshift($s+"{");
			$a.push("}")
		}
	}
}