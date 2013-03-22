package com.rockfish.presenters
{
	import com.flexcapacitor.controls.WebView;
	import com.rockfish.components.ShareCalloutButton;
	import com.rockfish.model.AppModel;
	import com.rockfish.utils.StripHTML;
	
	import spark.components.Button;
	import spark.components.View;
	
	public class YouTubePresenter
	{
		private var model:AppModel = AppModel.getInstance();
		private static const htmlStart:String = '<iframe class="youtube-player" type="text/html" width="640" height="385" src="';
		private static const htmlEnd:String = '" frameborder="0"></iframe>';
		
		[Bindable]
		public var socialShare:Object = new Object();
		public var view:View;
		public var webView:WebView;
		public var shareButton:ShareCalloutButton;
		
		public function init():void {
			var link:String;
			var facebook:Object = new Object();
			var twitter:Object = new Object();
			var email:Object = new Object();
			trace("is string");
			trace(view.data is String);
			if(view.data is String == false) {
				link = "http://www.youtube.com/embed/" + view.data.id;
				trace("videoLink ", link);
				webView.source = link;
				if(!view.data.SocialContent) {
					facebook.ShareTitle = view.data.title;
					facebook.ShareCaption = "Romney Ryan 2012";
					facebook.ShareMessage = "";
					if(view.data.description) {
						var descriptionString:String = StripHTML.strip(view.data.description);
						facebook.ShareDescription = descriptionString.slice(0,100) + "...";
					}
					else {
						facebook.ShareDescription = "";
					}
					facebook.ShareURL = webView.source;
					twitter.Tweet = link + " #RomneyRyan2012";
					email.Subject = view.data.title;
					email.Content = webView.source;
					
					socialShare.Facebook = facebook;
					socialShare.Twitter = twitter;
					socialShare.Email = email;
				}
				else {
					socialShare = view.data.SocialContent;
				}
			}
			else {
				link = view.data.toString();
				trace(link);
				webView.source = view.data.toString();
				shareButton.visible = false;

				facebook.ShareTitle = "Watch the Video";
				facebook.ShareCaption = "Romney Ryan 2012";
				facebook.ShareMessage = "";
				facebook.ShareDescription = "";
				facebook.ShareURL = webView.source;
				twitter.Tweet = link + " #RomneyRyan2012";
				email.Subject = "Romney Ryan 2012";
				email.Content = webView.source;
				
				socialShare.Facebook = facebook;
				socialShare.Twitter = twitter;
				socialShare.Email = email;
			}
		}

	}
}