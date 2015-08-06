/**
 * Created by designer4 on 08.07.14.
 */
package view.pincodePopup {

import org.osflash.signals.Signal;

import spark.components.TitleWindow;

import spark.components.supportClasses.SkinnableComponent;
import spark.events.TextOperationEvent;

import view.numpad.NumpadEvent;

public class PincodePopupComponent extends SkinnableComponent {

	[Bindable]
	public var pincodeText:String = "";

	[Bindable]
	public var title:String = "Введите пин-код";

	public var popupWindow:TitleWindow;

	public var onSuccessRequest:Signal;

	public var onResetSignal:Signal = new Signal();
	public var onSubmitSignal:Signal = new Signal();

	public function PincodePopupComponent() {
		this.setStyle("skinClass", PincodePopupSkin);
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
				pincodeText += e.value;
				break;
			}
		}
	}

	public function passChangeHandler(e:TextOperationEvent):void {
		pincodeText = e.target.text;
	}
}
}
