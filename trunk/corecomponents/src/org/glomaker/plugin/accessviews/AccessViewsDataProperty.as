package org.glomaker.plugin.accessviews
{
	import com.adobe.serialization.json.JSON;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	import org.glomaker.shared.properties.AbstractCustomProperty;

	public class AccessViewsDataProperty extends AbstractCustomProperty
	{
		
		[Bindable]
        public var _topics:ArrayCollection;
            
        [Bindable]
        public var _speakers:ArrayCollection;



		public function AccessViewsDataProperty(name:String, label:String=null, value:Object=null)
		{
			super(name, label, value);
			
			_topics = new ArrayCollection(["Topic 1"]);
			_speakers = new ArrayCollection([new SpeakerData("Speaker 1")]);
		}
		
		public function addSpeaker():void{
			
			_speakers.addItem(new SpeakerData("Speaker " + (_speakers.length+1))); 
			               
		}
		
		public function addTopic():void{
			
			_topics.addItem("Topic " + (_topics.length+1)); 
			               
		}
		
		override public function serialiseToXML(parentNode:XML):void{

			 
			 
/* 
			var mySounds:Array = ["file1.mp3", "file2.mp3"];

			<speaker title={titleVar}>

 */
			//var tag:XML = <topics isPath="true">{JSON.encode(topics.toArray());}</topics>;
			
			// serialise speakers
		    for each(var speaker:SpeakerData in _speakers){
				var tag:XML = <speaker title={JSON.encode(speaker.title)}></speaker>;
				tag.appendChild(serialiseFilePath(speaker.imageSource,"image"));
				parentNode.appendChild( tag );
			}
			
			// serialise topics
			var topics:XML = <topics>{JSON.encode(_topics.toArray())}</topics>;
			parentNode.appendChild( topics );
			
			
			 
			// will produce:
			// <sounds isPath="true">["file1.mp3","file2.mp3"]</sounds>
			
			
			 

		} 
		
		override public function deserialiseFromXML(value:XML):void{
		/* 	
			value.sounds.@isPath
			value.sounds :XMLList
			
			// coerced into XMLList
			for each(var speaker:XML in value.speakers)
			{
				
			}
			
			// coerced into string
			var mySoundsArray:Array = JSON.decode(value.sounds);
			 */
			
			_topics = new ArrayCollection(JSON.decode(value.topics));
			_speakers = new ArrayCollection();
			
			for each(var speaker:XML in value.speaker){
				var sData:SpeakerData = new SpeakerData(JSON.decode(speaker.@title));
				//sData.imageSource = deserialiseFilePath(speaker.image);
				_speakers.addItem(sData);

				Alert.show(speaker.image);
			}
			
			
		}
		

	}
}