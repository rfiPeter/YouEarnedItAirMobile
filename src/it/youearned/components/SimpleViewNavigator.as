package it.youearned.components
{
	import com.greensock.TweenLite;
	
	import flash.utils.getDefinitionByName;
	
	import it.youearned.model.AppModel;
	import it.youearned.views.LoginView;
	
	import mx.core.IVisualElement;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	import spark.components.View;
	import spark.components.supportClasses.ViewNavigatorBase;
	import spark.transitions.ViewTransitionBase;

	public final class SimpleViewNavigator extends Group
	{
		private var model:AppModel = AppModel.getInstance();
		
		public var firstView:Class;
		
		public function SimpleViewNavigator()
		{
			addEventListener(FlexEvent.ADD, onReady);
		}
		
		protected function onReady(event:FlexEvent):void
		{
			if (firstView)
				pushView(firstView);
		}
		
		private var _firstView:IVisualElement;
		
		private var _currentView:IVisualElement;
		public function get currentView():IVisualElement
		{
			return _currentView;
		}
		
		private var _previousViews:Vector.<IVisualElement> = new Vector.<IVisualElement>;
		private var _previousTransitions:Vector.<Object> = new Vector.<Object>;
		
		public function pushView(view:Class, data:Object = null, transition:Object = null):void
		{		
			if (_currentView is view) {
				return;
			}
			
			
			var v:* = new view();
			v.data = data;
								
			if (_currentView == null) {
				_firstView = v;
				_currentView = v;
				_previousViews.push(v);
				addElement(v);
			}
			else {
				
				for each (var ve:IVisualElement in _previousViews) {
					if (ve is view) {
						v = ve;
						break;
					}
				}				
				
				var p:IVisualElement = _currentView;
				_previousViews.push(p);
				_currentView = v;
								
				if (transition) {
					transitionView(transition, _currentView, p);
				}
				else {
					transitionView({type:"slide",direction:"left"},_currentView,p);
				}
				_previousTransitions.push(transition);
			}			
		}	
		
		public function replaceView(view:Class, data:Object = null, transition:Object = null):void
		{
			if (_currentView is view) {
				return;
			}
			
			var v:* = new view();
			v.data = data;
						
			if (_currentView == null) {
				_firstView = v;
				_currentView = v;
				_previousViews.push(v);
				addElement(v);
			}
			else {
				// take my current view, transition it away and remove from the stack...
				var curr:IVisualElement = _previousViews.pop();
				_currentView = v;
				
				if (transition) {
					transitionView(transition, _currentView, curr, false);
				}
				else {
					transitionView({type:"slide",direction:"left"}, _currentView, curr, false);
				}
				
			}
		}
		
		public function popView():void
		{
			var prev:Object = _previousTransitions.pop();
			var newView:IVisualElement = _previousViews.pop();
			var oldView:IVisualElement = _currentView;
			
			if (!newView)
				return;
			
			if (!prev) {
				prev = {type:"slide",direction:"right"};
			}
			
			switch (prev.direction) {
				case "left":
					prev.direction = "right";
					break;
				case "right":
					prev.direction = "left";
					break;
				case "up":
					prev.direction = "down";
					break;
				case "down":
					prev.direction = "up";
					break;
			}
			switch (prev.type) {
				case "cover":
					prev.type = "uncover";
					break;
				case "uncover":
					prev.type = "cover";
					break;
			}
			
			
			
			var obj:Object = new Object();
			switch (prev.type)
			{
				case "uncover":
					switch (prev.direction) {
						case "left":
							obj.x = -model.width;
							break;
						case "right":
							obj.x = model.width;
							break;
						case "up":
							obj.y = -model.height;
							break;
						case "down":
							obj.y = model.height;
							break;
					}
					
					obj.onComplete = destroyView;
					obj.onCompleteParams = [oldView,newView];
					
					TweenLite.to(oldView,.4,obj);
					break;					
				case "cover":
					switch (prev.direction) {
						case "left":
							newView.x = model.width;
							break;
						case "right":
							newView.x = -model.width;
							break;
						case "up":
							newView.y = model.height;
							break;
						case "down":
							newView.y = -model.height;
							break;
					}
					obj.x = 0;
					obj.y = 0;
					obj.onComplete = destroyView;
					obj.onCompleteParams = [oldView,newView];
					TweenLite.to(newView,.4,obj);
					break;
				case "slide":
					var obj2:Object = new Object;
					switch (prev.direction) {
						case "left":
							obj2.x = -model.width;
							break;
						case "right":
							obj2.x = model.width;
							break;
						case "up":
							obj2.y = -model.height;
							break;
						case "down":
							obj2.y = model.height;
							break;
					}
					obj.x = obj.y = 0;
					obj2.onComplete = destroyView;
					obj2.onCompleteParams = [oldView,newView];
					TweenLite.to(newView,.4,obj);
					TweenLite.to(oldView,.4,obj2);
					break;
			}
			
			
		}
		
		public function popAll():void
		{
			while (_previousViews.length != 0) {
				_previousViews.pop();
				_previousTransitions.pop();
			}
			
			removeAllElements();
			
			_currentView = null;
		}
		
		/**
		 * The <code>newView</code> object has not been added to the stage yet.  At this point <code>oldView</code> is visible on the stage.  This function will switch the views.
		 * @param t The transition
		 * @param newView The new view to show
		 * @param oldView The old view we're hiding
		 * 
		 */
		private function transitionView(t:Object, newView:IVisualElement, oldView:IVisualElement, destroyPrevious:Boolean = false):void
		{
			if (t == null) {
				t = {type:"slide",direction:"left"};
			}
			
			var obj:Object = new Object();
			switch (t.type)
			{
				case "uncover":
					addElementAt(newView,getElementIndex(oldView));
					if (!t.direction)
						t.direction = "left";
					switch (t.direction) {
						case "left":
							obj.x = -model.width;
							break;
						case "right":
							obj.x = model.width;
							break;
						case "up":
							obj.y = -model.height;
							break;
						case "down":
							obj.y = model.height;
							break;
					}
					if (destroyPrevious) {
						obj.onComplete = destroyView;
						obj.onCompleteParams = [oldView];
					}
					callLater(TweenLite.to,[oldView,.4,obj]);
					break;					
				case "cover":
					if (!t.direction)
						t.direction = "left";
					switch (t.direction) {
						case "left":
							newView.x = model.width;
							break;
						case "right":
							newView.x = -model.width;
							break;
						case "up":
							newView.y = model.height;
							break;
						case "down":
							newView.y = -model.height;
							break;
					}
					obj.x = 0;
					obj.y = 0;
					if (destroyPrevious) {
						obj.onComplete = destroyView;
						obj.onCompleteParams = [oldView];
					}
					addElementAt(newView,getElementIndex(oldView)+1);
					callLater(TweenLite.to,[newView,.4,obj]);
					break;
				case "slide":
					var obj2:Object = new Object;
					if (!t.direction)
						t.direction = "left";
					switch (t.direction) {
						case "left":
							newView.x = model.width;
							obj2.x = -model.width;
							break;
						case "right":
							newView.x = -model.width;
							obj2.x = model.width;
							break;
						case "up":
							newView.y = model.height;
							obj2.y = -model.height;
							break;
						case "down":
							newView.y = -model.height;
							obj2.y = model.height;
							break;
					}
					obj.x = obj.y = 0;
					addElement(newView);
					if (destroyPrevious) {
						obj2.onComplete = destroyView;
						obj2.onCompleteParams = [oldView];
					}
					callLater(TweenLite.to,[newView,.4,obj]);
					if (oldView)
						callLater(TweenLite.to,[oldView,.4,obj2]);
					break;
			}
		}
		
		private function destroyView(view:IVisualElement, newView:IVisualElement = null):void
		{
			try {
				removeElement(view);
			} catch (e:Error) {
				// view doesn't exist...
			}
			
			view = null;
			
			if (newView)
				_currentView = newView;
		}
		
		
	}
}