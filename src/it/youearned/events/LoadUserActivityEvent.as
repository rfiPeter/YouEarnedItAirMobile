package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	public final class LoadUserActivityEvent extends BaseEvent
	{
		public static const LOAD_USER_ACTIVITY:String = "it.youearned.events.loadUserActivity";
		public var user_id:int;
		public function LoadUserActivityEvent(user_id:int)
		{
			super(LOAD_USER_ACTIVITY);
			this.user_id = user_id;
		}
	}
}