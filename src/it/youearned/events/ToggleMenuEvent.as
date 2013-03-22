package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	public final class ToggleMenuEvent extends BaseEvent
	{
		public static const TOGGLE_MENU:String = "toggleMenu";
		
		public var open:Boolean;
		
		public function ToggleMenuEvent(open:Boolean)
		{
			super(TOGGLE_MENU);
			this.open = open;
		}
	}
}