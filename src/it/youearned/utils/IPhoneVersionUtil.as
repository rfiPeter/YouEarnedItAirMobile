package it.youearned.utils
{
	import flash.system.Capabilities;

	public class IPhoneVersionUtil
	{
		

		
		public function IPhoneVersionUtil()
		{
			super();
		}
		public static function getDevice():String {
			var info:Array = Capabilities.os.split(" ");
			if (info[0] + " " + info[1] != "iPhone OS") {
				return UNKNOWN;
			}
			
			// ordered from specific (iPhone1,1) to general (iPhone)
			for each (var device:String in IOS_DEVICES) {	
				if (info[3].indexOf(device) != -1) {
					return device;
				}
			}
			return UNKNOWN;
		}
		
		public static const IPHONE_1G:String = "iPhone1,1"; // first gen is 1,1
		public static const IPHONE_3G:String = "iPhone1"; // second gen is 1,2
		public static const IPHONE_3GS:String = "iPhone2"; // third gen is 2,1
		public static const IPHONE_4:String = "iPhone3"; // normal:3,1 verizon:3,3
		public static const IPHONE_4S:String = "iPhone4"; // 4S is 4,1
		public static const IPHONE_5PLUS:String = "iPhone5";
		public static const TOUCH_1G:String = "iPod1,1";
		public static const TOUCH_2G:String = "iPod2,1";
		public static const TOUCH_3G:String = "iPod3,1";
		public static const TOUCH_4G:String = "iPod4,1";
		public static const TOUCH_5PLUS:String = "iPod";
		public static const IPAD_1:String = "iPad1"; // iPad1 is 1,1
		public static const IPAD_2:String = "iPad2"; // wifi:2,1 gsm:2,2 cdma:2,3
		public static const IPAD_3:String = "iPad3"; //(guessing)
		public static const IPAD_4PLUS:String = "iPad";
		public static const EMULATOR:String = "x86_64";
		public static const UNKNOWN:String = "unknown";
		
		private static const IOS_DEVICES:Array = [IPHONE_1G, IPHONE_3G, IPHONE_3GS,
			IPHONE_4, IPHONE_4S, IPHONE_5PLUS, IPAD_1, IPAD_2, IPAD_3, IPAD_4PLUS,
			TOUCH_1G, TOUCH_2G, TOUCH_3G, TOUCH_4G, TOUCH_5PLUS, EMULATOR];
	}
}