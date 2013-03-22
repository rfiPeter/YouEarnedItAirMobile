package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import it.youearned.events.LoadActivityEvent;
	import it.youearned.events.LoadCategoriesEvent;
	import it.youearned.events.LoadUserEvent;
	import it.youearned.events.LoadUsersEvent;
	import it.youearned.events.LoginEvent;
	import it.youearned.events.ToggleMenuEvent;
	import it.youearned.events.UpdateViewEvent;
	import it.youearned.model.AppModel;
	import it.youearned.presenters.ActivityPresenter;
	import it.youearned.utils.TransitionUtil;
	
	import views.ActivityMain;
	
	public final class LoginCommand implements ICommand
	{
		private var model:AppModel = AppModel.getInstance();
		public function execute(event:BaseEvent):void
		{
			var evt:LoginEvent = event as LoginEvent;
			
			new LoadUserEvent("me").dispatch();
			new LoadActivityEvent().dispatch();			
			new LoadUsersEvent().dispatch();		
			new LoadCategoriesEvent().dispatch();
			
			//model.menu.alpha = 1;
			
			model.setPresenter(ActivityPresenter, new ActivityPresenter, true);
			
			//new UpdateViewEvent(UpdateViewEvent.REPLACE_VIEW, ActivityView, null, {type:"uncover",direction:"left"}).dispatch();
			trace("login command");
			var presenter:ActivityPresenter = model.getPresenter(ActivityPresenter) as ActivityPresenter;
			if(model.deviceType == "tablet")
				presenter.toggleMenu(new ToggleMenuEvent(true), false, true);
			else
				model.mainNavigator.pushView(views.ActivityMain);
			
			
		}
	}
}