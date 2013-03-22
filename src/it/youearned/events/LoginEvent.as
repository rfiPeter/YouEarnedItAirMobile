package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	public final class LoginEvent extends BaseEvent
	{
		public static const LOGIN:String = "it.youearned.events.login";
		
		public function LoginEvent()
		{
			super(LOGIN);
		}
	}
}