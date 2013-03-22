package it.youearned.presenters
{
	import com.greensock.TweenLite;
	import com.rockfish.observers.IObserver;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.FlexEvent;
	
	import spark.components.List;
	import spark.components.View;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.ViewTransitionDirection;
	
	import it.youearned.api.services.valueObjects.ActivitySet;
	import it.youearned.api.services.valueObjects.GetActivitySetResultType;
	import it.youearned.events.ToggleMenuEvent;
	import it.youearned.events.ToggleSendPointsEvent;
	import it.youearned.events.UpdateViewEvent;
	import it.youearned.model.AppModel;
	import it.youearned.renderers.ActivityItemRenderer;
	import it.youearned.renderers.ActivityItemRenderer2;
	import it.youearned.views.SendPointsView;
	
	import views.SendPoints;
	

	public final class ActivityPresenter extends BasePresenter
	{
		[Bindable]
		public var activity:ArrayCollection;
		
		private var loaded:Boolean = false;
		
		
		private var updateCurrentState:Function;
		private var _feed:List;
		public function get feed():List
		{
			return _feed;
		}
		public function set feed(value:List):void
		{
			_feed = value;
		}
		private var _tabletFeed:List;
		public function get tabletFeed():List
		{
			return _tabletFeed;
		}
		public function set tabletFeed(value:List):void
		{
			_tabletFeed = value;
		}
		private var _view:View;

		public function get view():View
		{
			return _view;
		}

		public function set view(value:View):void
		{
			_view = value;
		}

		public function init(updateState:Function, newFeed:List):void
		{
			updateCurrentState = updateState;
			if (loaded) {
				if (!activity || activity.length == 0) {
				}
				else {
					newFeed.dataProvider = activity; 
				}	
				trace("loaded");
				updateCurrentState("ready");
				return;
			}
			loaded = true;			
			_feed = newFeed;
			
			
			
			if(!activity || activity.length == 0) {
				updateCurrentState("loading");
				trace("entering loading state");
			}
			else {
				updateCurrentState("ready");
			}
			subscribe();
		}
		
				
		public function setProvider():void
		{
			_feed.dataProvider = activity;
			trace(_feed.dataProvider.length);
			
		}
		
		private function whatsUp(event:CollectionEvent):void
		{
			// TODO Auto Generated method stub
			trace("whatsUp");
			trace(event.currentTarget);
			trace(event.toString());
		}		
		
		
		
		override public function update(key:String, value:Object):void
		{
			if (key == "activity") {
				if (value == null) {
					activity = null;
					trace("no activity");
					return;
				}
				
				activity = GetActivitySetResultType(value).data;
				trace(value);
				updateCurrentState("ready");
				trace("activity returned");
				
			}
			else if (key == "animating") {
				if (value == false)
					_feed.dataProvider = activity;
			}
		}
		
		
		
	}
}