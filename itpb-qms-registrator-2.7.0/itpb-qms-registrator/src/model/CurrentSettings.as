package model {

import model.vo.SettingsVO;

public class CurrentSettings {

	[Bindable]
	public var settings:SettingsVO;

	//===========================================================================

	public function CurrentSettings() {
		settings = new SettingsVO();
	}

}
}
