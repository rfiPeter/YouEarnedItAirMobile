package it.youearned.controller
{
	import com.rockfish.control.BaseController;
	
	import it.youearned.commands.AddCommentCommand;
	import it.youearned.commands.DisplayActivityItemCommand;
	import it.youearned.commands.LoadActivityCommand;
	import it.youearned.commands.LoadActivityCommentsCommand;
	import it.youearned.commands.LoadCategoriesCommand;
	import it.youearned.commands.LoadUserActivityCommand;
	import it.youearned.commands.LoadUserCommand;
	import it.youearned.commands.LoadUsersCommand;
	import it.youearned.commands.LoginCommand;
	import it.youearned.commands.LogoutCommand;
	import it.youearned.commands.SendPointsCommand;
	import it.youearned.commands.UpdateViewCommand;
	import it.youearned.events.AddCommentEvent;
	import it.youearned.events.DisplayActivityItemEvent;
	import it.youearned.events.LoadActivityCommentsEvent;
	import it.youearned.events.LoadActivityEvent;
	import it.youearned.events.LoadCategoriesEvent;
	import it.youearned.events.LoadUserActivityEvent;
	import it.youearned.events.LoadUserEvent;
	import it.youearned.events.LoadUsersEvent;
	import it.youearned.events.LoginEvent;
	import it.youearned.events.LogoutEvent;
	import it.youearned.events.SendPointsEvent;
	import it.youearned.events.UpdateViewEvent;
	
	public final class AppController extends BaseController
	{
		public function AppController()
		{
			super();
			
			initialize();
		}
		
		private function initialize():void
		{
			//addListener(UpdateViewEvent.PUSH_VIEW, UpdateViewCommand);
			//addListener(UpdateViewEvent.POP_VIEW, UpdateViewCommand);
			//addListener(UpdateViewEvent.REPLACE_VIEW, UpdateViewCommand);
			
			addListener(LoginEvent.LOGIN, LoginCommand);
			addListener(LogoutEvent.LOGOUT, LogoutCommand);
			addListener(LoadActivityEvent.LOAD_ACTIVITY, LoadActivityCommand);
			addListener(LoadUserEvent.LOAD_USER, LoadUserCommand);
			addListener(LoadUsersEvent.LOAD_USERS, LoadUsersCommand);
			addListener(LoadUserActivityEvent.LOAD_USER_ACTIVITY, LoadUserActivityCommand);
			addListener(LoadCategoriesEvent.LOAD_CATEGORIES, LoadCategoriesCommand);
			
			addListener(SendPointsEvent.OPEN, SendPointsCommand);
			addListener(SendPointsEvent.CANCEL, SendPointsCommand);
			addListener(SendPointsEvent.SEND_POINTS, SendPointsCommand);
			
			addListener(DisplayActivityItemEvent.SHOW_ACTIVITY_ITEM, DisplayActivityItemCommand);
			addListener(LoadActivityCommentsEvent.LOAD_COMMENTS, LoadActivityCommentsCommand);
			
			addListener(AddCommentEvent.ADD_COMMENT, AddCommentCommand);
		}		
		
	}
}