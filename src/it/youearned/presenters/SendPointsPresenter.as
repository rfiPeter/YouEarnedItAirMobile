package it.youearned.presenters
{
	import it.youearned.model.AppModel;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class SendPointsPresenter extends BasePresenter
	{
		public var updateStateFunction:Function;
		
		public function updateState(value:String, data:Object = null):void
		{
			updateStateFunction(value, data);
		}
	}
}