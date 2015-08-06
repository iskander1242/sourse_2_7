/**
 * Created by designer4 on 6/10/14.
 */
package controller.requests.settings {

import org.osflash.signals.Signal;

/**
 * Boolean here indicates if permissions should be respected.
 */
public class OpenSettingsRequest extends Signal {
	public function OpenSettingsRequest() {
		super(Boolean);
	}
}
}
