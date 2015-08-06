/**
 * Created by designer4 on 01.07.14.
 */
package controller.requests.settings {

import org.osflash.signals.Signal;

/**
 * Executes LoadConfigFileCommand.
 * Requires boolean, which indicates if settings should be loaded quietly, without confirmation
 */
public class LoadSettingsFileRequest extends Signal {
	public function LoadSettingsFileRequest() {
		super(Boolean);
	}
}
}
