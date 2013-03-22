package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import it.youearned.events.DisplayActivityItemEvent;
	import it.youearned.events.LoadActivityCommentsEvent;
	import it.youearned.events.UpdateViewEvent;
	import it.youearned.model.AppModel;
	import it.youearned.views.SingleActivityView;
	
	public final class DisplayActivityItemCommand implements ICommand
	{
		private var model:AppModel = AppModel.getInstance();
		
		public function execute(event:BaseEvent):void
		{
			var evt:DisplayActivityItemEvent = event as DisplayActivityItemEvent;
			
			new UpdateViewEvent(UpdateViewEvent.PUSH_VIEW, SingleActivityView, evt.activity, {type:"slide",direction:"left"}).dispatch();
			
			// only request this info if we actually have comments...
			if (evt.activity.comments.length > 0)
				new LoadActivityCommentsEvent(evt.activity.id).dispatch();
		}
	}
}