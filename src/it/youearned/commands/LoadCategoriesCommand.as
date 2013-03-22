package it.youearned.commands
{
	import com.rockfish.control.ICommand;
	import com.rockfish.events.BaseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import it.youearned.business.LoadCategoriesDelegate;
	import it.youearned.model.AppModel;
	import it.youearned.utils.Log;

	public final class LoadCategoriesCommand implements ICommand, IResponder
	{	
		private var model:AppModel = AppModel.getInstance();
		
		public function execute(event:BaseEvent):void
		{
			Log.info('Loading Categories');
			var delegate:LoadCategoriesDelegate = new LoadCategoriesDelegate(this);
			delegate.load();
		}
		
		public function result(data:Object):void
		{
			Log.info('Loaded categories successfully');
			var res:ResultEvent = data as ResultEvent;
			model.categories = res.result as ArrayCollection;
		}
		
		public function fault(info:Object):void
		{
			Log.error('Failed to load categories: ' + info.toString());
		}
		
		
		
	}
}