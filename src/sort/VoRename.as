///////////////////////////////////////////////////////////
//  VoRename.as
//  Macromedia ActionScript Implementation of the Class VoRename
//  Created on:      2018-9-28 下午3:10:41
//  Original author: Aman
///////////////////////////////////////////////////////////

package sort
{
	
	/**
	 * 重命名用VO
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-28 下午3:10:41
	 */
	public class VoRename
	{
		public var url:String;
		public var newName:String;
		
		public function VoRename($url:String , $newName:String){
			newName = $newName
			url = $url;
		}
	}
}