/**
 * Created by designer4 on 08.07.14.
 */
package controller.commands.pincode {

import com.junkbyte.console.Cc;

import mx.events.CloseEvent;
import mx.managers.PopUpManager;

import org.osflash.signals.Signal;

import robotlegs.bender.bundles.mvcs.Command;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.viewManager.api.IViewManager;

import spark.components.TitleWindow;

import view.pincodePopup.PincodePopupComponent;

public class OpenPincodeCommand extends Command {

	[Inject]
	public var param_request:Signal;

	[Inject]
	public var contextView:ContextView;

	[Inject]
	public var vm:IViewManager;

	public var popup:PincodePopupComponent;

	public function OpenPincodeCommand() {
	}

	override public function execute():void {
		Cc.log(this, "++++++++"+param_request);

		popup = new PincodePopupComponent();
		popup.onSuccessRequest = param_request;
		vm.addContainer(popup);

		var window:TitleWindow = new TitleWindow();
		window.title = "Введите пин-код";
		window.addEventListener(CloseEvent.CLOSE, closeHandler);
		window.addElement(popup);

		popup.popupWindow = window;

		PopUpManager.addPopUp(window, contextView.view, true);
		PopUpManager.centerPopUp(window);
	}

	private function closeHandler(e:CloseEvent):void {
		vm.removeContainer(popup);
		PopUpManager.removePopUp(e.target as TitleWindow);
	}
}
}
