package it.youearned.business
{
	import it.youearned.api.services.YouEarnedItServices;
	import it.youearned.model.AppModel;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public final class LoadActivityDelegate
	{
		private var service:YouEarnedItServices;
		private var responder:IResponder;
		public function LoadActivityDelegate(responder:IResponder)
		{
			this.service = AppModel.getInstance().services;
			this.responder = responder;
		}
		
		public function load(size:Object):void
		{
			var token:AsyncToken = this.service.GetActivity(size);
			token.addResponder(this.responder);
		}
	}
}