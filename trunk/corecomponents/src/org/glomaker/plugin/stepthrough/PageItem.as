package org.glomaker.plugin.stepthrough
{
	/**
	 * Simple value-object class to store information about a page.
	 * This is used to make sure that we can use data in a list without creating duplicate items. 
	 * @author Nils
	 */
	public class PageItem
	{
		
		public var textValue:String = "";
		
		public function PageItem(textValue:String)
		{
			this.textValue = textValue;
		}

	}
}