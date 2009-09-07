/////////////////////////////////////////////////////////////////////////
// Copyright (c) 2007-09 LTRI, London Metropolitan Uni. All rights reserved.
// An Open Source Release under the GPL v3 licence  (see http://www.gnu.org/licenses/).
// Authors: Tom Boyle, Nils Millahn, Musbah Sagar, Martin Agombar.
// See http://www.glomaker.org for full details
/////////////////////////////////////////////////////////////////////////

package testing.properties.controller
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import testing.properties.PropertiesPanelMediator;

	/**
	 * Creates Mediator instances for the application and registers them with the facade. 
	 * @author Nils
	 */	
	public class InitialiseMediatorsCommand extends BaseCommand
	{
		/**
		 * @inheritDoc 
		 * @param notification Expects the main application instance in the Body.
		 */
		override public function execute(notification:INotification):void
		{
			var appRef:SkeletonGLOProject = notification.getBody() as SkeletonGLOProject;
			
			// test correct body
			if(!appRef)
				throw new Error("Notification body must be the main application instance.");
			
			// mediator for the main application
			// all other mediators are added by this class when startup has completed
			//facade.registerMediator(new GLOMakerMediato(appRef));
			facade.registerMediator(new PropertiesPanelMediator(appRef.panel));
		}
		
	}
}