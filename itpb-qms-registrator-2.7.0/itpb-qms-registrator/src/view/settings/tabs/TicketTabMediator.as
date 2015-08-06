/**
 * Created by designer4 on 6/16/14.
 */
package view.settings.tabs {

    import model.AppModel;
    import model.CurrentSettings;

import mx.binding.utils.BindingUtils;
    import mx.binding.utils.ChangeWatcher;

    import robotlegs.bender.bundles.mvcs.Mediator;

public class TicketTabMediator extends Mediator {

	[Inject]
	public var _view:TicketTab;

	[Inject]
	public var currentSettings:CurrentSettings;

    [Inject]
    public var appModel: AppModel;

    private var line1VisibleWatcher: ChangeWatcher;
    private var line1TextWatcher: ChangeWatcher;
    private var line1FontSizeWatcher: ChangeWatcher;

    private var line2VisibleWatcher: ChangeWatcher;
    private var line2TextWatcher: ChangeWatcher;
    private var line2FontSizeWatcher: ChangeWatcher;

    private var includeTicketNumberWatcher: ChangeWatcher;
    private var includeTicketTimeWatcher: ChangeWatcher;
    private var ticketBottomTextWatcher: ChangeWatcher;
    private var ticketNumberFontSizeWatcher: ChangeWatcher;
    private var mainFontSizeWatcher: ChangeWatcher;
    private var noPrintToPrinterWatcher: ChangeWatcher;
    private var setNoPrintToPrinterWatcher: ChangeWatcher;

	override public function initialize():void {
		line1VisibleWatcher = BindingUtils.bindProperty(_view, "line1Visible", currentSettings.settings, "line1Visible");
        line1TextWatcher = BindingUtils.bindProperty(_view, "line1Text", currentSettings.settings, "line1Text");
        line1FontSizeWatcher = BindingUtils.bindProperty(_view, "line1FontSize", currentSettings.settings, "line1FontSize");

        line2VisibleWatcher = BindingUtils.bindProperty(_view, "line2Visible", currentSettings.settings, "line2Visible");
        line2TextWatcher = BindingUtils.bindProperty(_view, "line2Text", currentSettings.settings, "line2Text");
        line2FontSizeWatcher = BindingUtils.bindProperty(_view, "line2FontSize", currentSettings.settings, "line2FontSize");

        includeTicketNumberWatcher = BindingUtils.bindProperty(_view, "includeTicketNumber", currentSettings.settings, "includeTicketNumber");
        includeTicketTimeWatcher = BindingUtils.bindProperty(_view, "includeTicketTime", currentSettings.settings, "includeTicketTime");
        ticketBottomTextWatcher = BindingUtils.bindProperty(_view, "ticketBottomText", currentSettings.settings, "ticketBottomText");
        ticketNumberFontSizeWatcher = BindingUtils.bindProperty(_view, "ticketNumberFontSize", currentSettings.settings, "ticketNumberFontSize");
        mainFontSizeWatcher = BindingUtils.bindProperty(_view, "mainFontSize", currentSettings.settings, "mainFontSize");
        noPrintToPrinterWatcher = BindingUtils.bindProperty(_view, "noPrintToPrinter", currentSettings.settings, "noPrintToPrinter");
        setNoPrintToPrinterWatcher = BindingUtils.bindProperty(_view, "noPrintToPrinter", currentSettings.settings, "noPrintToPrinter");


		_view.onLine1VisibleChangedSignal.add(line1VisibleHandler);
		_view.onLine1TextChangedSignal.add(onLine1TextHandler);
		_view.onLine1FontSizeChangedSignal.add(line1FontSizeHandler);

		_view.onLine2VisibleChangedSignal.add(line2VisibleHandler);
		_view.onLine2TextChangedSignal.add(onLine2TextHandler);
		_view.onLine2FontSizeChangedSignal.add(line2FontSizeHandler);

		_view.onIncludeTicketNumberChangedSignal.add(includeTicketNumberHandler);
		_view.onIncludeTicketTimeChangedSignal.add(includeTicketTimeHandler);
		_view.onTicketBottomTextChangedSignal.add(ticketBottomTextHandler);
        _view.onTicketNumberFontSizeChangedSignal.add(ticketNumberFontSizeHandler);
        _view.onMainFontSizeChangedSignal.add(mainFontSizeHandler);

        _view.onNoPrintToPrinterSignal.add(noPrintToPrinterHandler);
	}

    override public function destroy(): void
    {
        super.destroy();

        line1VisibleWatcher.unwatch();
        line1TextWatcher.unwatch();
        line1FontSizeWatcher.unwatch();

        line2VisibleWatcher.unwatch();
        line2TextWatcher.unwatch();
        line2FontSizeWatcher.unwatch();

        includeTicketNumberWatcher.unwatch();
        includeTicketTimeWatcher.unwatch();
        ticketBottomTextWatcher.unwatch();
        ticketNumberFontSizeWatcher.unwatch();
        mainFontSizeWatcher.unwatch();
        noPrintToPrinterWatcher.unwatch();
        setNoPrintToPrinterWatcher.unwatch();

        _view.onLine1VisibleChangedSignal.remove(line1VisibleHandler);
        _view.onLine1TextChangedSignal.remove(onLine1TextHandler);
        _view.onLine1FontSizeChangedSignal.remove(line1FontSizeHandler);

        _view.onLine2VisibleChangedSignal.remove(line2VisibleHandler);
        _view.onLine2TextChangedSignal.remove(onLine2TextHandler);
        _view.onLine2FontSizeChangedSignal.remove(line2FontSizeHandler);

        _view.onIncludeTicketNumberChangedSignal.remove(includeTicketNumberHandler);
        _view.onIncludeTicketTimeChangedSignal.remove(includeTicketTimeHandler);
        _view.onTicketBottomTextChangedSignal.remove(ticketBottomTextHandler);
        _view.onTicketNumberFontSizeChangedSignal.remove(ticketNumberFontSizeHandler);
        _view.onMainFontSizeChangedSignal.remove(mainFontSizeHandler);

        _view.onNoPrintToPrinterSignal.remove(noPrintToPrinterHandler);
    }

	public function line1VisibleHandler(value:Boolean):void {
		currentSettings.settings.line1Visible = value;
	}

	public function onLine1TextHandler(value:String):void {
		currentSettings.settings.line1Text = value;
	}

	public function line1FontSizeHandler(value:uint):void {
		currentSettings.settings.line1FontSize = value;
	}

	public function line2VisibleHandler(value:Boolean):void {
		currentSettings.settings.line2Visible = value;
	}

	public function onLine2TextHandler(value:String):void {
		currentSettings.settings.line2Text = value;
	}

	public function line2FontSizeHandler(value:uint):void {
		currentSettings.settings.line2FontSize = value;
	}

    public function ticketNumberFontSizeHandler(value:uint):void {
        currentSettings.settings.ticketNumberFontSize = value;
    }

    public function mainFontSizeHandler(value:uint):void {
        currentSettings.settings.mainFontSize = value;
    }

	public function includeTicketNumberHandler(value:Boolean):void {
		currentSettings.settings.includeTicketNumber = value;
	}

	public function includeTicketTimeHandler(value:Boolean):void {
		currentSettings.settings.includeTicketTime = value;
	}

	public function ticketBottomTextHandler(value:String):void {
		currentSettings.settings.ticketBottomText = value;
	}

    public function noPrintToPrinterHandler(value:Boolean):void {
        setNoPrintToModel( value );
        currentSettings.settings.noPrintToPrinter = value;
    }

    private function setNoPrintToModel( value: Boolean ): void
    {
        appModel.noPrintToPrinter = value;
    }
}
}