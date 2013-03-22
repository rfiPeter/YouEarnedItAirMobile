package it.youearned.model
{
	import com.rockfish.model.BaseModel;
	
	import flash.net.SharedObject;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.ViewNavigator;
	
	import it.youearned.api.services.YouEarnedItServices;
	import it.youearned.api.services.valueObjects.CommentSetObject;
	import it.youearned.api.services.valueObjects.GetActivitySetResultType;
	import it.youearned.api.services.valueObjects.User;
	import it.youearned.components.SimpleViewNavigator;
	
	[Bindable]
	public final class AppModel extends BaseModel
	{
		public var versionNo:String = "1.0.1";
		
		public var storage:SharedObject = SharedObject.getLocal("api.youearned.it.auth");
		
		public var mainNavigator:ViewNavigator;
		
		public var imageCache:ImageCache = new ImageCache();
		
		public function get authToken():String
		{
//			var str:String = "48b60d446ca54a51b11ca411deed23b49c70aa8b45b4f552a708402eeedf6a40";
//			return str;
			var str:String;
			if (storage.data['token']) {
				str = storage.data['token'];
			}
			return str;
		}
		public function set authToken(value:String):void
		{
			storage.data['token'] = value;
			storage.flush();
		}
		public function revokeToken():void
		{
			storage.data['token'] = null;
			storage.flush();
			
			_services = null;
		}
		private var _deviceOS:String;
		
		public function get deviceOS():String
		{
			return _deviceOS;
		}
		
		public function set deviceOS(value:String):void
		{
			_deviceOS = value;
		}
		
		private var _deviceOsDetails:String;

		public function get deviceOsDetails():String
		{
			return _deviceOsDetails;
		}

		public function set deviceOsDetails(value:String):void
		{
			_deviceOsDetails = value;
		}

		
		private var _deviceType:String;

		public function get deviceType():String
		{
			return _deviceType;
		}

		public function set deviceType(value:String):void
		{
			_deviceType = value;
		}
		//used for tablets
		private var _deviceOrientation:String = "portrait";

		public function get deviceOrientation():String
		{
			return _deviceOrientation;
		}

		public function set deviceOrientation(value:String):void
		{
			_deviceOrientation = value;
		}
		private var _currentOrientation:String = "portrait";

		public function get currentOrientation():String
		{
			return _currentOrientation;
		}

		public function set currentOrientation(value:String):void
		{
			_currentOrientation = value;
		}

		
		public var menuBarHeight:Number = 55;
		public var width:Number;
		public var height:Number;
		public var landscapeWidth:Number;
		public var portraitWidth:Number;
		public var navigator:SimpleViewNavigator;
		public var menu:ViewNavigator;
		
		private var _services:YouEarnedItServices;

		public function get services():YouEarnedItServices
		{
			if (!_services)
				_services = new YouEarnedItServices(authToken);
			return _services;
		}

		
		private var _me:User;
		public function get me():User
		{
			return _me;
		}
		public function set me(value:User):void
		{
			_me = value;
			notifyObservers("me",value);
		}
		
		private var _myActivity:GetActivitySetResultType;
		public function get myActivity():GetActivitySetResultType
		{
			return _myActivity;
		}
		public function set myActivity(value:GetActivitySetResultType):void
		{
			_myActivity = value;
			notifyObservers("myActivity",value);
		}

		
		private var _users:ArrayCollection;
		public function get users():ArrayCollection
		{
			return _users;
		}
		public function set users(value:ArrayCollection):void
		{
			_users = value;
			notifyObservers("users",value);
		}

		
		private var _categories:ArrayCollection;
		public function get categories():ArrayCollection
		{
			return _categories;
		}
		public function set categories(value:ArrayCollection):void
		{
			_categories = value;
			notifyObservers("categories",value);
		}
		
		private var _activity:GetActivitySetResultType;
		public function get activity():GetActivitySetResultType
		{
			return _activity;
		}
		
		public function set activity(value:GetActivitySetResultType):void
		{
			trace('setting activity');
			_activity = value;
			notifyObservers("activity",value);
		}
			
		private var _animating:Boolean = false;
		public function get animating():Boolean
		{
			return _animating;
		}

		public function set animating(value:Boolean):void
		{
			_animating = value;
			notifyObservers("animating",value);
		}
		
		
		private var _comments:CommentSetObject;
		public function get comments():CommentSetObject
		{
			return _comments;
		}
		public function set comments(value:CommentSetObject):void
		{
			_comments = value;
			notifyObservers("comments",value);
		}
		
		
		
		
		public function AppModel(secure:PrivateClass)
		{
			super();
		}
		
		private static var _instance:AppModel;

		

		public static function getInstance():AppModel
		{
			if (!_instance) _instance = new AppModel(new PrivateClass);
			return _instance;
		}
		
		
		
	}
	
}

class PrivateClass {}

