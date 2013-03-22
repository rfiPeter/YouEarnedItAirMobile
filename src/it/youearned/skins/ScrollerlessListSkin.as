package it.youearned.skins
{
	import it.youearned.skins.PagedListScrollerSkin;
	
	import spark.events.IndexChangeEvent;
	import spark.events.RendererExistenceEvent;
	import spark.skins.mobile.ListSkin;
	import spark.skins.mobile.supportClasses.MobileSkin;
	
	public class ScrollerlessListSkin extends ListSkin
	{
		public function ScrollerlessListSkin()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			scroller.setStyle("skinClass", PagedListScrollerSkin);
		}
	}
	
	/*override protected function commitProperties():void
	{
		super.commitProperties();
	}
	
	override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
	{
		super.drawBackground(unscaledWidth, unscaledHeight);
	}
	
	override public function styleChanged(styleProp:String):void
	{
		super.styleChanged(styleProp);
	}*/
}