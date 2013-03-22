package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import it.youearned.api.services.valueObjects.BaseUserObject;
	import it.youearned.business.LoadUserDelegate;
	import it.youearned.events.LoadUserEvent;
	import it.youearned.model.AppModel;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public final class LoadUserCommand implements ICommand, IResponder
	{
		private var model:AppModel = AppModel.getInstance();
		
		public function execute(event:BaseEvent):void
		{
			var evt:LoadUserEvent = event as LoadUserEvent;
			
			var delegate:LoadUserDelegate = new LoadUserDelegate(this);
			delegate.load(evt.user_id);
		}
		
		public function result(data:Object):void
		{
			var res:ResultEvent = data as ResultEvent;
			model.me = BaseUserObject(res.result).user;
		}
		
		public function fault(info:Object):void
		{
			var fault:FaultEvent = info as FaultEvent;
			
		}
	}
}