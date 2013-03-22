package it.youearned.utils
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	
	import spark.filters.DropShadowFilter;
	import spark.filters.GlowFilter;

	public final class AssetUtil
	{		
		public static function getDropshadow(params:Object=null):DropShadowFilter
		{
			var ds:DropShadowFilter = new DropShadowFilter();
			if (params) {
				for (var key:String in params) {
					ds[key] = params[key];
				}
			}
			return ds;
		}
		public static function getGlowFilter():GlowFilter {
			var color:Number = 0x999999;
			var alpha:Number = 1;
			var blurX:Number = 3;
			var blurY:Number = 3;
			var strength:Number = 2;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.MEDIUM;
			return new GlowFilter(color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout);
		}
		public static function getCircle(width:Number,height:Number,rad:Number):Sprite
		{
			var circleSprite:Sprite=new Sprite();
			var g:Graphics = circleSprite.graphics;
			g.clear();
			g.beginFill(0);
			g.drawCircle(width, height, rad);
			g.endFill();
			return circleSprite;
		}
	}
}