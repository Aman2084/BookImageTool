///////////////////////////////////////////////////////////
//  MyUtils.as
//  Macromedia ActionScript Implementation of the Class MyUtils
//  Created on:      2018-9-28 下午2:58:50
//  Original author: Aman
///////////////////////////////////////////////////////////

package utils
{
	import com.aman.ui.root.StageLocker;
	
	import mx.managers.CursorManager;
	import mx.managers.ICursorManager;
	
	/**
	 * 本工具专用工具函数
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-28 下午2:58:50
	 */
	public class MyUtils
	{
		public static function buzy():void{
			StageLocker.lock();
			var c:ICursorManager = CursorManager.getInstance();
			c.showCursor();
			c.setBusyCursor();
		}
		
		public static function unBuzy():void{
			StageLocker.unlock();
			var c:ICursorManager = CursorManager.getInstance();
			c.hideCursor();
			c.removeBusyCursor()
		}
	}
}