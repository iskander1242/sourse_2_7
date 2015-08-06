/**
 * Created by designer4 on 27.06.14.
 */
package controller.commands.settings {

import com.junkbyte.console.Cc;

import controller.requests.CheckServerConnectionRequest;

import controller.utils.ModelUtils;

	import model.AppModel;

	import model.CurrentSettings;
import model.SavedSettings;

import robotlegs.bender.bundles.mvcs.Command;

public class SaveSettingsCommand extends Command {

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var savedSettings:SavedSettings;

	[Inject]
	public var appModel: AppModel;

	/*[Inject]
	public var checkServerConnectionRequest:CheckServerConnectionRequest;*/

	//===========================================================================

	override public function execute():void {
		//Cc.log(this);
		ModelUtils.copyProperties(savedSettings.settings, currentSettings.settings);

		appModel.noPrintToPrinter = savedSettings.settings.noPrintToPrinter;

		//Cc.infoch("Настройки сохранены");

		//checkServerConnectionRequest.dispatch();
	}
}
}
