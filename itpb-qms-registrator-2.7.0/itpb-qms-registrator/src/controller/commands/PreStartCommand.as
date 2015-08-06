/**
 * Created by designer4 on 01.07.14.
 */
package controller.commands {

import com.junkbyte.console.Cc;

import controller.requests.config.LoadConfigFileRequest;
import controller.requests.settings.LoadSettingsFileRequest;
import controller.utils.ModelUtils;

import model.CurrentSettings;
import model.SavedSettings;

import robotlegs.bender.bundles.mvcs.Command;

public class PreStartCommand extends Command {

	[Inject]
	public var savedSettings:SavedSettings;

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var loadConfigFileRequest:LoadSettingsFileRequest;

	[Inject]
	public var loadAppConfigFileRequest:LoadConfigFileRequest

	//===========================================================================

	public function PreStartCommand() {
	}

	override public function execute():void {
		Cc.log(this);

		// load proxy
		loadAppConfigFileRequest.dispatch();

		// load config
		loadConfigFileRequest.dispatch(true);

		// save current settings
		ModelUtils.copyProperties(savedSettings.settings, currentSettings.settings);
	}
}
}
