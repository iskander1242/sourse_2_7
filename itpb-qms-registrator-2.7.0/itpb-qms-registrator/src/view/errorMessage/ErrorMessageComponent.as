/**
 * Created by designer4 on 14.07.14.
 */
package view.errorMessage {

import spark.components.supportClasses.SkinnableComponent;

public class ErrorMessageComponent extends SkinnableComponent {

	[Bindable]public var showErrorMessage:Boolean;
	[Bindable]public var errorMessage:String;


	public function ErrorMessageComponent() {
		this.setStyle("skinClass", ErrorMessageSkin);
	}

}
}
