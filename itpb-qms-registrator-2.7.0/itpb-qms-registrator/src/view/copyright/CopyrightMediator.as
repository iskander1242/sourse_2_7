/**
 * Created by designer4 on 30.06.14.
 */
package view.copyright {

import controller.requests.settings.OpenSettingsRequest;
	import controller.signals.ShowPrintTicketSignal;

	import model.AppModel;

	import model.CurrentSettings;

import mx.binding.utils.BindingUtils;
    import mx.binding.utils.ChangeWatcher;

    import robotlegs.bender.bundles.mvcs.Mediator;

public class CopyrightMediator extends Mediator {

	[Inject]
	public var _view:CopyrightComponent;

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var openSettingsRequest:OpenSettingsRequest;

	[Inject]
	public var appModel: AppModel;

	[Inject]
	public var showPrintTicketSignal:ShowPrintTicketSignal;

    private var copyrightWatcher: ChangeWatcher;
    private var copyrightTextColorWatcher: ChangeWatcher;
	private var copyrightTextFontSizeWatcher: ChangeWatcher;
	private var errorMessageWatcher: ChangeWatcher;


	public function CopyrightMediator() {
	}


	override public function initialize():void {
		errorMessageWatcher = BindingUtils.bindProperty(_view, "errorMessage", appModel, "errorMessage");
        copyrightWatcher = BindingUtils.bindProperty(_view, "copyright", currentSettings.settings, "copyright");
        copyrightTextColorWatcher = BindingUtils.bindProperty(_view, "copyrightTextColor", currentSettings.settings, "copyrightTextColor");
		copyrightTextFontSizeWatcher = BindingUtils.bindProperty(_view, "copyrightTextFontSize", currentSettings.settings, "copyrightTextFontSize");

		_view.onOpenSettingsSignal.add(openSettingsHandler);

		showPrintTicketSignal.add( _view.showPrintText );
	}

    override public function destroy(): void
    {
        super.destroy();

	    errorMessageWatcher.unwatch();
        copyrightWatcher.unwatch();
        copyrightTextColorWatcher.unwatch();
	    copyrightTextFontSizeWatcher.unwatch();

        _view.onOpenSettingsSignal.remove(openSettingsHandler);

	    showPrintTicketSignal.remove( _view.showPrintText );
    }

	private function openSettingsHandler():void {
		openSettingsRequest.dispatch(true);
	}
}
}
