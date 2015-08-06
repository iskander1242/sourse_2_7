/**
 * Created by designer4 on 6/16/14.
 */
package view.settings.tabs {

import flash.events.Event;

import org.osflash.signals.Signal;

import spark.components.CheckBox;

import spark.components.NavigatorContent;
import spark.components.NumericStepper;
import spark.components.TextArea;
import spark.components.TextInput;
import spark.events.TextOperationEvent;

public class TicketTab extends NavigatorContent {


	[Bindable]public var line1Visible:Boolean;
	[Bindable]public var line1Text:String;
	[Bindable]public var line1FontSize:uint;

	[Bindable]public var line2Visible:Boolean;
	[Bindable]public var line2Text:String;
	[Bindable]public var line2FontSize:uint;

    [Bindable]public var ticketNumberFontSize:uint;
    [Bindable]public var mainFontSize:uint;

	[Bindable]public var includeTicketNumber:Boolean;
	[Bindable]public var includeTicketTime:Boolean;
	[Bindable]public var ticketBottomText:String;

	[Bindable]public var noPrintToPrinter:Boolean;


	public var onLine1VisibleChangedSignal:Signal = new Signal();
	public var onLine1TextChangedSignal:Signal = new Signal();
	public var onLine1FontSizeChangedSignal:Signal = new Signal();

	public var onLine2VisibleChangedSignal:Signal = new Signal();
	public var onLine2TextChangedSignal:Signal = new Signal();
	public var onLine2FontSizeChangedSignal:Signal = new Signal();

	public var onIncludeTicketNumberChangedSignal:Signal = new Signal();
	public var onIncludeTicketTimeChangedSignal:Signal = new Signal();
	public var onTicketBottomTextChangedSignal:Signal = new Signal();

    public var onTicketNumberFontSizeChangedSignal: Signal = new Signal();
    public var onMainFontSizeChangedSignal: Signal = new Signal();
	public var onNoPrintToPrinterSignal: Signal = new Signal();


	public function TicketTab() {}

	public function line1VisibleHandler(e:Event):void{
		onLine1VisibleChangedSignal.dispatch( (e.target as CheckBox).selected );
	}

	public function line1TextHandler(e:TextOperationEvent):void{
		onLine1TextChangedSignal.dispatch( (e.target as TextInput).text );
	}

	public function line1FontSizeHandler(e:Event):void{
		onLine1FontSizeChangedSignal.dispatch( (e.target as NumericStepper).value );
	}

	public function line2VisibleHandler(e:Event):void{
		onLine2VisibleChangedSignal.dispatch( (e.target as CheckBox).selected );
	}

	public function line2TextHandler(e:TextOperationEvent):void{
		onLine2TextChangedSignal.dispatch( (e.target as TextInput).text );
	}

	public function line2FontSizeHandler(e:Event):void{
		onLine2FontSizeChangedSignal.dispatch( (e.target as NumericStepper).value );
	}

	public function includeTicketNumberHandler(e:Event):void{
		onIncludeTicketNumberChangedSignal.dispatch( (e.target as CheckBox).selected );
	}
	public function includeTicketTimeHandler(e:Event):void{
		onIncludeTicketTimeChangedSignal.dispatch( (e.target as CheckBox).selected );
	}
	public function ticketBottomTextHandler(e:TextOperationEvent):void{
		onTicketBottomTextChangedSignal.dispatch( (e.target as TextArea).text );
	}

    public function ticketNumberFontSizeHandler(e:Event): void{
        onTicketNumberFontSizeChangedSignal.dispatch( (e.target as NumericStepper).value );
    }

    public function mainFontSizeHandler(e:Event): void{
        onMainFontSizeChangedSignal.dispatch( (e.target as NumericStepper).value );
    }

	public function noPrintToPrinterHandler(e:Event):void{
		onNoPrintToPrinterSignal.dispatch( (e.target as CheckBox).selected );
	}
}
}