package org.glomaker.plugin.swfloader
{
	import flash.events.Event;
	import flash.net.LocalConnection;

	public class CustomLocalConnection extends LocalConnection
	{
		public static const PING:String = "ping";
		
		public function CustomLocalConnection(connectionName:String)
        {
            try
            {
                connect(connectionName);
            }
            catch (error:ArgumentError)
            {
                // server already created/connected
            }
        }
        public function loaded():void
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }
        
        public function ping():void
        {
            dispatchEvent(new Event(PING));
        }
		
	}
}