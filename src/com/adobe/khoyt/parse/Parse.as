package com.adobe.khoyt.parse
{
	import com.adobe.khoyt.parse.events.ParseEvent;
	import com.adobe.khoyt.parse.utils.Base64;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class Parse extends EventDispatcher
	{
		public static const PARSE_API:String = "https://api.parse.com/1/classes/";
		public static const JSON_CONTENT:String = "application/json";
		
		private var hold:Object = null;
		private var username:String = null;
		private var password:String = null;
		private var loader:URLLoader = null;
		
		public function Parse( username:String, password:String )
		{
			super();
			this.username = username;
			this.password = password;
		}
		
		public function count( className:String, where:String = null, count:Number = 1, limit:Number = 0 ):void
		{
			var authorization:String = null;
			var query:URLVariables = null;
			var request:URLRequest = null;	
			var header:URLRequestHeader = null;			

			query = new URLVariables();			
			query.count = count;
			query.limit = limit;			
			
			var js:JSON 
			
			if( where != null )
			{
				query.where = JSON.stringify(where);
			}
			
			authorization = Base64.encode( username + ":" + password );			
			header = new URLRequestHeader( "Authorization", "Basic " + authorization );						
			
			request = new URLRequest( PARSE_API + className );
			request.method = URLRequestMethod.GET;
			request.contentType = JSON_CONTENT;
			request.data = query;							
			request.requestHeaders.push( header );
			
			if( loader == null )
			{
				loader = new URLLoader();				
			}
			
			loader.addEventListener( Event.COMPLETE, doCountComplete );
			loader.load( request );			
		}
		
		public function create( className:String, value:Object ):void
		{
			var authorization:String = null;			
			var request:URLRequest = null;	
			var header:URLRequestHeader = null;			
			
			hold = value;
			
			authorization = Base64.encode( username + ":" + password );			
			header = new URLRequestHeader( "Authorization", "Basic " + authorization );						
			
			request = new URLRequest( PARSE_API + className );
			request.method = URLRequestMethod.POST;
			request.contentType = JSON_CONTENT;
			request.data = JSON.stringify( value );
			//request.data = JSON.encode( value );
			request.requestHeaders.push( header );
			
			if( loader == null )
			{
				loader = new URLLoader();				
			}

			loader.addEventListener( Event.COMPLETE, doCreateComplete );
			loader.load( request );			
		}
		
		public function read( className:String, objectId:String = ""):void
		{
			var authorization:String = null;			
			var request:URLRequest = null;	
			var header:URLRequestHeader = null;			
			
			authorization = Base64.encode( username + ":" + password );			
			header = new URLRequestHeader( "Authorization", "Basic " + authorization );						
			
			request = new URLRequest( PARSE_API + className + "/" + objectId );
			request.method = URLRequestMethod.GET;
			request.contentType = JSON_CONTENT;
			request.requestHeaders.push( header );
			
			if( loader == null )
			{
				loader = new URLLoader();				
			}
			loader.addEventListener( Event.COMPLETE, doReadComplete );
			loader.addEventListener( IOErrorEvent.IO_ERROR, doReadEError );
			loader.load( request );			
		}		
		
		protected function doReadEError(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace(event.text);
		}
		
		public function remove( className:String, objectId:String ):void
		{
			var authorization:String = null;			
			var request:URLRequest = null;	
			var header:URLRequestHeader = null;			
			
			authorization = Base64.encode( username + ":" + password );			
			header = new URLRequestHeader( "Authorization", "Basic " + authorization );						
			
			request = new URLRequest( PARSE_API + className + "/" + objectId );
			request.method = URLRequestMethod.DELETE;
			request.contentType = JSON_CONTENT;
			request.requestHeaders.push( header );
			
			if( loader == null )
			{
				loader = new URLLoader();				
			}
			
			loader.addEventListener( Event.COMPLETE, doRemoveComplete );
			loader.load( request );			
		}				
		
		public function search( className:String, where:Object = null, limit:Number = 100, skip:Number = 0 ):void
		{
			var authorization:String = null;
			var query:URLVariables = null;
			var request:URLRequest = null;	
			var header:URLRequestHeader = null;			
			
			query = new URLVariables();
			query.limit = limit;
			query.skip = skip;
			
			if( where != null )
			{
				query.where = JSON.stringify( where );
			}
			
			authorization = Base64.encode( username + ":" + password );			
			header = new URLRequestHeader( "Authorization", "Basic " + authorization );						
			
			request = new URLRequest( PARSE_API + className );
			request.method = URLRequestMethod.GET;
			request.contentType = JSON_CONTENT;
			request.data = query;				
			request.requestHeaders.push( header );
			
			if( loader == null )
			{
				loader = new URLLoader();				
			}
			
			loader.addEventListener( Event.COMPLETE, doSearchComplete );
			loader.load( request );			
		}						
		
		public function update( className:String, objectId:String, value:Object ):void
		{
			var authorization:String = null;			
			var request:URLRequest = null;	
			var header:URLRequestHeader = null;			
			
			authorization = Base64.encode( username + ":" + password );			
			header = new URLRequestHeader( "Authorization", "Basic " + authorization );						
			
			request = new URLRequest( PARSE_API + className + "/" + objectId );
			request.method = URLRequestMethod.PUT;
			request.contentType = JSON_CONTENT;
			request.data = JSON.stringify( value );
			request.requestHeaders.push( header );
			
			if( loader == null )
			{
				loader = new URLLoader();				
			}
			
			loader.addEventListener( Event.COMPLETE, doUpdateComplete );
			loader.load( request );			
		}				
		
		protected function doCountComplete( event:Event ):void
		{
			var dispatch:ParseEvent = null;
			var decode:Object = JSON.parse( loader.data );
			
			loader.removeEventListener( Event.COMPLETE, doCountComplete );
			
			dispatch = new ParseEvent( ParseEvent.COUNT );
			dispatch.value = decode.count;
			dispatchEvent( dispatch );			
		}
		
		protected function doCreateComplete( event:Event ):void
		{
			var dispatch:ParseEvent = null;
			var decode:Object = JSON.parse( loader.data );
			
			loader.removeEventListener( Event.COMPLETE, doCreateComplete );
			
			hold.createdAt = decode.createdAt;
			hold.objectId = decode.objectId;
			
			dispatch = new ParseEvent( ParseEvent.CREATE );
			dispatch.value = hold;
			dispatchEvent( dispatch );
		}
		
		protected function doReadComplete( event:Event ):void
		{
			var dispatch:ParseEvent = null;
			
			loader.removeEventListener( Event.COMPLETE, doReadComplete );
			
			dispatch = new ParseEvent( ParseEvent.READ );
			dispatch.value = JSON.parse( loader.data );
			dispatchEvent( dispatch );
		}
		
		protected function doRemoveComplete( event:Event ):void
		{
			loader.removeEventListener( Event.COMPLETE, doRemoveComplete );
			
			dispatchEvent( new ParseEvent( ParseEvent.REMOVE ) );
		}
		
		protected function doSearchComplete( event:Event ):void
		{
			var dispatch:ParseEvent = null;
			var decode:Object = JSON.parse( loader.data );
			
			loader.removeEventListener( Event.COMPLETE, doSearchComplete );
			
			dispatch = new ParseEvent( ParseEvent.SEARCH );
			dispatch.value = decode.results;
			dispatchEvent( dispatch );
		}
		
		protected function doUpdateComplete( event:Event ):void
		{
			var dispatch:ParseEvent = null;
			
			loader.removeEventListener( Event.COMPLETE, doUpdateComplete );
			
			dispatch = new ParseEvent( ParseEvent.UPDATE );
			dispatch.value = JSON.parse( loader.data );
			dispatchEvent( dispatch );
		}
	}
}