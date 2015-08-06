/**
 * Created by designer4 on 6/11/14.
 */
package view {

import com.junkbyte.console.Cc;

import flash.events.Event;

import spark.core.SpriteVisualElement;

public class ConsoleComponent extends SpriteVisualElement {

	public function ConsoleComponent() {
		this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
	}

	private function addedToStageHandler(e:Event):void {
		Cc.config.commandLineAllowed = true;
		Cc.config.commandLineAutoCompleteEnabled = true;
		Cc.config.commandLineAutoScope = true;

		Cc.startOnStage(this, "`");
	}
}
}
