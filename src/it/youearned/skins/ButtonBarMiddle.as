package it.youearned.skins
{
	import flash.system.Capabilities;
	
	import mx.core.DPIClassification;
	
	import spark.skins.mobile.ButtonBarMiddleButtonSkin;
	
	public class ButtonBarMiddle extends ButtonBarMiddleButtonSkin
	{
		public function ButtonBarMiddle()
		{
			super();
			
			switch(Capabilities.screenDPI)
			{
				case DPIClassification.DPI_320:
				{	
					upBorderSkin = LayoutImages.ButtonBar2;
					downBorderSkin = LayoutImages.ButtonBar2Selected;
					selectedBorderSkin = LayoutImages.ButtonBar2Selected;
					break;
				}
					
				default:
				{
					upBorderSkin = LayoutImages.ButtonBar2Standard;
					downBorderSkin = LayoutImages.ButtonBar2StandardSelected;
					selectedBorderSkin = LayoutImages.ButtonBar2StandardSelected;
					break;
				}
			}
		}
	}
}