///////////////////////////////////////////////////////////
//  ZEvent.as
//  Macromedia ActionScript Implementation of the Class ZEvent
//  Created on:      2015-7-2 下午8:00:06
//  Original author: Zhangwei
///////////////////////////////////////////////////////////

package utils
{
	import flash.events.Event;
	
	
	/**
	 * 通用事件
	 * @author Zhangwei
	 * @version 1.0
	 * 
	 * @created  2015-7-2 下午8:00:06
	 */
	public class ZEvent extends Event
	{
		public static const SingletonError:String = "singletonError";
		public static const ABSError:String = "absError";
		
		public static const Init:String = "init";
		public static const Add:String = "add";
		public static const Close:String = "close";
		
		public static const Selected:String = "selected";
		public static const Ok:String = "ok";
		public static const Cancel:String = "cancel";
		public static const Success:String = "success";
		public static const Failed:String = "failed";
		public static const Complete:String = "complete";
		public static const Change:String = "change";
		public static const Update:String = "update";
		
		public static const Resize:String = "resize";
		public static const ResizeAtOnce:String = "resizeAtOnce";
		
		public static const Jump:String = "jump";
		public static const Buy:String = "buy";
		public static const Info:String = "info";
		public static const Statistics:String = "statistics";
		
		public static const Shop:String = "shop";
		public static const Cart:String = "cart";
		
		public static const Show:String = "show";
		public static const Hide:String = "hide";
		public static const Enrer:String = "enrer";
		public static const Exit:String = "exit";
		public static const Out:String = "out";
		public static const In:String = "in";
		
		public static const Start:String = "start";
		public static const Stop:String = "stop";
		public static const Pause:String = "pause";
		public static const Resart:String = "resart";
		public static const Resume:String = "resume";
		public static const Play:String = "play";
		public static const DownLoad:String = "downLoad";
		
		public static const IOError:String = "ioError";
		
		public static const ItemDoubleClick:String = "itemDoubleClick";
		
		public var data:Object;
		public var action:String;
		
		public function ZEvent($type:String, $data:Object=null , $bubbles:Boolean=false , $action:String=""){
			super($type, $bubbles);
			data = $data;
			action = $action;
		}
		
	}
}