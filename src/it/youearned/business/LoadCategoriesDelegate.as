package it.youearned.business
{
	import it.youearned.api.services.YouEarnedItServices;
	import it.youearned.model.AppModel;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public final class LoadCategoriesDelegate
	{
		private var service:YouEarnedItServices;
		private var responder:IResponder;
		public function LoadCategoriesDelegate(responder:IResponder)
		{
			this.service = AppModel.getInstance().services;
			this.responder = responder;
		}
		
		public function load():void
		{
			var token:AsyncToken = this.service.GetCategories();
			token.addResponder(this.responder);
		}
	}
}