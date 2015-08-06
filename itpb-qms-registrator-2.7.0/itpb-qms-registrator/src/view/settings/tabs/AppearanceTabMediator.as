package view.settings.tabs {

import controller.requests.changePassword.ChangePasswordRequest;

import flash.events.Event;
import flash.text.Font;

import model.CurrentSettings;

import mx.binding.utils.BindingUtils;
    import mx.binding.utils.ChangeWatcher;
    import mx.events.ColorPickerEvent;
import mx.events.ItemClickEvent;

import robotlegs.bender.bundles.mvcs.Mediator;

import spark.components.DropDownList;
import spark.components.NumericStepper;
import spark.events.IndexChangeEvent;
import spark.events.TextOperationEvent;

public class AppearanceTabMediator extends Mediator {

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var _view:AppearanceTab;

	[Inject]
	public var changePasswordRequest:ChangePasswordRequest;

    private var backgroundTypeWatcher: ChangeWatcher;
    private var backgroundImageURLWatcher: ChangeWatcher;
    private var backgroundColorWatcher: ChangeWatcher;

    private var ticketWidthWatcher: ChangeWatcher;
    private var ticketHeightWatcher: ChangeWatcher;
    private var ticketFontWatcher: ChangeWatcher;
    private var ticketFontColorWatcher: ChangeWatcher;
    private var ticketBackgroundWatcher: ChangeWatcher;

    private var copyrightWatcher: ChangeWatcher;
    private var copyrightTextColorWatcher: ChangeWatcher;
    private var copyrightTextFontSizeWatcher: ChangeWatcher;
    private var takeTicketTextWatcher: ChangeWatcher;
    private var ticketTextFontSizeWatcher: ChangeWatcher;

    private var closeProtectedWatcher: ChangeWatcher;
    private var settingsProtectedWatcher: ChangeWatcher;

	//===========================================================================

	override public function initialize():void {

        backgroundTypeWatcher = BindingUtils.bindProperty(_view, "backgroundType", currentSettings.settings, "backgroundType");
        backgroundImageURLWatcher = BindingUtils.bindProperty(_view, "backgroundImageURL", currentSettings.settings, "backgroundImageURL");
        backgroundColorWatcher = BindingUtils.bindProperty(_view, "backgroundColor", currentSettings.settings, "backgroundColor");

        ticketWidthWatcher = BindingUtils.bindProperty(_view, "ticketWidth", currentSettings.settings, "ticketWidth");
        ticketHeightWatcher = BindingUtils.bindProperty(_view, "ticketHeight", currentSettings.settings, "ticketHeight");
        ticketFontWatcher = BindingUtils.bindProperty(_view, "ticketFont", currentSettings.settings, "ticketFont");
        ticketFontColorWatcher = BindingUtils.bindProperty(_view, "ticketFontColor", currentSettings.settings, "ticketFontColor");
        ticketBackgroundWatcher = BindingUtils.bindProperty(_view, "ticketBackground", currentSettings.settings, "ticketBackground");

        copyrightWatcher = BindingUtils.bindProperty(_view, "copyright", currentSettings.settings, "copyright");
        copyrightTextColorWatcher = BindingUtils.bindProperty(_view, "copyrightTextColor", currentSettings.settings, "copyrightTextColor");
        copyrightTextFontSizeWatcher = BindingUtils.bindProperty(_view, "copyrightTextFontSize", currentSettings.settings, "copyrightTextFontSize");
        takeTicketTextWatcher = BindingUtils.bindProperty(_view, "takeTicketText", currentSettings.settings, "takeTicketText");
        ticketTextFontSizeWatcher = BindingUtils.bindProperty(_view, "ticketTextFontSize", currentSettings.settings, "ticketTextFontSize");

        closeProtectedWatcher = BindingUtils.bindProperty(_view, "closeProtected", currentSettings.settings, "closeProtected");
        settingsProtectedWatcher = BindingUtils.bindProperty(_view, "settingsProtected", currentSettings.settings, "settingsProtected");


		_view.onBackgroundTypeChangedSignal.add(backgroundTypeHandler);
		_view.onBackgroundImageURLChangedSignal.add(backgroundImageHandler);
		_view.onChangeBackgroundColorSignal.add(changeBackgroundColorHandler);

		_view.onTicketWidthChangedSignal.add(ticketWidthHandler);
		_view.onTicketHeightChangedSignal.add(ticketHeightHandler);
		_view.onTicketFontChangedSignal.add(ticketFontHandler);
		_view.onTicketFontColorChangedSignal.add(ticketFontColorHandler);
		_view.onTicketBackgroundChangedSignal.add(ticketBackgroundHandler);

		_view.onCopyrightChangedSignal.add(copyrightHandler);
        _view.onCopyrightTextColorChangedSignal.add(copyrightTextColorHandler);
        _view.onCopyrightTextFontSizeChangedSignal.add( copyrightTextFontSizeHandler );
        _view.onTakeTicketTextChangedSignal.add(takeTicketTextHandler);
        _view.onTicketTextFontSizeChangedSignal.add(ticketTextFontSizeHandler);

		_view.onCloseProtectedChangedSignal.add(closeProtectedHandler);
		_view.onSettingsProtectedChangedSignal.add(settingsProtectedHandler);
		_view.onChangePasswordSignal.add(changePaswordHandler);
	}

    override public function destroy(): void
    {
        super.destroy();

        backgroundTypeWatcher.unwatch();
        backgroundImageURLWatcher.unwatch();
        backgroundColorWatcher.unwatch();

        ticketWidthWatcher.unwatch();
        ticketHeightWatcher.unwatch();
        ticketFontWatcher.unwatch();
        ticketFontColorWatcher.unwatch();
        ticketBackgroundWatcher.unwatch();

        copyrightWatcher.unwatch();
        copyrightTextColorWatcher.unwatch();
        copyrightTextFontSizeWatcher.unwatch();
        takeTicketTextWatcher.unwatch();
        ticketTextFontSizeWatcher.unwatch();

        closeProtectedWatcher.unwatch();
        settingsProtectedWatcher.unwatch();


        _view.onBackgroundTypeChangedSignal.remove(backgroundTypeHandler);
        _view.onBackgroundImageURLChangedSignal.remove(backgroundImageHandler);
        _view.onChangeBackgroundColorSignal.remove(changeBackgroundColorHandler);

        _view.onTicketWidthChangedSignal.remove(ticketWidthHandler);
        _view.onTicketHeightChangedSignal.remove(ticketHeightHandler);
        _view.onTicketFontChangedSignal.remove(ticketFontHandler);
        _view.onTicketFontColorChangedSignal.remove(ticketFontColorHandler);
        _view.onTicketBackgroundChangedSignal.remove(ticketBackgroundHandler);

        _view.onCopyrightChangedSignal.remove(copyrightHandler);
        _view.onCopyrightTextColorChangedSignal.remove(copyrightTextColorHandler);
        _view.onCopyrightTextFontSizeChangedSignal.remove( copyrightTextFontSizeHandler );
        _view.onTakeTicketTextChangedSignal.remove(takeTicketTextHandler);
        _view.onTicketTextFontSizeChangedSignal.remove(ticketTextFontSizeHandler);

        _view.onCloseProtectedChangedSignal.remove(closeProtectedHandler);
        _view.onSettingsProtectedChangedSignal.remove(settingsProtectedHandler);
        _view.onChangePasswordSignal.remove(changePaswordHandler);
    }

	//---------------------------------------------------------------------------

	private function backgroundTypeHandler(e:ItemClickEvent):void {
		currentSettings.settings.backgroundType = e.index;
	}

	private function backgroundImageHandler():void {
		currentSettings.settings.backgroundImageURL = _view.backgroundImageURL;
	}

	private function changeBackgroundColorHandler(e:ColorPickerEvent):void {
		currentSettings.settings.backgroundColor = e.color;
	}

	private function ticketWidthHandler(e:Event):void {
		currentSettings.settings.ticketWidth = (e.target as NumericStepper).value;
	}

	private function ticketHeightHandler(e:Event):void {
		currentSettings.settings.ticketHeight = (e.target as NumericStepper).value;
	}

    private function ticketTextFontSizeHandler(e:Event):void {
        currentSettings.settings.ticketTextFontSize = (e.target as NumericStepper).value;
    }

	private function ticketFontHandler(e:IndexChangeEvent):void {
		var font:Font = (e.target as DropDownList).selectedItem;
		currentSettings.settings.ticketFont = font.fontName;
	}

	private function ticketFontColorHandler(e:ColorPickerEvent):void {
		currentSettings.settings.ticketFontColor = e.color;
	}

	private function ticketBackgroundHandler(e:ColorPickerEvent):void {
		currentSettings.settings.ticketBackground = e.color;
	}

	private function copyrightHandler(e:TextOperationEvent):void {
		currentSettings.settings.copyright = e.target.text;
	}

    private function copyrightTextColorHandler(e:ColorPickerEvent):void {
        currentSettings.settings.copyrightTextColor = e.color;
    }

    private function copyrightTextFontSizeHandler(e:Event):void {
        currentSettings.settings.copyrightTextFontSize = (e.target as NumericStepper).value;
    }

    private function takeTicketTextHandler(e:TextOperationEvent):void {
        currentSettings.settings.takeTicketText = e.target.text;
    }

	private function closeProtectedHandler(value:Boolean):void{
		currentSettings.settings.closeProtected = value;
	}

	private function settingsProtectedHandler(value:Boolean):void{
		currentSettings.settings.settingsProtected = value;
	}

	private function changePaswordHandler():void{
		changePasswordRequest.dispatch();
	}
}
}
