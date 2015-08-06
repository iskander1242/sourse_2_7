/**
 * Created by designer4 on 13.07.14.
 */
package view.ChangePassword {

import flash.events.MouseEvent;

import org.osflash.signals.Signal;

import spark.components.TextInput;
import spark.components.TitleWindow;
import spark.components.supportClasses.SkinnableComponent;

import view.numpad.NumpadEvent;

public class ChangePasswordComponent extends SkinnableComponent {

	public var popupWindow:TitleWindow;

	[Bindable]
	public var oldPassword:String;

	[Bindable]
	public var newPassword:String;

	[Bindable]
	public var confirmPassword:String;

	public var activeTextInput:TextInput;

	public var onResetSignal:Signal = new Signal();
	public var onSubmitSignal:Signal = new Signal();
	public var onCancelSignal:Signal = new Signal();

	public function ChangePasswordComponent() {
		this.setStyle("skinClass", ChangePasswordSkin);
	}

	public function numpadEventHandler(e:NumpadEvent):void {
		switch(e.value) {
			case "Сброс":
			{
				onResetSignal.dispatch();
				break;
			}
			case "Ввод":
			{
				onSubmitSignal.dispatch();
				break;
			}
			default :
			{
				activeTextInput.text += e.value;
				break;
			}
		}
	}

	public function submitHandler(e:MouseEvent):void{
		onSubmitSignal.dispatch();
	}

	public function cancelHandler(e:MouseEvent):void{
		onCancelSignal.dispatch();
	}


}
}
