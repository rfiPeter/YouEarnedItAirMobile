package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import flash.events.IOErrorEvent;
	
	import mx.rpc.IResponder;
	
	import spark.transitions.SlideViewTransition;
	import spark.transitions.ViewTransitionDirection;
	
	import Transitions;
	
	import it.youearned.api.services.valueObjects.Activity;
	import it.youearned.api.services.valueObjects.ActivitySet;
	import it.youearned.api.services.valueObjects.SimpleActivity;
	import it.youearned.business.AddActivityDelegate;
	import it.youearned.business.AddActivityDelegateAll;
	import it.youearned.events.LoadActivityEvent;
	import it.youearned.events.SendPointsEvent;
	import it.youearned.events.SendPointsEventAll;
	import it.youearned.events.UpdateViewEvent;
	import it.youearned.model.AppModel;
	import it.youearned.presenters.SendPointsPresenter;
	import it.youearned.views.PointsSentView;
	import it.youearned.views.SendPointsView;
	
	import views.SendPoints;
	
	
	public class SendPointsCommand implements ICommand, IResponder
	{
		private var model:AppModel = AppModel.getInstance();
		
		private var data:Object = null;
		
		public function execute(event:BaseEvent):void
		{
			var evt:SendPointsEvent = event as SendPointsEvent;
			//var evt:SendPointsEventAll = event as SendPointsEventAll;
			
			switch (evt.type)
			{
				case SendPointsEvent.OPEN:
					open();
					break;
				case SendPointsEvent.CANCEL:
					cancel();
					break;
				case SendPointsEvent.SEND_POINTS:
					send(evt.activity);
					break;
			}
			
			
		}
		
		private function open():void
		{	
			var slideDown:SlideViewTransition = new SlideViewTransition();
			slideDown.direction = ViewTransitionDirection.UP;
			model.mainNavigator.pushView(views.SendPoints, null, null, slideDown);
			//new UpdateViewEvent(UpdateViewEvent.PUSH_VIEW, SendPointsView,null,{type:"cover",direction:"up"}).dispatch();
		}
		
		private function cancel():void
		{
			var slideUp:SlideViewTransition = new SlideViewTransition();
			slideUp.direction = ViewTransitionDirection.DOWN;
			model.mainNavigator.popView(slideUp);
			//new UpdateViewEvent(UpdateViewEvent.POP_VIEW,null,null,{type:"uncover",direction:"down"}).dispatch();
		}
		
		/*private function send(activity:Activity):void
		{
			//var delegate:AddActivityDelegate = new AddActivityDelegate(this);
			var delegate:AddActivityDelegateAll = new AddActivityDelegateAll(this);
			points_sent = activity.points;
			delegate.add(activity);
			
		}*/
		private function send(activity:Activity):void
		{
			var delegate:AddActivityDelegate = new AddActivityDelegate(this);
			points_sent = activity.points;
			delegate.add(activity);
			
		}
		private var points_sent:int = 0;
		
		public function result(data:Object):void
		{
			var obj:Object = JSON.parse(data.result as String);
			// display the POINTS HAVE BEEN SENT view...
			
			var presenter:SendPointsPresenter = model.getPresenter(SendPointsPresenter) as SendPointsPresenter;
			presenter.updateState("sent");
			
			model.me.points_to_give = model.me.points_to_give - points_sent;
						
			new LoadActivityEvent().dispatch();
		}
		
		public function fault(info:Object):void
		{
			var returnedToken:String = JSON.stringify(info.token);
			returnedToken = returnedToken.replace("\\","");
			//trace(JSON.stringify(info));
			trace(returnedToken);
			trace("Error trying to send points: " + returnedToken);
		}
	}
}