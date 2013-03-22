package it.youearned.skins
{
	import mx.core.DPIClassification;
	import flash.system.Capabilities;
	
	import spark.skins.mobile.ButtonBarLastButtonSkin;
	
	public class ButtonBarLast extends ButtonBarLastButtonSkin
	{
		public function ButtonBarLast()
		{
			super();
			
			switch(Capabilities.screenDPI)
			{
				case DPIClassification.DPI_320:
				{	
					upBorderSkin = LayoutImages.ButtonBar3;
					downBorderSkin = LayoutImages.ButtonBar3Selected;
					selectedBorderSkin = LayoutImages.ButtonBar3Selected;
					break;
				}
					
				default:
				{
					upBorderSkin = LayoutImages.ButtonBar3Standard;
					downBorderSkin = LayoutImages.ButtonBar3StandardSelected;
					selectedBorderSkin = LayoutImages.ButtonBar3StandardSelected;
					break;
				}
			}
		}
	}
}