package view.settings.tabs {

import model.CurrentSettings;
import model.SavedSettings;

import mx.binding.utils.BindingUtils;
    import mx.binding.utils.ChangeWatcher;

    import robotlegs.bender.bundles.mvcs.Mediator;

import spark.events.TextOperationEvent;

public class CommunicationsTabMediator extends Mediator {

	[Inject]
	public var _view:CommunicationsTab;

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var savedSettings:SavedSettings;

    private var hostWatcher: ChangeWatcher;
    private var portWatcher: ChangeWatcher;
    private var connectColorWatcher: ChangeWatcher;

	//===========================================================================

	override public function initialize():void {
		hostWatcher = BindingUtils.bindProperty(_view, "host", currentSettings.settings, "host");
		portWatcher = BindingUtils.bindProperty(_view, "port", currentSettings.settings, "port");

        connectColorWatcher = BindingUtils.bindProperty(_view, "connectColor", savedSettings.settings, "connectColor");

		_view.onHostChangedSignal.add(hostHandler);
		_view.onPortChangedSignal.add(portHandler);
	}

    override public function destroy(): void
    {
        super.destroy();

        hostWatcher.unwatch();
        portWatcher.unwatch();

        connectColorWatcher.unwatch();

        _view.onHostChangedSignal.remove(hostHandler);
        _view.onPortChangedSignal.remove(portHandler);
    }

	//-------------------------------------------------------

	public function hostHandler(e:TextOperationEvent):void {
		currentSettings.settings.host = e.target.text;
	}

	public function portHandler(e:TextOperationEvent):void {
		currentSettings.settings.port = e.target.text;
	}
}
}
