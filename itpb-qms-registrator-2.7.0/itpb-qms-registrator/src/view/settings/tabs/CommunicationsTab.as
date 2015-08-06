package view.settings.tabs {

import org.osflash.signals.Signal;

import spark.components.NavigatorContent;
import spark.events.TextOperationEvent;

public class CommunicationsTab extends NavigatorContent {

	[Bindable]
	public var host:String;

	[Bindable]
	public var port:String;

	[Bindable]
	public var connectColor:uint;

	//-------------------------------------------------------

	public var onHostChangedSignal:Signal = new Signal();
	public var onPortChangedSignal:Signal = new Signal();

	//===========================================================================

	public function CommunicationsTab() {
	}

	//-------------------------------------------------------

	public function hostChangedHandler(e:TextOperationEvent):void {
		onHostChangedSignal.dispatch(e);
	}

	public function portChangedHandler(e:TextOperationEvent):void {
		onPortChangedSignal.dispatch(e);
	}
}
}
