package it.youearned.utils
{
	import it.youearned.model.AppModel;
	
	import mx.events.FlexEvent;
	
	import spark.effects.easing.IEaser;
	import spark.transitions.SlideViewTransition;
	import spark.transitions.ViewTransitionBase;

	public final class TransitionUtil
	{
		
		public static function buildTransition(direction:String, mode:String, easer:IEaser = null):ViewTransitionBase
		{
			var v:SlideViewTransition = new SlideViewTransition();
			v.direction = direction;
			v.mode = mode;
			v.easer = easer;
			v.addEventListener(FlexEvent.TRANSITION_START, onStart);
			v.addEventListener(FlexEvent.TRANSITION_END, onEnd);
			return v;
		}
		
		protected static function onEnd(event:FlexEvent):void
		{
			(event.currentTarget as SlideViewTransition).removeEventListener(FlexEvent.TRANSITION_END, onEnd);
			AppModel.getInstance().animating = false;
		}
		
		protected static function onStart(event:FlexEvent):void
		{
			(event.currentTarget as SlideViewTransition).removeEventListener(FlexEvent.TRANSITION_START, onStart);
			AppModel.getInstance().animating = true;
		}
	}
}