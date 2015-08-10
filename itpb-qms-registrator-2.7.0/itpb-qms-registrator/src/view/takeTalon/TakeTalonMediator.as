/**
 * Created by designer4 on 6/4/14.
 */
package view.takeTalon {
import view.takeTalon.*;

import controller.requests.TakeTicketReqest;
    import controller.signals.ShowPrintTicketSignal;

    import model.AppModel;

    import model.CurrentSettings;

import mx.binding.utils.BindingUtils;
    import mx.binding.utils.ChangeWatcher;

    import robotlegs.bender.bundles.mvcs.Mediator;

public class TakeTalonMediator extends Mediator {

	[Inject]
	public var _view:TakeTalonComponent;

	[Inject]
	public var currentSettings:CurrentSettings;

    [Inject]
    public var appModel: AppModel;

	[Inject]
	public var takeTicketRequest:TakeTicketReqest;

    [Inject]
    public var showPrintTicketSignal:ShowPrintTicketSignal;

    private var takeTicketWatcher: ChangeWatcher;
    private var isTicketButtonActiveWatcher: ChangeWatcher;
    private var ticketTextFontSizeWatcher: ChangeWatcher;
    private var takeWidthWatcher: ChangeWatcher;
    private var takeHeightWatcher: ChangeWatcher;
    private var takeFontWatcher: ChangeWatcher;
    private var takeBackgroundWatcher: ChangeWatcher;
    private var takeFontColorWatcher: ChangeWatcher;

	//---------------------------------------------------------------------------

	override public function initialize():void {
        takeTicketWatcher = BindingUtils.bindProperty(_view, "takeTicketText", currentSettings.settings, "takeTicketText");
        isTicketButtonActiveWatcher = BindingUtils.bindProperty(_view, "isTicketButtonActive", appModel, "isTicketButtonActive");
        ticketTextFontSizeWatcher = BindingUtils.bindProperty(_view, "ticketTextFontSize", currentSettings.settings, "ticketTextFontSize");
        takeWidthWatcher = BindingUtils.bindProperty(_view, "ticketWidth", currentSettings.settings, "ticketWidth");
        takeHeightWatcher = BindingUtils.bindProperty(_view, "ticketHeight", currentSettings.settings, "ticketHeight");
        takeFontWatcher = BindingUtils.bindProperty(_view, "ticketFont", currentSettings.settings, "ticketFont");
        takeBackgroundWatcher = BindingUtils.bindProperty(_view, "ticketBackground", currentSettings.settings, "ticketBackground");
        takeFontColorWatcher = BindingUtils.bindProperty(_view, "ticketFontColor", currentSettings.settings, "ticketFontColor");


		_view.onTicketClickedSignal.add(clickHandler);
        _view.onButtonEnabledSignal.add( buttonEnabled );
	}

    override public function destroy(): void
    {
        super.destroy();

        takeTicketWatcher.unwatch();
        isTicketButtonActiveWatcher.unwatch();
        ticketTextFontSizeWatcher.unwatch();
        takeWidthWatcher.unwatch();
        takeHeightWatcher.unwatch();
        takeFontWatcher.unwatch();
        takeBackgroundWatcher.unwatch();
        takeFontColorWatcher.unwatch();

        _view.onTicketClickedSignal.remove(clickHandler);
        _view.onButtonEnabledSignal.remove( buttonEnabled );
    }

	//---------------------------------------------------------------------------

	private function clickHandler():void {
        showPrintTicketSignal.dispatch( true );
		takeTicketRequest.dispatch();
	}

    private function buttonEnabled(): void
    {
        showPrintTicketSignal.dispatch( false );
    }

}
}
