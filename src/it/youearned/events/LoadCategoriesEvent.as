package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	public final class LoadCategoriesEvent extends BaseEvent
	{
		public static const LOAD_CATEGORIES:String = "it.youearned.events.loadCategories";
		public function LoadCategoriesEvent()
		{
			super(LOAD_CATEGORIES);
		}
	}
}