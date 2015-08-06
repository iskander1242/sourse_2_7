/**
 * Created by designer4 on 6/11/14.
 */
package controller {

import controller.requests.settings.CloseSettingsRequest;
import controller.requests.settings.OpenSettingsRequest;
import controller.requests.pincode.OpenPincodeRequest;

import model.CurrentSettings;

import robotlegs.bender.bundles.mvcs.Mediator;

public class KeyControllerMediator extends Mediator {

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var openSettingsRequest:OpenSettingsRequest;

	[Inject]
	public var closeSettingsRequest:CloseSettingsRequest;

	[Inject]
	public var _view:KeyController;

	[Inject]
	public var permissionRequest:OpenPincodeRequest;

	override public function initialize():void {
		_view.onOpenSettings.add(onOpenSettingsHandler);
		_view.onCloseSettings.add(onCloseSettingsHandler);
	}

    override public function destroy(): void
    {
        super.destroy();

        _view.onOpenSettings.remove(onOpenSettingsHandler);
        _view.onCloseSettings.remove(onCloseSettingsHandler);
    }

	private function onOpenSettingsHandler():void {
		openSettingsRequest.dispatch(true);
	}

	private function onCloseSettingsHandler():void{
		closeSettingsRequest.dispatch(false);
	}
}
}
