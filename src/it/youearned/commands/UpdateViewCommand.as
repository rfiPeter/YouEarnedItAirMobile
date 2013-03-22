package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import it.youearned.events.UpdateViewEvent;
	import it.youearned.model.AppModel;
	
	public final class UpdateViewCommand implements ICommand
	{
		private var model:AppModel = AppModel.getInstance();
		
		public function execute(event:BaseEvent):void
		{
			var evt:UpdateViewEvent = event as UpdateViewEvent;
			
			switch (evt.type) {
				case UpdateViewEvent.POP_VIEW:
					model.navigator.popView();
					break;
				case UpdateViewEvent.PUSH_VIEW:
					model.navigator.pushView(evt.newView,evt.data,evt.transition);
					break;
				case UpdateViewEvent.REPLACE_VIEW:
					model.navigator.replaceView(evt.newView,evt.data,evt.transition);
					break;
			}
		}
	}
}