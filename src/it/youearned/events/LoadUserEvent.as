package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	public final class LoadUserEvent extends BaseEvent
	{
		public static const LOAD_USER:String = "it.youearned.events.loadUser";
		
		public var user_id:Object;
		
		public function LoadUserEvent(user_id:Object)
		{
			super(LOAD_USER);
			this.user_id = user_id;
		}
	}
}