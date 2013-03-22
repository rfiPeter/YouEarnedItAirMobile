package it.youearned.presenters
{
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import spark.components.List;
	import spark.components.VGroup;
	
	import it.youearned.api.services.valueObjects.Activity;
	import it.youearned.api.services.valueObjects.ActivitySet;
	import it.youearned.api.services.valueObjects.GetActivitySetResultType;
	import it.youearned.events.ToggleSendPointsEvent;
	import it.youearned.events.UpdateViewEvent;
	import it.youearned.model.AppModel;
	import it.youearned.renderers.ActivityItemRenderer;
	import it.youearned.views.SendPointsView;

	public final class UserProfilePresenter extends BasePresenter
	{	
		private var all:List;
		private var sent:VGroup;
		private var rec:VGroup;
		
		private var feed:ArrayCollection;
		
		private var myActivity:ArrayCollection;
		private var sentActivity:ArrayCollection;
		private var receivedActivity:ArrayCollection;
		
		
		public function init(allList:List):void
		{
			subscribe();
			
			all = allList;
			
			if (model.myActivity != null)
				drawAll();
		}
		
		
		
		
		
		override public function update(key:String, value:Object):void
		{
			if (key == "myActivity") {
				trace('my activity loaded');
				drawAll();
			}
		}
		
		
		public function updateView(value:int):void
		{
			trace("updateView: ", value);
			switch (value)
			{
				case 0:
					drawAll();
					break;
				case 2:
					drawSent();
					break;
				case 1:
					drawRec();
					break;
			}		
		}
		
		private var sentReady:Boolean = false;
		private var recReady:Boolean = false;
		private var drawSentList:Boolean = false;
		private var drawRecList:Boolean = false;
		public function listReady(view:String, list:VGroup):void
		{
			if (view == "sent") {
				sentReady = true;
				sent = list;
				if (drawSentList) {
					drawSentList = false;
					drawSent();
				}
			}
			if (view == "rec") {
				recReady = true;
				rec = list;
				if (drawRecList) {
					drawRecList = false;
					drawRec();
				}
			}
		}
		
		
		private function drawAll():void
		{
			
			trace("draw all");
			myActivity = model.myActivity.data;
			
			trace(myActivity.length);
			
			all.dataProvider = myActivity;
			
		}
		private function filterSent(item:Object):Boolean{
			if(item.activity.sender.id == model.me.id)
				return true;
			return false;
		}
		private function drawSent():void
		{
			
			if(!sentActivity) {
				sentActivity = new ArrayCollection();
				for each (var item:ActivitySet in model.myActivity.data) {
					sentActivity.addItem(item);
				}
				sentActivity.filterFunction = filterSent;
				sentActivity.refresh();
			}
			all.dataProvider = sentActivity;
		}
		private function filterReceived(item:Object):Boolean{
			if(item.activity.recipient.id == model.me.id)
				return true;
			return false;
		}
		private function drawRec():void
		{
			
			if(!receivedActivity) {
				receivedActivity = new ArrayCollection();
				for each (var item:ActivitySet in model.myActivity.data) {
					receivedActivity.addItem(item);
				}
				receivedActivity.filterFunction = filterReceived;
				receivedActivity.refresh();
			}
			all.dataProvider = receivedActivity;
			
		}
		
		
		
		
	}
}