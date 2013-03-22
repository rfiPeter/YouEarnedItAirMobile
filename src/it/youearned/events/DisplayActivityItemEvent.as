package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	import it.youearned.api.services.valueObjects.Activity;
	
	public final class DisplayActivityItemEvent extends BaseEvent
	{
		public static const SHOW_ACTIVITY_ITEM:String = "it.youearned.events.showActivityItem";
		
		public var activity:Activity;
		
		public function DisplayActivityItemEvent(activity:Activity)
		{
			super(SHOW_ACTIVITY_ITEM);
			
			this.activity = activity;
		}
	}
}