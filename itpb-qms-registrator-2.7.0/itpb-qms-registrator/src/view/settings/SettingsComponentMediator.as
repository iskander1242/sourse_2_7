package view.settings {

import controller.requests.CheckServerConnectionRequest;
import controller.requests.pincode.OpenPincodeRequest;
import controller.requests.settings.CloseSettingsRequest;
import controller.requests.settings.LoadSettingsFileRequest;
import controller.requests.settings.OpenSettingsRequest;
import controller.requests.settings.RevertSettingsRequest;
import controller.requests.settings.SaveSettingsFileRequest;
import controller.requests.settings.SaveSettingsRequest;

import model.CurrentSettings;
import model.SavedSettings;

import robotlegs.bender.bundles.mvcs.Mediator;

public class SettingsComponentMediator extends Mediator {

	[Inject]
	public var _view:SettingsComponent;

	[Inject]
	public var openSettingsRequest:OpenSettingsRequest;

	[Inject]
	public var closeSettingsRequest:CloseSettingsRequest;

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var savedSettings:SavedSettings;

	[Inject]
	public var saveSettingsRequest:SaveSettingsRequest;

	[Inject]
	public var revertSettingsRequest:RevertSettingsRequest;

	[Inject]
	public var loadConfigFileRequest:LoadSettingsFileRequest;

	[Inject]
	public var saveConfigFileRequest:SaveSettingsFileRequest;

	/*[Inject]
	public var checkServerConnectionRequest:CheckServerConnectionRequest;*/

	[Inject]
	public var permissionRequest:OpenPincodeRequest;

	//===========================================================================

	override public function initialize():void {
		//checkServerConnectionRequest.dispatch();

		_view.onSaveSettingsSignal.add(saveSettingsHandler);
		_view.onCloseSettingsSignal.add(closeSettingsHandler);

		_view.onLoadConfigFileSignal.add(loadConfigFileHandler);
		_view.onSaveConfigFileSignal.add(saveConfigFileHandler);

	}

    override public function destroy(): void
    {
        super.destroy();

        _view.onSaveSettingsSignal.remove(saveSettingsHandler);
        _view.onCloseSettingsSignal.remove(closeSettingsHandler);

        _view.onLoadConfigFileSignal.remove(loadConfigFileHandler);
        _view.onSaveConfigFileSignal.remove(saveConfigFileHandler);
    }

	private function closeSettingsHandler(save:Boolean):void {
		closeSettingsRequest.dispatch(save);
	}

	private function saveSettingsHandler():void {
		saveSettingsRequest.dispatch();
        saveConfigFileRequest.dispatch();
	}

	private function loadConfigFileHandler():void {
		loadConfigFileRequest.dispatch(false);
	}

	private function saveConfigFileHandler():void {
		saveConfigFileRequest.dispatch();
	}
}
}
