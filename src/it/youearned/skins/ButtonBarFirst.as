package it.youearned.skins
{
	import flash.system.Capabilities;
	
	import mx.core.DPIClassification;
	
	import spark.skins.mobile.ButtonBarFirstButtonSkin;
	
	public class ButtonBarFirst extends ButtonBarFirstButtonSkin
	{
		public function ButtonBarFirst()
		{
			super();
			switch(Capabilities.screenDPI)
			{
				case DPIClassification.DPI_320:
				{	
					upBorderSkin = LayoutImages.ButtonBar1;
					downBorderSkin = LayoutImages.ButtonBar1Selected;
					selectedBorderSkin = LayoutImages.ButtonBar1Selected;
					break;
				}
					
				default:
				{
					upBorderSkin = LayoutImages.ButtonBar1Standard;
					downBorderSkin = LayoutImages.ButtonBar1StandardSelected;
					selectedBorderSkin = LayoutImages.ButtonBar1StandardSelected;
					break;
				}
			}
		}		
	}
}