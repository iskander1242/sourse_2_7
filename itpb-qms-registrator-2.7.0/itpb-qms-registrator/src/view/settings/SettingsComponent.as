package view.settings {

import flash.events.MouseEvent;

import org.osflash.signals.Signal;

import spark.components.TitleWindow;

import spark.components.supportClasses.SkinnableComponent;

public class SettingsComponent extends SkinnableComponent {


	public var popupWindow:TitleWindow;

	public var onSaveSettingsSignal:Signal = new Signal();
	public var onCloseSettingsSignal:Signal = new Signal();
	public var onLoadConfigFileSignal:Signal = new Signal();
	public var onSaveConfigFileSignal:Signal = new Signal();

	//===========================================================================

	public function SettingsComponent() {
		this.percentWidth = 100;
		this.percentHeight = 100;
		this.setStyle("skinClass", SettingsComponentSkin);
	}

	//---------------------------------------------------------------------------

	public function saveSettingsHandler(e:MouseEvent):void{
		onSaveSettingsSignal.dispatch();
	}

	public function closeSettingsHandler(e:MouseEvent, save:Boolean=true):void{
		onCloseSettingsSignal.dispatch(save);
	}

	public function loadConfigFile(e:MouseEvent):void{
		onLoadConfigFileSignal.dispatch();
	}

	public function saveConfigFile(e:MouseEvent):void{
		onSaveConfigFileSignal.dispatch();
	}

}
}
