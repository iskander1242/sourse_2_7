/**
 * Created by designer4 on 14.07.14.
 */
package controller.requests {

import org.osflash.signals.Signal;

/**
 * Boolean indicates if permissions should be respected.
 */
public class ApplicationQuitRequest extends Signal {
	public function ApplicationQuitRequest() {
		super(Boolean);
	}
}
}
