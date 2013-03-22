package it.youearned.business
{
	import it.youearned.api.services.YouEarnedItServices;
	import it.youearned.model.AppModel;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public final class LoadActivityCommentsDelegate
	{
		private var service:YouEarnedItServices;	
		private var responder:IResponder;
		
		public function LoadActivityCommentsDelegate(responder:IResponder)
		{
			this.service = AppModel.getInstance().services;
			this.responder = responder;
		}
		
		public function load(activity_id:int):void
		{
			var token:AsyncToken = this.service.GetActivityComments(activity_id);
			token.addResponder(this.responder);
		}
	}
}