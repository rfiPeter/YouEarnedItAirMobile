package it.youearned.events
{
	import com.rockfish.events.BaseEvent;
	
	import it.youearned.api.services.valueObjects.AddCommentObject;
	import it.youearned.api.services.valueObjects.SimpleComment;
	
	public final class AddCommentEvent extends BaseEvent
	{
		public static const ADD_COMMENT:String = "it.youearned.events.addComment";
		public var comment:AddCommentObject;
		public function AddCommentEvent(comment:AddCommentObject)
		{
			super(ADD_COMMENT);
			this.comment = comment;
		}
	}
}