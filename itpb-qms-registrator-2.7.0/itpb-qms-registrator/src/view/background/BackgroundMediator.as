/**
 * Created by designer4 on 6/16/14.
 */
package view.background {

import model.CurrentSettings;

import mx.binding.utils.BindingUtils;
    import mx.binding.utils.ChangeWatcher;

    import robotlegs.bender.bundles.mvcs.Mediator;

public class BackgroundMediator extends Mediator {

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var _view:BackgroundComponent;

    private var backgroundTypeWatcher: ChangeWatcher;
    private var backgroundImageURLWatcher: ChangeWatcher;
    private var backgroundColorWatcher: ChangeWatcher;

	//===========================================================================

	override public function initialize():void {
        backgroundTypeWatcher = BindingUtils.bindProperty(_view, "backgroundType", currentSettings.settings, "backgroundType");
        backgroundImageURLWatcher = BindingUtils.bindProperty(_view, "backgroundImageURL", currentSettings.settings, "backgroundImageURL");
        backgroundColorWatcher = BindingUtils.bindProperty(_view, "backgroundColor", currentSettings.settings, "backgroundColor");
	}

    override public function destroy(): void
    {
        backgroundTypeWatcher.unwatch();
        backgroundImageURLWatcher.unwatch();
        backgroundColorWatcher.unwatch();
    }
}
}
