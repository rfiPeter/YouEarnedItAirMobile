package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	public final class LoadUsersEvent extends BaseEvent
	{
		public static const LOAD_USERS:String = "it.youearned.events.loadUsers";
		public function LoadUsersEvent()
		{
			super(LOAD_USERS);
		}
	}
}