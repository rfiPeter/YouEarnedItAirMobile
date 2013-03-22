package it.youearned.model
{
	import flash.net.SharedObject;
	import spark.core.ContentCache;
	
	public final class ImageCache
	{
		//Shared Object for storing user settings
		
		public var Cache:ContentCache = new ContentCache();
		
		
		public function ImageCache()
		{
			Cache.enableCaching = true;
			Cache.maxCacheEntries = 120;
		}
	}
}