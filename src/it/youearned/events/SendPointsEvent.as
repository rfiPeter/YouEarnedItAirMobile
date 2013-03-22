package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	import it.youearned.api.services.valueObjects.Activity;
	import it.youearned.api.services.valueObjects.SimpleActivity;
	
	public class SendPointsEvent extends BaseEvent
	{
		public static const SEND_POINTS:String = "it.youearned.events.sendPoints";
		public static const OPEN:String = "it.youearned.events.open";
		public static const CANCEL:String = "it.youearned.events.cancel";
		
		public var activity:Activity;
				
		public function SendPointsEvent(type:String, activity:Activity)
		{
			super(type);
			
			this.activity = activity;
		}
	}
}