package it.youearned.skins
{
	import spark.skins.mobile.ButtonBarSkin;
	
	public final class YEIButtonBarSkin extends ButtonBarSkin
	{
		public function YEIButtonBarSkin()
		{
			super();			
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			if (firstButton) {
				firstButton.skinClass = ButtonBarFirst;
				firstButton.properties = {width: "100", height: "48"};
			}
			if (lastButton) {
				lastButton.skinClass = ButtonBarLast;
				lastButton.properties = {width: "100", height: "48"};
			}
			if (middleButton) {
				middleButton.skinClass = ButtonBarMiddle;
				middleButton.properties = {width: "100", height: "48"};
			}
		}
	}
}