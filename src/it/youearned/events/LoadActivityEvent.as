package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	public final class LoadActivityEvent extends BaseEvent
	{
		public static const LOAD_ACTIVITY:String = "it.youearned.events.loadActivity";
		public var size:Object;
		public function LoadActivityEvent(size:Object="60")
		{
			super(LOAD_ACTIVITY);
			this.size = size;
		}
	}
}