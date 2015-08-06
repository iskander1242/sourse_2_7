/**
 * Created by designer4 on 6/18/14.
 */
package model {

import model.vo.SettingsVO;

public class SavedSettings {

	[Bindable]
	public var settings:SettingsVO;

	//===========================================================================

	public function SavedSettings() {
		settings = new SettingsVO();
	}
}
}
