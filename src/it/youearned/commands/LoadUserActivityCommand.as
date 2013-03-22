package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import it.youearned.api.services.valueObjects.GetActivitySetResultType;
	import it.youearned.business.LoadUserActivityDelegate;
	import it.youearned.events.LoadUserActivityEvent;
	import it.youearned.model.AppModel;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public final class LoadUserActivityCommand implements ICommand, IResponder
	{
		private var model:AppModel = AppModel.getInstance();
		
		public function execute(event:BaseEvent):void
		{
			var evt:LoadUserActivityEvent = event as LoadUserActivityEvent;
			var delegate:LoadUserActivityDelegate = new LoadUserActivityDelegate(this);
			delegate.load(evt.user_id);
		}
		
		public function result(data:Object):void
		{
			var res:ResultEvent = data as ResultEvent;
			if (res.statusCode == 200) {
				var g:GetActivitySetResultType = res.result as GetActivitySetResultType;
				
				model.myActivity = g;
			}
			else {
				trace('error loading data');
			}
		}
		
		public function fault(info:Object):void
		{
			trace("LoadUserActivity FAULT: " + info.toString());
		}
	}
}