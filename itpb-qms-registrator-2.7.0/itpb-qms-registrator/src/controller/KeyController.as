/**
 * Created by designer4 on 6/11/14.
 */
package controller {
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import org.osflash.signals.Signal;

import spark.core.SpriteVisualElement;

public class KeyController extends SpriteVisualElement {

	public var onOpenSettings:Signal = new Signal();
	public var onCloseSettings:Signal = new Signal();

	public function KeyController() {
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	private function onAddedToStage(e:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}

	private function onKeyUp(e:KeyboardEvent):void {
		if (e.altKey && e.keyCode == Keyboard.F5) {
			onOpenSettings.dispatch();
		}
		if(e.keyCode == Keyboard.ESCAPE){
			onCloseSettings.dispatch();
		}
	}


}
}
