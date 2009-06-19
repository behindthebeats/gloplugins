package org.glomaker.plugin.accessviews
{
	public class SpeakerData
	{
		[Bindable]
		[Embed(source="files/NoFace.jpg")]
		protected var noface:Class;
			
		[Bindable]
		public var title:String;
		
		[Bindable]
		public var imageSource:String = "http://www.interloc.org/NoFace.jpg";
		
		public function SpeakerData(t:String)
		{
			title = t;
		}

	}
}