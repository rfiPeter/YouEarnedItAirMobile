package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import it.youearned.api.services.valueObjects.GetActivitySetResultType;
	import it.youearned.business.LoadActivityDelegate;
	import it.youearned.events.LoadActivityEvent;
	import it.youearned.events.LoadUserEvent;
	import it.youearned.events.LogoutEvent;
	import it.youearned.model.AppModel;
	import it.youearned.model.ServiceStatusModel;
	import it.youearned.utils.Log;
	
	
	public final class LoadActivityCommand implements ICommand, IResponder
	{
		public function execute(event:BaseEvent):void
		{
			Log.info("Loading Activity");
			
			if (ServiceStatusModel.getInstance().loadingActivity) {
				Log.info("Loading Activity cancelled");
				return;
			}
			ServiceStatusModel.getInstance().loadingActivity = true;
			
			var evt:LoadActivityEvent = event as LoadActivityEvent;
			var delegate:LoadActivityDelegate = new LoadActivityDelegate(this);
			delegate.load(evt.size);
			
		}
		
		public function result(data:Object):void
		{
			ServiceStatusModel.getInstance().loadingActivity = false;
			Log.info("Load Activity success result");
			var res:ResultEvent = data as ResultEvent;
			if (res.statusCode == 200) {
				Log.info("Load Activity results parsed successfully");
				var g:GetActivitySetResultType = res.result as GetActivitySetResultType;
				AppModel.getInstance().activity = g;
			}
			else {
				Log.error("Did not load data; statusCode: " + res.statusCode);
				if (res.statusCode == 401) {
					// my token is not valid... 
					new LogoutEvent().dispatch();
				}
			}
		}
		
		public function fault(info:Object):void
		{
			ServiceStatusModel.getInstance().loadingActivity = false;
			Log.error('Load activity fault: ' + info.toString());
			var f:FaultEvent = info as FaultEvent;
			if (f.statusCode == 401) {
				new LogoutEvent().dispatch();
			}
		}
	}
}