/**
 * Created by designer4 on 13.07.14.
 */
package view.putCode {
import controller.requests.TakeTicketReqest;
import controller.signals.ShowPrintTicketSignal;

import spark.components.Alert;

import view.putCode.*;

import flash.events.MouseEvent;

import org.osflash.signals.Signal;

import spark.components.TextInput;
import spark.components.TitleWindow;
import spark.components.supportClasses.SkinnableComponent;

import view.numpad.NumpadEvent;

public class TypeCodeComponent extends SkinnableComponent {

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

	private var сommand:Function;

	public function  set setCommand(currentAction:Function):void{
		this.сommand=currentAction;
	}

	public function runCommand(){
		if (сommand is Function)this.сommand();
	}


	public function TypeCodeComponent() {
		this.setStyle("skinClass", TypeCodeSkin);
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
		Alert.show("submitHandler");
		onSubmitSignal.dispatch();
	}

	public function cancelHandler(e:MouseEvent):void{
		//onCancelSignal.dispatch();
        runCommand();
	}


}
}
