package it.youearned.model
{
	public final class ServiceStatusModel
	{
		public var loadingActivity:Boolean = false;
		public var loadingUser:Boolean = false;
		public var loadingUsers:Boolean = false;
		public var loadingCategories:Boolean = false;
		public var loadingComments:Boolean = false;
		public var loadingUserActivity:Boolean = false;
		
		
		
		
		public function ServiceStatusModel(secure:PrivateClass)
		{
			if (!secure)
				throw new ArgumentError("Invalid object instanciation. Use ServiceStatusModel.getInstance() instead.");
		}
		
		private static var _instance:ServiceStatusModel;
		public static function getInstance():ServiceStatusModel
		{
			if (!_instance)
				_instance = new ServiceStatusModel(new PrivateClass);
			return _instance;
		}
		
	}
}
class PrivateClass {}

