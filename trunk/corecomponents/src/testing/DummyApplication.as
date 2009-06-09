package testing
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import mx.containers.HBox;
	import mx.controls.Label;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	
	import org.glomaker.shared.component.interfaces.IComponentControl;
	import org.glomaker.shared.component.interfaces.IComponentPlugin;
	import org.glomaker.shared.component.plugincontrols.BaseComponentControl;
	import org.glomaker.shared.component.plugincontrols.PluginTextInputControl;
	import org.glomaker.shared.properties.FilePathField;
	import org.glomaker.shared.properties.IntegerField;
	import org.glomaker.shared.properties.NumberField;
	import org.glomaker.shared.properties.StringField;
	
	/**
	 * For testing purposes only. Fakes the main app to test components.
	 * @author USER
	 * 
	 */
	public class DummyApplication
	{
		// ref to component
		private var _component:IComponentPlugin;
		private var _properties:Array;
		private var _appRef:CoreComponents;
		private var _editor:PropertiesEditor;
		
		public static const COMPONENT_CLICK:String = "Component.Click";
		
		public function DummyApplication(component:IComponentPlugin, appRef:CoreComponents)
		{
			// intitialise
			_component = component;
			_appRef = appRef;
			_editor = new PropertiesEditor();
			
			// add editor to page
			_appRef.addChild(_editor);
			
			// position it at the bottom-left of the page, for now
			_editor.setStyle("bottom", 0);
			_editor.setStyle("left", 0);
			
			// end of editor
			
			// add event listener to component
			_component.addEventListener(COMPONENT_CLICK, onComponentClick);
		}
		
		/**
		 * Handle when user clicks on the component. 
		 * @param evt
		 * 
		 */
		protected function onComponentClick(evt:Event):void
		{
 			// get property collection

			//var pc:PropertyCollection = (evt.target as IComponentPlugin).getProperties();
			
			// get properties
			//_properties = pc.getProperties(_component) as Array;
			
			// process the data
			processFields(); 
 	}
			 
		/**
		 * Split the properties data for further processing. 
		 * 
		 */
		protected function processFields():void
		{
			_editor.removeAllChildren();
			
			// process the incoming property fields
			for(var i:uint=0; i<_properties.length; i++)
			{
				if(_properties[i] as NumberField)
				{
					processNumberField(_properties[i]);
				}
				
				if(_properties[i] as FilePathField)
				{
					processFilePathField(_properties[i]);
				}
				
				if(_properties[i] as StringField)
				{
					processStringField(_properties[i]);
				}
				
				if(_properties[i] as IntegerField)
				{
					processIntegerField(_properties[i]);
				}
			}
		}
		protected function processNumberField(field:NumberField):void
		{
			// we need to create a field into which numbers can be displayed and edited
			// the first four relate to width, height, x and y
			// first problem, we don't know how big the numbers are! That makes
			// a difference to the type of control needed. And what about decimals?
			
			// to begin, let's assume they are integers less than a thousand. We could use a NumericStepper
			var ti:TextInput = new TextInput();
			ti.width = 100;
			ti.text = field.value;
				
			// put TextInput in the Panel component, with a label
			var container:HBox = makeLabelledField(ti, field.label);
			
			_editor.addChild(container);
		
		}
		
		protected function processIntegerField(field:IntegerField):void
		{
			// NILS: removed some of this code as the min/max properties have now been removed

			// small numbers (0-100) can be handled by a numeric stepper
			// larger numbers, or -ve numbers should be handled by a text field
			//var propertyField:IComponentControl;
			
			// if(field.min >= 0 && field.max <= 100)
			// {
				//propertyField = new PluginNumericStepper();
				// create numeric stepper
				//var ns:NumericStepper = new NumericStepper();
				
				// intialise
				//ns.minimum = field.min;
				//ns.maximum = field.max;
				//ns.value = _component[field.propName];
				//ns.styleName = "componentField";
				
				// we need to know when to submit the data to the component
				// focus out is used
				//ns.addEventListener(FocusEvent.FOCUS_OUT, onSmallIntChange);
				
				// make sure this field has a name relating to its property type
				//ns.name = field.propName;
				
				// put steppers in the Panel component, with a label
				//var container:HBox = makeLabelledField(ns, field.label);
		// 	}else
		//	{
				// we need to use a text input
				var t:PluginTextInputControl = new PluginTextInputControl();
				t.pluginPropertyValue = String(_component[field.propName]);
				//t.styleName = "componentField";

				// detect focus events on component
				//t.addEventListener(FocusEvent.FOCUS_OUT, onLargeIntChange);
				t.addEventListener(BaseComponentControl.COMMIT_PROPERTY, onLargeIntChange);
				
				// make sure this field has a name relating to its property type
				t.pluginPropertyName = field.propName;
				
				// put text field in the Panel component, with a label
				var container:HBox = makeLabelledField(t, field.label);
		//	}
			
			_editor.addChild(container);
		}
		
		protected function onSmallIntChange(evt:FocusEvent):void
		{
			trace(evt);
		}
		
		/**
		 * Responds to a component property losing focus. 
		 * @param evt
		 * 
		 */
		protected function onLargeIntChange(evt:Event):void
		{
			var propertyField:IComponentControl = evt.currentTarget as PluginTextInputControl;

			var propName:String = propertyField.pluginPropertyName;
			trace(propName, propertyField.pluginPropertyValue);
			_component[propName] = propertyField.pluginPropertyValue; 
		}
		protected function onStringChange(evt:Event):void
		{
			/* var propertyField:IComponentControl = evt.currentTarget as PluginTextInputControl;
			//var text:String = 
			var propName:String = propertyField.pluginPropertyName;
			
			_component[propName] = propertyField.pluginPropertyValue; */
		}
		protected function processFilePathField(field:FilePathField):void
		{
			
		}
		
		protected function processStringField(field:StringField):void
		{
			var t:TextInput = new TextInput();
			t.text = field.value;
			var container:HBox = makeLabelledField(t, field.label);
			
			// detect focus events on component
			t.addEventListener(FocusEvent.FOCUS_OUT, onStringChange);
			
			// make sure this field has a name relating to its property type
			t.name = field.propName;
			
			_editor.addChild(container);
		}
		/**
		 * Make an HBox to contain label and component. 
		 * @param component
		 * @param text
		 * @return 
		 * 
		 */
		protected function makeLabelledField(component:UIComponent, text:String):HBox
		{
			var container:HBox = new HBox();
			var label:Label = new Label();
			label.text = text;
			
			container.addChild(label);
			container.addChild(component);
			
			return container;
		}
		/* public function loadPropertyFields():void
		{
			
		} */

	}
}