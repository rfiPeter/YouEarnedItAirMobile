package it.youearned.business
{
	import it.youearned.api.services.YouEarnedItServices;
	import it.youearned.api.services.valueObjects.AddCommentObject;
	import it.youearned.api.services.valueObjects.SimpleComment;
	import it.youearned.model.AppModel;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public final class AddCommentDelegate
	{
		private var service:YouEarnedItServices;
		private var responder:IResponder;
		
		public function AddCommentDelegate(responder:IResponder)
		{
			this.service = AppModel.getInstance().services;
			this.responder = responder;
		}
		
		public function add(comment:AddCommentObject):void
		{
			var token:AsyncToken = this.service.CreateComment(comment);
			token.addResponder(this.responder);
		}
	}
}