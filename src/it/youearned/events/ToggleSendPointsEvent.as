package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	public final class ToggleSendPointsEvent extends BaseEvent
	{
		public static const TOGGLE_SEND_POINTS:String = "toggleSendPoints";
		public function ToggleSendPointsEvent()
		{
			super(TOGGLE_SEND_POINTS);
		}
	}
}