package it.youearned.business
{
	import it.youearned.api.services.YouEarnedItServices;
	import it.youearned.api.services.valueObjects.BaseActivityObject;
	import it.youearned.api.services.valueObjects.Activity;
	import it.youearned.model.AppModel;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public final class AddActivityDelegateAll
	{
		private var services:YouEarnedItServices;
		private var responder:IResponder;
		
		public function AddActivityDelegateAll(responder:IResponder)
		{
			this.services = AppModel.getInstance().services;
			this.responder = responder;
		}
		
		/*public function add(activity:SimpleActivity):void
		{
			var base:BaseSimpleActivityObject = new BaseSimpleActivityObject();
			base.activity = activity;
			var token:AsyncToken = this.services.CreateActivity(base);
			token.addResponder(this.responder);
		}*/
		public function add(activity:Activity):void
		{
			var base:BaseActivityObject = new BaseActivityObject();
			base.activity = activity;
			var token:AsyncToken = this.services.CreateActivityAll(base);
			token.addResponder(this.responder);
		}
	}
}