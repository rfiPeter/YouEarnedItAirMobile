package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	public final class LoadActivityCommentsEvent extends BaseEvent
	{
		public static const LOAD_COMMENTS:String = "it.youearned.events.loadComments";
		public var activity_id:int;
		public function LoadActivityCommentsEvent(activity_id:int)
		{
			super(LOAD_COMMENTS);
			this.activity_id = activity_id;
		}
	}
}