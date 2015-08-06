/**
 * Created by designer4 on 14.07.14.
 */
package view.ApplicationQuit {

import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import org.osflash.signals.Signal;

import spark.components.supportClasses.SkinnableComponent;

public class ApplicationQuitComponent extends SkinnableComponent {

	public var onClickSignal:Signal = new Signal();
    public var clickCount: uint = 0;
    public var clickTimer: Timer = new Timer( 2000, 1 );

	public function ApplicationQuitComponent() {
		this.setStyle("skinClass", ApplicationQuitSkin);
        clickTimer.addEventListener( TimerEvent.TIMER_COMPLETE, onTimerComplete );
	}

	public function clickHandler(e:MouseEvent):void
	{
        // if running, counting clicks
        if(clickTimer.running) {
            clickCount++;
            if(clickCount >= 5){
                clickCount = 0;
                clickTimer.reset();
                onClickSignal.dispatch();
            }
        } else
        {
            // if timer stopped, starting it
            clickCount = 1;
            clickTimer.start();
        }
	}

    private function onTimerComplete( event: TimerEvent ): void
    {
        clickCount = 0;
    }
}
}
