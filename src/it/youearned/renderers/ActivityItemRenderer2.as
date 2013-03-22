package it.youearned.renderers
{
	import it.youearned.model.AppModel;
	import it.youearned.utils.AssetUtil;
	
	import mx.graphics.SolidColor;
	
	import spark.components.Group;
	import spark.components.LabelItemRenderer;
	import spark.primitives.Rect;
	
	
	/**
	 * 
	 * ASDoc comments for this item renderer class
	 * 
	 */
	public class ActivityItemRenderer2 extends LabelItemRenderer
	{
		private var model:AppModel = AppModel.getInstance();
		
		public function ActivityItemRenderer2()
		{
			super();
		}
		
		/**
		 * @private
		 *
		 * Override this setter to respond to data changes
		 */
		override public function set data(value:Object):void
		{
			super.data = value;
			// the data has changed.  push these changes down in to the 
			// subcomponents here    		
		} 
		
		/**
		 * @private
		 * 
		 * Override this method to create children for your item renderer 
		 */	
		override protected function createChildren():void
		{
			super.createChildren();
			// create any additional children for your item renderer here
			
			var bg:Group = new Group;
			bg.left = 10;
			bg.right = 10;
			bg.top = 10;
			bg.bottom = 10;
			
			var r:Rect = new Rect;
			r.percentHeight = r.percentWidth = 100;
			r.fill = new SolidColor(0xffffff);
			bg.addElement(r);
			
			bg.filters = [AssetUtil.getDropshadow({distance:4,angle:45,color:0x666666,alpha:.25})];
			
		}
		
		/**
		 * @private
		 * 
		 * Override this method to change how the item renderer 
		 * sizes itself. For performance reasons, do not call 
		 * super.measure() unless you need to.
		 */ 
		override protected function measure():void
		{
//			super.measure();
			// measure all the subcomponents here and set measuredWidth, measuredHeight, 
			// measuredMinWidth, and measuredMinHeight 
			
			measuredWidth = model.width;
			measuredHeight = 45;
			
			measuredMinWidth = model.width;
			measuredMinHeight = 45;
			
		}
		
		/**
		 * @private
		 * 
		 * Override this method to change how the background is drawn for 
		 * item renderer.  For performance reasons, do not call 
		 * super.drawBackground() if you do not need to.
		 */
		override protected function drawBackground(unscaledWidth:Number, 
												   unscaledHeight:Number):void
		{
			super.drawBackground(unscaledWidth, unscaledHeight);
			// do any drawing for the background of the item renderer here      		
		}
		
		/**
		 * @private
		 *  
		 * Override this method to change how the background is drawn for this 
		 * item renderer. For performance reasons, do not call 
		 * super.layoutContents() if you do not need to.
		 */
		override protected function layoutContents(unscaledWidth:Number, 
												   unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			// layout all the subcomponents here      		
		}
		
	}
}