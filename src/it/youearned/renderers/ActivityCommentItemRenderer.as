package it.youearned.renderers
{
	import flash.display.Graphics;
	
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.LabelItemRenderer;
	import spark.primitives.Line;
	import spark.primitives.Rect;
	
	
	/**
	 * 
	 * ASDoc comments for this item renderer class
	 * 
	 */
	public class ActivityCommentItemRenderer extends LabelItemRenderer
	{
		[Embed('assets/images/default.png')]
		private var default_img:Class;
		
		[Embed('assets/images/TimeIcon.png')]
		private var time_icon:Class;
		
		
		public function ActivityCommentItemRenderer()
		{
			//TODO: implement function
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
			
//			super.createChildren();
			
//			var rect:Rect = new Rect;
//			rect.percentHeight = rect.percentWidth = 100;
//			rect.fill = new SolidColor(0xf1f1f1);
//			addChild(rect);
//			
//			var line:Line = new Line;
//			line.stroke = new SolidColorStroke(0x919597,1);
//			line.top = 0;
//			line.percentWidth = 100;
//			addChild(line);
			
			var bgProfileImg:Image = new Image;
			bgProfileImg.width = bgProfileImg.height = 31;
			bgProfileImg.left = bgProfileImg.top = 4;
			bgProfileImg.source = default_img;
			addChild(bgProfileImg);
			
			if (data.user.picture != null) {
				var profileImg:Image = new Image;
				profileImg.width = profileImg.height = 31;
				profileImg.left = profileImg.top = 4;
				profileImg.source = data.user.picture+"small";
				addChild(profileImg);
			}
			
			var sender:Label = new Label;
			sender.text = data.user.first_name+" "+data.user.last_name;
			sender.styleName = "RedTextStyle";
			sender.left = 42;
			sender.top = 6;
			sender.setStyle('fontSize',11);
			addChild(sender);
			
			var dateDiff:Label = new Label;
			dateDiff.text = "Date Diff";
			dateDiff.styleName = "DarkGrayTextStyle";
			dateDiff.top = 6;
			dateDiff.right = 16;
			addChild(dateDiff);
			
			var dateIcon:Image = new Image;
			dateIcon.source = time_icon;
			dateIcon.top = 5;
			dateIcon.right = 5;
			
			addChild(dateIcon);
			
			var msg:Label = new Label;
			msg.left = 43;
			msg.right = 10;
			msg.top = 22;
			msg.setStyle('fontSize',11);
			msg.text = data.message;
			msg.setStyle('paddingBottom',4);
			msg.styleName = "BrownTextStyle";
			
			addChild(msg);
			
			
			
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
			
			var lbl:Label = this.getChildAt(this.numChildren - 1) as Label;
			
			measuredHeight = lbl.y + lbl.height;
			measuredWidth = 43 + lbl.width + 10;
			
			measuredMinHeight = measuredHeight;
			measuredMinWidth = measuredWidth;
			
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
			var g:Graphics = this.graphics;
			g.beginFill(0xf1f1f1);
			g.drawRect(0,0,unscaledWidth,unscaledHeight);
			g.endFill();
			
			g.moveTo(0,0);
			g.beginFill(0x919597);
			g.lineTo(unscaledWidth,0);
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
//			super.layoutContents(unscaledWidth, unscaledHeight);
			// layout all the subcomponents here      		
		}
		
	}
}