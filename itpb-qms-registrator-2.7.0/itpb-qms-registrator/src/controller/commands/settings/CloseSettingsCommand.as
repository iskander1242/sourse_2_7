/**
 * Created by designer4 on 12.07.14.
 */
package controller.commands.settings {

import controller.requests.pincode.OpenPincodeRequest;
import controller.requests.settings.CloseSettingsRequest;
import controller.requests.settings.RevertSettingsRequest;
import controller.requests.settings.SaveSettingsRequest;
import controller.utils.ModelUtils;

import model.SavedSettings;

import mx.managers.PopUpManager;

import robotlegs.bender.bundles.mvcs.Command;
import robotlegs.bender.extensions.viewManager.api.IViewManager;

import view.settings.SettingsComponent;

public class CloseSettingsCommand extends Command {


	[Inject]
	public var param_save:Boolean;

	[Inject]
	public var savedSettings:SavedSettings;

	[Inject]
	public var vm:IViewManager;

	[Inject]
	public var saveSettingsRequest:SaveSettingsRequest;

	[Inject]
	public var revertSettingsRequest:RevertSettingsRequest;

	[Inject]
	public var openPincodeRequest:OpenPincodeRequest;

	[Inject]
	public var closeSettingsRequest:CloseSettingsRequest;

	public function CloseSettingsCommand() {
	}


	override public function execute():void {
		param_save ? saveSettingsRequest.dispatch() : revertSettingsRequest.dispatch();

		var popup:SettingsComponent = ModelUtils.getContainerByClass(vm, SettingsComponent) as SettingsComponent;

        if( popup )
        {
            vm.removeContainer( popup );
            PopUpManager.removePopUp( popup.popupWindow );
        }
	}
}
}
