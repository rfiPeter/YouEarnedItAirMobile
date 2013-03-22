package it.youearned.business
{
	import it.youearned.api.services.YouEarnedItServices;
	import it.youearned.api.services.valueObjects.BaseSimpleActivityObject;
	import it.youearned.api.services.valueObjects.SimpleActivity;
	import it.youearned.model.AppModel;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import it.youearned.api.services.valueObjects.Activity;
	import it.youearned.api.services.valueObjects.BaseActivityObject;

	public final class AddActivityDelegate
	{
		private var services:YouEarnedItServices;
		private var responder:IResponder;
		
		public function AddActivityDelegate(responder:IResponder)
		{
			this.services = AppModel.getInstance().services;
			this.responder = responder;
		}
		
		public function add(activity:Activity):void
		{
			var base:BaseActivityObject = new BaseActivityObject();
			base.activity = activity;
			var token:AsyncToken = this.services.CreateActivityAll(base);
			token.addResponder(this.responder);
		}
	}
}