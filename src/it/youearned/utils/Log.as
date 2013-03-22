package it.youearned.utils
{
	public final class Log
	{
		public static function info(message:String):void
		{
			trace("[INFO]", message);
		}
		public static function error(message:String):void
		{
			trace("[ERROR]", message);
		}
	}
}