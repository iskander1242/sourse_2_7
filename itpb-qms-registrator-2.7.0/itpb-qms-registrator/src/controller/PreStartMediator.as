/**
 * Created by designer4 on 04.07.14.
 */
package controller {

import controller.requests.PreStartRequest;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PreStartMediator extends Mediator {

	[Inject]
	public var _view:PreStartController;

	[Inject]
	public var preStartRequest:PreStartRequest;

	public function PreStartMediator() {
	}

	override public function initialize():void {
		preStartRequest.dispatch();
	}
}
}
