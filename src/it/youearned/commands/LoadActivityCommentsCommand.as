package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import it.youearned.api.services.valueObjects.CommentSetObject;
	import it.youearned.business.LoadActivityCommentsDelegate;
	import it.youearned.events.LoadActivityCommentsEvent;
	import it.youearned.model.AppModel;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	public final class LoadActivityCommentsCommand implements ICommand, IResponder
	{
		public function execute(event:BaseEvent):void
		{
			var evt:LoadActivityCommentsEvent = event as LoadActivityCommentsEvent;
			var delegate:LoadActivityCommentsDelegate = new LoadActivityCommentsDelegate(this);
			delegate.load(evt.activity_id);
		}
		
		public function result(data:Object):void
		{
			var evt:ResultEvent = data as ResultEvent;
			AppModel.getInstance().comments = evt.result as CommentSetObject;
		}
		
		public function fault(info:Object):void
		{
		}
	}
}