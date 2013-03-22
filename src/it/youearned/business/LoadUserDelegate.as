package it.youearned.business
{
	import it.youearned.api.services.YouEarnedItServices;
	import it.youearned.model.AppModel;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public final class LoadUserDelegate
	{
		private var service:YouEarnedItServices;
		private var responder:IResponder;
				
		public function LoadUserDelegate(responder:IResponder)
		{
			this.responder = responder;
			this.service = AppModel.getInstance().services;
		}
		
		public function load(user_id:Object):void
		{
			var token:AsyncToken = this.service.GetUser(user_id);
			token.addResponder(this.responder);
		}
		
	}
}