package view.background {

import spark.components.supportClasses.SkinnableComponent;

public class BackgroundComponent extends SkinnableComponent {

	[Bindable]
	public var backgroundType:uint;

	[Bindable]
	public var backgroundImageURL:String;

	[Bindable]
	public var backgroundColor:uint;

	//===========================================================================

	public function BackgroundComponent(){}
}
}
