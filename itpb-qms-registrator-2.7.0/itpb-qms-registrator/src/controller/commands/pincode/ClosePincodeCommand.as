/**
 * Created by designer4 on 11.07.14.
 */
package controller.commands.pincode {

import com.junkbyte.console.Cc;

import controller.utils.ModelUtils;

import mx.managers.PopUpManager;

import robotlegs.bender.bundles.mvcs.Command;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.viewManager.api.IViewManager;

import view.pincodePopup.PincodePopupComponent;

public class ClosePincodeCommand extends Command {

	[Inject]
	public var vm:IViewManager;

	public function ClosePincodeCommand() {
		super();
	}

	override public function execute():void {
		Cc.log(this);

		var popup:PincodePopupComponent = ModelUtils.getContainerByClass(vm, PincodePopupComponent) as PincodePopupComponent;
		vm.removeContainer(popup);

		PopUpManager.removePopUp(popup.popupWindow);
	}
}
}
