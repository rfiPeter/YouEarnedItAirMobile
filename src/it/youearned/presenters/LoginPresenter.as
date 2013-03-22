package it.youearned.presenters
{	
	import it.youearned.events.LoginEvent;
	import it.youearned.presenters.BasePresenter;

	public final class LoginPresenter extends BasePresenter
	{				
		public function login():void
		{
			new LoginEvent().dispatch();
		}
	}
}