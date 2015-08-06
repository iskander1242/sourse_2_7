/**
 * Created by designer4 on 30.06.14.
 */
package view.copyright {

import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;
	import flash.utils.setTimeout;

	import model.consts.AppConsts;

	import org.osflash.signals.Signal;

import spark.components.supportClasses.SkinnableComponent;

public class CopyrightComponent extends SkinnableComponent {

	[Bindable]
	public var copyright:String;

	[Bindable]
	public var errorMessage:String;

    [Bindable]
    public var copyrightTextColor:uint;

	[Bindable]
	public var copyrightTextFontSize:uint;

	public var onOpenSettingsSignal:Signal = new Signal();

	private var clickTimer:Timer = new Timer(2000, 1);
	private var clickCount:uint = 0;

	private var commonText: String;

	public function CopyrightComponent(){
		this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	public function showPrintText( value: Boolean ): void
	{
		if( value )
		{
			commonText = copyright;
			copyright = AppConsts.PRINT_TICKET_MESSAGE;
		} else {
			copyright = commonText;
		}
	}

	private function onAddedToStage(e:Event):void {
		this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		this.addEventListener(MouseEvent.CLICK, clickHandler);
		clickTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
	}

	protected function clickHandler(e:MouseEvent):void {
		// if running, counting clicks
		if( clickTimer.running ) {
			clickCount++;
			if(clickCount >= 5){
				clickCount = 0;
				clickTimer.stop();
				clickTimer.reset();
				onOpenSettingsSignal.dispatch();
			}
		} else {
			// if timer stopped, starting it
			clickCount = 1;
			clickTimer.start();
		}
	}

	protected function timerCompleteHandler(e:TimerEvent):void {
		clickCount = 0;
	}
}
}
