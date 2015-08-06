/**
 * Created by designer4 on 14.07.14.
 */
package view.ticket {

    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.MouseEvent;
import flash.printing.PrintJob;
import flash.printing.PrintUIOptions;

import model.vo.SettingsVO;

import mx.events.FlexEvent;

    import org.osflash.signals.Signal;

    import spark.components.Button;
import spark.components.supportClasses.SkinnableComponent;

public class TicketComponent extends SkinnableComponent {

	[Bindable]public var line1Visible:Boolean;
	[Bindable]public var line1Text:String;
	[Bindable]public var line1FontSize:uint;

	[Bindable]public var line2Visible:Boolean;
	[Bindable]public var line2Text:String;
	[Bindable]public var line2FontSize:uint;

	[Bindable]public var includeTicketNumber:Boolean;
	[Bindable]public var includeTicketTime:Boolean;
	[Bindable]public var ticketBottomText:String;

    [Bindable]public var ticketNumberFontSize:uint;
    [Bindable]public var mainFontSize:uint;

	[Bindable]public var ticketNo:uint;

    [Bindable]public var textMaxWidth:uint = 200;

    public var onPrintSendSignal: Signal = new Signal();

	private var _settings:SettingsVO;


	public function get settings():SettingsVO {
		return _settings;
	}

	public function set settings(value:SettingsVO):void {
		_settings = value;

		line1Visible = settings.line1Visible;
		line1Text = settings.line1Text;
		line1FontSize = settings.line1FontSize;

		line2Visible = settings.line2Visible;
		line2Text = settings.line2Text;
		line2FontSize = settings.line2FontSize;

		includeTicketNumber = settings.includeTicketNumber;
		includeTicketTime = settings.includeTicketTime;
		ticketBottomText = settings.ticketBottomText;
        ticketNumberFontSize = settings.ticketNumberFontSize;
        mainFontSize = settings.mainFontSize;
	}

	public function TicketComponent(ticketNo:uint) {
        this.addEventListener(FlexEvent.UPDATE_COMPLETE, updateCompleteHandler);
		this.setStyle("skinClass", TicketSkin);
        this.ticketNo = ticketNo;
		this.visible = false;
	}

	/*public function printHandler(e:MouseEvent):void {
		(e.target as Button).visible = false;
		print();
	}*/

	private function updateCompleteHandler(e:FlexEvent):void {
		this.removeEventListener(FlexEvent.UPDATE_COMPLETE, updateCompleteHandler);
    	callLater(print);
	}

	private function print():void {
		trace('print job started');
		var printJob:PrintJob = new PrintJob();
		var uiOpt:PrintUIOptions = new PrintUIOptions();
        printJob.addEventListener( IOErrorEvent.IO_ERROR, onPrintComplete );
		printJob.start2(uiOpt, false);
		printJob.addPage(this);
		printJob.send();
	}

    private function onPrintComplete( event: IOErrorEvent ): void
    {
        var printJob: PrintJob = event.target as PrintJob;

        printJob.removeEventListener( IOErrorEvent.IO_ERROR, onPrintComplete );

        onPrintSendSignal.dispatch();
    }

	public function get timeStamp():String{
		var date:Date = new Date();
		var day:String = (date.date < 10 ? '0'+date.date : date.date)+'.'+ (date.month + 1 < 10 ? '0'+( date.month + 1 ) : ( date.month + 1 ) ) +'.'+String(date.fullYear).substr(2,2);
		//var time:String = date.toLocaleTimeString();

		var timeF:String = String( ( date.hours < 10 ? '0' + date.hours : date.hours ) + ':' + ( date.minutes < 10 ? '0' + date.minutes : date.minutes ) + ':' + ( date.seconds < 10 ? '0' + date.seconds : date.seconds ) );
		return day+' '+timeF;//'Время регистрации: '+day+' '+timeF;
	}

}
}
