/////////////////////////////////////////////////////////////////////////
// Copyright (c) 2007-09 LTRI, London Metropolitan Uni. All rights reserved.
// An Open Source Release under the GPL v3 licence  (see http://www.gnu.org/licenses/).
// Authors: Tom Boyle, Nils Millahn, Musbah Sagar, Martin Agombar.
// See http://www.glomaker.org for full details
/////////////////////////////////////////////////////////////////////////

package testing.properties.core
{
	import mx.core.Application;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import testing.properties.controller.startup.AppStartupMacroCommand;

	/**
	 * PureMVC Facade implementation for GLO-Maker
	 * 
	 * Implements the Singleton interface.
	 *  
	 * @author Nils
	 */
	public class GLOMakerFacade extends Facade
	{


		/**
		 * Return multiton instance. 
		 * @return 
		 */
		public static function getInstance(key:String):GLOMakerFacade
		{
			if(!hasCore(key))
			{
				instanceMap[key] = new GLOMakerFacade(key);
			}
			
			return instanceMap[key] as GLOMakerFacade;
		}
		
		public function GLOMakerFacade(key:String)
		{
			super(key);
		}


		/**
		 * Application startup function.
		 * @param appRef Reference to the main application instance.
		 */
		public static function start(appKey:String, appRef:Application):void
		{
			getInstance(appKey).sendNotification(Notifications.APP_START, appRef);
		}
		
		
		override protected function initializeController():void
		{
			super.initializeController();
			
			// startup command
			// Note: No Mediators registered at this stage
			registerCommand(Notifications.APP_START, AppStartupMacroCommand);
			
			// application invoke
			//registerCommand(Notifications.APP_INVOKE, HandleAppInvokeCommand);
			
		}
		
	}
}