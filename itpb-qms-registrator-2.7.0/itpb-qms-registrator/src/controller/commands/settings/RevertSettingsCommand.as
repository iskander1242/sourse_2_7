/**
 * Created by designer4 on 27.06.14.
 */
package controller.commands.settings {

import com.junkbyte.console.Cc;

import controller.utils.ModelUtils;

import model.CurrentSettings;
import model.SavedSettings;

import robotlegs.bender.bundles.mvcs.Command;

public class RevertSettingsCommand extends Command {

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var savedSettings:SavedSettings;

	//===========================================================================

	override public function execute():void {
		Cc.log(this);
		Cc.infoch("Сброс настроек на предыдущие значения");

		ModelUtils.copyProperties(currentSettings.settings, savedSettings.settings);
	}



}
}
