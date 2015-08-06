package view.settings.tabs {

import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.Font;

import mx.collections.ArrayCollection;
import mx.events.ColorPickerEvent;
import mx.events.ItemClickEvent;

import org.osflash.signals.Signal;

import spark.collections.Sort;
import spark.collections.SortField;
import spark.components.CheckBox;
import spark.components.NavigatorContent;
import spark.events.IndexChangeEvent;
import spark.events.TextOperationEvent;

public class AppearanceTab extends NavigatorContent {

	private var _backgroundImageURL:String;

	[Bindable]
	public var backgroundType:uint;

	[Bindable(event="backgroundImageURLChanged")]
	public function get backgroundImageURL():String {
		return _backgroundImageURL;
	}

	public function set backgroundImageURL(value:String):void {
		if(_backgroundImageURL == value) return;
		_backgroundImageURL = value;
		onBackgroundImageURLChangedSignal.dispatch();
		dispatchEvent(new Event("backgroundImageURLChanged"));
	}

	[Bindable]
	public var backgroundColor:uint;

	[Bindable]
	public var ticketWidth:uint;

	[Bindable]
	public var ticketHeight:uint;

	[Bindable]
	public var ticketFont:String;

	[Bindable]
	public var fontsListAC:ArrayCollection;

	[Bindable]
	public var ticketFontColor:uint;

	[Bindable]
	public var ticketBackground:uint;

	[Bindable]
	public var copyright:String;

    [Bindable]
    public var copyrightTextColor:uint;

	[Bindable]
	public var copyrightTextFontSize:uint;

    [Bindable]
    public var takeTicketText:String;

    [Bindable]
    public var ticketTextFontSize:uint;

	// Passwords
	[Bindable]
	public var closeProtected:Boolean;

	[Bindable]
	public var settingsProtected:Boolean;

	//---------------------------------------------------------------------------

	// Background
	public var onBackgroundTypeChangedSignal:Signal = new Signal();
	public var onBackgroundImageURLChangedSignal:Signal = new Signal();
	public var onChangeBackgroundColorSignal:Signal = new Signal();

	public var onTicketWidthChangedSignal:Signal = new Signal();
	public var onTicketHeightChangedSignal:Signal = new Signal();
	public var onTicketFontChangedSignal:Signal = new Signal();
	public var onTicketFontColorChangedSignal:Signal = new Signal();
	public var onTicketBackgroundChangedSignal:Signal = new Signal();

	public var onCopyrightChangedSignal:Signal = new Signal();
    public var onCopyrightTextColorChangedSignal:Signal = new Signal();
	public var onCopyrightTextFontSizeChangedSignal:Signal = new Signal();
    public var onTakeTicketTextChangedSignal:Signal = new Signal();
    public var onTicketTextFontSizeChangedSignal:Signal = new Signal();

	// Passwords
	public var onCloseProtectedChangedSignal:Signal = new Signal();
	public var onSettingsProtectedChangedSignal:Signal = new Signal();
	public var onChangePasswordSignal:Signal = new Signal();

	//===========================================================================

	public function AppearanceTab():void {
		// Prepare fonts list
		fontsListAC = new ArrayCollection(Font.enumerateFonts(true));
		var sort:Sort = new Sort();
		sort.fields = [new SortField("fontName")];
		fontsListAC.sort = sort;
		fontsListAC.refresh();
	}

	//---------------------------------------------------------------------------

	public function changeBackgroundTypeHandler(e:ItemClickEvent):void {
		onBackgroundTypeChangedSignal.dispatch(e);
	}

	public function changeBackgroundColorHandler(e:ColorPickerEvent):void {
		onChangeBackgroundColorSignal.dispatch(e);
	}

	public function ticketWidthHandler(e:Event):void {
		onTicketWidthChangedSignal.dispatch(e);
	}

	public function ticketHeightHandler(e:Event):void {
		onTicketHeightChangedSignal.dispatch(e);
	}

    public function ticketTextFontSizeHandler(e:Event):void {
        onTicketTextFontSizeChangedSignal.dispatch(e);
    }

	public function ticketFontChanged(e:IndexChangeEvent):void {
		onTicketFontChangedSignal.dispatch(e);
	}

	public function ticketBackgroundChanged(e:ColorPickerEvent):void {
		onTicketBackgroundChangedSignal.dispatch(e);
	}

	public function ticketFontColorChanged(e:ColorPickerEvent):void {
		onTicketFontColorChangedSignal.dispatch(e);
	}
	public function copyrightChangedHandler(e:TextOperationEvent):void {
		onCopyrightChangedSignal.dispatch(e);
	}

    public function copyrightTextColorChanged(e:ColorPickerEvent):void {
        onCopyrightTextColorChangedSignal.dispatch(e);
    }

	public function copyrightTextFontSizeHandler(e:Event):void {
		onCopyrightTextFontSizeChangedSignal.dispatch(e);
	}

    public function takeTicketTextChangedHandler(e:TextOperationEvent):void {
        onTakeTicketTextChangedSignal.dispatch(e);
    }

	// Passwords
	public function closeProtectedHandler(e:Event):void{
		onCloseProtectedChangedSignal.dispatch((e.target as CheckBox).selected);
	}
	public function settingsProtectedHandler(e:Event):void{
		onSettingsProtectedChangedSignal.dispatch((e.target as CheckBox).selected);
	}

	public function changePasswordHandler(e:MouseEvent):void{
		onChangePasswordSignal.dispatch();
	}
}
}
