package it.youearned.presenters
{
	import com.adobe.khoyt.parse.Parse;
	import com.adobe.khoyt.parse.events.ParseEvent;
	import com.greensock.TweenLite;
	import com.rockfish.observers.IObserver;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.navigateToURL;
	import flash.utils.setTimeout;
	
	import mx.utils.Base64Encoder;
	
	import spark.transitions.SlideViewTransition;
	import spark.transitions.ViewTransitionDirection;
	
	import it.youearned.events.LogoutEvent;
	import it.youearned.events.ToggleMenuEvent;
	import it.youearned.events.ToggleSendPointsEvent;
	import it.youearned.model.AppModel;
	
	import pl.mateuszmackowiak.nativeANE.NativeDialogEvent;
	import pl.mateuszmackowiak.nativeANE.NativeDialogListEvent;
	import pl.mateuszmackowiak.nativeANE.alert.NativeAlert;
	import pl.mateuszmackowiak.nativeANE.dialogs.NativeListDialog;
	import pl.mateuszmackowiak.nativeANE.dialogs.NativeTextField;
	import pl.mateuszmackowiak.nativeANE.dialogs.NativeTextInputDialog;
	import pl.mateuszmackowiak.nativeANE.notification.NativeNotifiction;
	import pl.mateuszmackowiak.nativeANE.progress.NativeProgress;
	import pl.mateuszmackowiak.nativeANE.properties.SystemProperties;
	import pl.mateuszmackowiak.nativeANE.toast.Toast;
	
	import views.ActivityMain;
	import views.SendPoints;

	public class BasePresenter implements IObserver
	{
		public var model:AppModel = AppModel.getInstance();
		public static const navWidth:int = 262;
		
		public var alert:NativeAlert = new NativeAlert();
		
		public function toggleMenu(event:ToggleMenuEvent, logout:Boolean = false, login:Boolean = false):void
		{
			trace("toggle");
			trace(event.currentTarget);
			if (event.open) {
				trace("open");
				if(!model.menu.includeInLayout) {
					model.menu.includeInLayout = true;
					TweenLite.to(model.menu, .5, {width:navWidth});
					if(model.deviceType == "phone") {
						model.mainNavigator.enabled = false;
					}
					else {
						if(login) {
							setTimeout(function() {
								model.mainNavigator.pushView(views.ActivityMain);
							}, 300);
						}
					}
				}
			}
			else {
				trace("close");
				if(logout ||(model.menu.includeInLayout && model.deviceType != "tablet")) {
					TweenLite.to(model.menu, .5, {width:0, onComplete: function() {
						model.menu.includeInLayout = false;
						if(model.deviceType == "phone") {
							if(logout)
								new LogoutEvent().dispatch();
							return;
						}
						else {
							if(logout)
								setTimeout(function() {
									new LogoutEvent().dispatch();
								}, 400);
							}
							return;
						}
					});
				}
			}
		}
		
		public function toggleSendPoints(event:ToggleSendPointsEvent):void
		{
			var slideDown:SlideViewTransition = new SlideViewTransition();
			slideDown.direction = ViewTransitionDirection.UP;
			model.mainNavigator.pushView(views.SendPoints, null, null, slideDown);
			//new UpdateViewEvent(UpdateViewEvent.PUSH_VIEW,SendPointsView,null,{type:"cover",direction:"up"}).dispatch();
		}
		
		public function subscribe():void
		{
			model.subscribe(this);
		}
		
		public function unsubscribe():void
		{
			model.unsubscribe(this);
		}
		
		/**
		 * Must be overwritten in child classes to use the observer pattern 
		 * @param key
		 * @param value
		 * 
		 */
		public function update(key:String, value:Object):void
		{
						
		}
		
		//check for a new version of the application on parse.com
		
		private var parseLoader:URLLoader;
		private var parse:Parse;
		public function parseRead():void
		{
			parse = new Parse( Constants.USERNAME, Constants.PASSWORD );
			parse.addEventListener( ParseEvent.SEARCH, doParseRead );	
			parse.search("Version");
		}
		
		protected function doParseRead( event:ParseEvent ):void
		{
			var change:Object = null;
			
			trace( "Read full record: " + event.value.length );
			for each(var deviceType:Object in event.value) {
				if(model.deviceOS == deviceType.OS) {
					trace(deviceType.OS, " | version no: ", deviceType.VersionNo)
					if(deviceType.VersionNo != model.versionNo) {
						updateURL = deviceType.VersionURL;
						
						trace(deviceType.OS);
						alert.message = deviceType.Message;
						alert.title = "Update Available";
						
						alert.closeLabel = "Update Now";
							
						if(deviceType.ForceUpdate == false)
							alert.otherLabels = "Later";
						
						
						//alert.theme = 1;
						alert.closeHandler = hideAlert;
						alert.show();
					}
					break;
				}
					
			}
			
		}
		
		private var updateURL:String;
		
		protected function hideAlert(event:NativeDialogEvent):void {
			if(event.index == "0")
				navigateToURL(new URLRequest(updateURL));
		}
		
	}
}