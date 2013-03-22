package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	public final class UpdateViewEvent extends BaseEvent
	{
		public static const PUSH_VIEW:String = "it.youearned.events.pushView";
		public static const POP_VIEW:String = "it.youearned.events.popView";
		public static const REPLACE_VIEW:String = "it.youearned.events.replaceView";
		
		public var newView:Class;
		public var data:Object;
		public var transition:Object;
		
		public function UpdateViewEvent(type:String, newView:Class = null, data:Object = null, transition:Object = null)
		{
			super(type);
			
			this.newView = newView;
			this.data = data;
			this.transition = transition;
		}
	}
}