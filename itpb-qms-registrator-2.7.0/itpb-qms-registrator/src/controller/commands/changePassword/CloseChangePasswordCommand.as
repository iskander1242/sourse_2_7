/**
 * Created by designer4 on 14.07.14.
 */
package controller.commands.changePassword {

import com.junkbyte.console.Cc;

import controller.utils.ModelUtils;

import mx.managers.PopUpManager;

import robotlegs.bender.bundles.mvcs.Command;
import robotlegs.bender.extensions.viewManager.api.IViewManager;

import view.ChangePassword.ChangePasswordComponent;

public class CloseChangePasswordCommand extends Command {

	[Inject]
	public var vm:IViewManager;

	public function CloseChangePasswordCommand() {
	}


	override public function execute():void {
		Cc.log(this);

		var popup:ChangePasswordComponent = ModelUtils.getContainerByClass(vm, ChangePasswordComponent) as ChangePasswordComponent;
		vm.removeContainer(popup);

		PopUpManager.removePopUp(popup.popupWindow);
	}
}
}
