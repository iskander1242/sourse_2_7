/**
 * Created by designer4 on 08.07.14.
 */
package view.numpad {

import flash.events.Event;

public class NumpadEvent extends Event {

	public static const KEY:String = "numpadKey";

	public var value:String;

	public function NumpadEvent(type:String) {
		super(type);
	}

	override public function clone():Event {
		var cloneEvent:NumpadEvent = new NumpadEvent(type);
		cloneEvent.value = this.value;
		return cloneEvent;
	}

}
}
