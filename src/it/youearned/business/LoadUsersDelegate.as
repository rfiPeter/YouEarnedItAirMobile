package it.youearned.business
{
	import it.youearned.api.services.YouEarnedItServices;
	import it.youearned.model.AppModel;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public final class LoadUsersDelegate
	{
		private var service:YouEarnedItServices;
		private var responder:IResponder;
		
		public function LoadUsersDelegate(responder:IResponder)
		{
			this.responder = responder;
			this.service = AppModel.getInstance().services;
		}
		
		public function load():void
		{
			var token:AsyncToken = this.service.GetUsers();
			token.addResponder(this.responder);
		}
	}
}