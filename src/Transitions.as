package
{
	import spark.transitions.SlideViewTransition;
	import spark.transitions.ViewTransitionDirection;

	[Bindable]
	public class Transitions
	{
		public static const test:int = 1;
		
		private var _slideUp:SlideViewTransition;

		public function test():int
		{
			return 1;
		}
		
		public function get slideUp():SlideViewTransition
		{
			if(!_slideUp) {
				_slideUp = new SlideViewTransition();
				_slideUp.direction = ViewTransitionDirection.UP;
			}
			return _slideUp;
		}
		
		private var _slideDown:SlideViewTransition;
		
		public function get slideDown():SlideViewTransition
		{
			if(!_slideUp) {
				_slideDown = new SlideViewTransition();
				_slideDown.direction = ViewTransitionDirection.DOWN;
			}
			return _slideDown;
		}

	}
}