///////////////////////////////////////////////////////////
//  UrlModel.as
//  Macromedia ActionScript Implementation of the Class UrlModel
//  Created on:      2018-4-10 下午7:03:34
//  Original author: Aman
///////////////////////////////////////////////////////////

package utils
{
	
	/**
	 * 远程网址信息解析类
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-4-10 下午7:03:34
	 */
	public class UrlModel
	{
		public var folderName:String;
		public var arr_urls:Array = new Array();
		
		
		public function set url($value:String):void{
			
			var s:String = $value;
			var a:Array = s.split("/");
			var arr:Array = a.slice(0 , -1);
			
			var fileName:String = a[a.length-1];
			
			//文件夹名
			folderName = "";
			var n:int = Math.min(3 , arr.length);
			for (var i:int = 1; i <= n; i++){
				var j:int = arr.length - i;
				var str:String = arr[j];
				if(str.length>folderName.length){
					folderName = str;
				}
			}
			folderName = folderName;
			
			//图片地址列表
			var a_img:Array =  new Array();
			var a_name:Array = fileName.split(".");
			var s1:String = arr.join("/") + "/";
			var s2:String = a_name[1];
			n = int(a_name[0]);
			for (i=0 ; i<=n ; i++){
				var s3:String = s1 + i.toString() + "." + s2;
				a_img.push(s3);
			}
			arr_urls = a_img;
		}
		
		public function get numImages():int{
			return arr_urls.length;
		}
		
		public function get hasImage():Boolean{
			return arr_urls.length>0;
		}
	}
}