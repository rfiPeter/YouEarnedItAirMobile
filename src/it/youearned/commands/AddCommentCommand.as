package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import it.youearned.business.AddCommentDelegate;
	import it.youearned.events.AddCommentEvent;
	import it.youearned.events.LoadActivityCommentsEvent;
	
	import mx.rpc.IResponder;
	
	public final class AddCommentCommand implements ICommand, IResponder
	{	
		private var activity_id:int = -1;
		public function execute(event:BaseEvent):void
		{
			var evt:AddCommentEvent = event as AddCommentEvent;
			var delegate:AddCommentDelegate = new AddCommentDelegate(this);
			
			activity_id = evt.comment.activity_id;
			
			delegate.add(evt.comment);
		}
		
		public function result(data:Object):void
		{
			new LoadActivityCommentsEvent(activity_id).dispatch();
		}
		
		public function fault(info:Object):void
		{
		}
	}
}