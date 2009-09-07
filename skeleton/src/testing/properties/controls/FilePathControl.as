/////////////////////////////////////////////////////////////////////////
// Copyright (c) 2007-09 LTRI, London Metropolitan Uni. All rights reserved.
// An Open Source Release under the GPL v3 licence  (see http://www.gnu.org/licenses/).
// Authors: Tom Boyle, Nils Millahn, Musbah Sagar, Martin Agombar.
// See http://www.glomaker.org for full details
/////////////////////////////////////////////////////////////////////////

package testing.properties.controls
{
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.managers.PopUpManager;
	
	import org.glomaker.shared.component.interfaces.IComponentPlugin;
	import org.glomaker.shared.properties.FilePathProperty;
	import org.glomaker.shared.properties.IComponentProperty;

	public class FilePathControl extends Button implements IPropertyControl
	{

		protected var _prop:FilePathProperty;
		protected var _comp:IComponentPlugin;
		
		private var _popup:FakeFileBrowser;
		
		
		public function assignProperty(prop:IComponentProperty, component:IComponentPlugin):void
		{
			// save
			_prop = FilePathProperty(prop);
			_comp = component;
			
			// check correct property type 
			if(!_prop)
			{
				destroy();
				throw new Error("The PropertyField must be a FilePathProperty");
			}
				
			// initialise correctly
			// label
			label = "Browse...";
			
			// fakes the action of a file browser
			addEventListener(MouseEvent.CLICK, onClick);
			
		} 
		
		protected function onClick(evt:MouseEvent):void
		{
			_popup = PopUpManager.createPopUp(this, FakeFileBrowser, false) as FakeFileBrowser;
			_popup.x = 200;
			_popup.y = 200;
			_popup.addEventListener(MouseEvent.CLICK, onBrowserClick);
		}
		
		protected function onBrowserClick(evt:MouseEvent):void
		{
			if(evt.target is Button)
			{
				_prop.propValue = _popup.filePath;
				_comp.editablePropertyUpdated(_prop);
				_popup.remove();
			}
			
		}
		
		public function get property():IComponentProperty
		{
			return _prop;
		}
		
		public function get component():IComponentPlugin
		{
			return _comp;
		}
		
		public function destroy():void
		{
			
			_prop = null;
			_comp = null;
			removeEventListener(MouseEvent.CLICK, onClick);
			_popup.removeEventListener(MouseEvent.CLICK, onClick);
		}
		
	}
}