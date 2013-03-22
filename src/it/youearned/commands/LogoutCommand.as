package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	
	import spark.transitions.ViewTransitionBase;
	
	import it.youearned.model.AppModel;
	import it.youearned.presenters.ActivityPresenter;
	import it.youearned.views.LoginView;
	
	import views.Login;
	
	public final class LogoutCommand implements ICommand, IResponder
	{
		private var model:AppModel = AppModel.getInstance();
		public function execute(event:BaseEvent):void
		{
			var token:String = model.authToken;
			model.revokeToken();
			
			model.activity = null;
			model.me = null;
			
			logout(token);
		}
		
		private function logout(token:String):void
		{
			var url:String = "http://login.youearnedit.com/oauth/revoke";
			var srv:HTTPService = new HTTPService();
			srv.url = url;
			srv.method = URLRequestMethod.POST;
			
			var vars:URLVariables = new URLVariables();
			vars.token = token;
			
			var tkn:AsyncToken = srv.send(vars);
			tkn.addResponder(this);
		}
		
		public function result(data:Object):void
		{			
			model.mainNavigator.popAll();
			var blankTrans:ViewTransitionBase = null;
			model.mainNavigator.pushView(views.Login,blankTrans);
		}
		public function fault(info:Object):void
		{
			// we have a failure but it removed the auth token from the device so, the user will be forced to log in, deauthorizing any other token out there.
			model.mainNavigator.popAll();
			model.mainNavigator.pushView(views.Login);
		}
	}
}