package com.adobe.khoyt.parse.events
{
	import flash.events.Event;
	
	public class ParseEvent extends Event
	{
		public static const COUNT:String = "parseCount";
		public static const CREATE:String = "parseCreate";
		public static const READ:String = "parseRead";
		public static const REMOVE:String = "parseRemove";
		public static const SEARCH:String = "parseSearch";
		public static const UPDATE:String = "parseUpdate";		
		
		public var value:Object = null;
		
		public function ParseEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
		override public function clone():Event
		{
			return new ParseEvent( type, bubbles, cancelable );
		}
	}
}