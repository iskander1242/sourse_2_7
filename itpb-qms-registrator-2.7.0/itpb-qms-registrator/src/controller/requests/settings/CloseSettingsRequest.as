/**
 * Created by designer4 on 6/16/14.
 */
package controller.requests.settings {

import org.osflash.signals.Signal;

/**
 * First Boolean argument indicates if settings should be applied (saved) before closing
 */

public class CloseSettingsRequest extends Signal {
	public function CloseSettingsRequest() {
		super(Boolean);
	}
}
}
