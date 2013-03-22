package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import it.youearned.business.LoadUsersDelegate;
	import it.youearned.model.AppModel;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public final class LoadUsersCommand implements ICommand, IResponder
	{
		private var model:AppModel = AppModel.getInstance();
		
		public function execute(event:BaseEvent):void
		{
			var delegate:LoadUsersDelegate = new LoadUsersDelegate(this);
			delegate.load();
		}
		
		public function result(data:Object):void
		{
			var res:ResultEvent = data as ResultEvent;
			model.users = res.result as ArrayCollection;
		}
		
		public function fault(info:Object):void
		{
			
		}
	}
}