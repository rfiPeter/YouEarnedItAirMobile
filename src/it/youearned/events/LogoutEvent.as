package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	public final class LogoutEvent extends BaseEvent
	{
		public static const LOGOUT:String = "it.youearned.events.logout";
		
		public function LogoutEvent()
		{
			super(LOGOUT);
		}
	}
}