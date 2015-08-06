/**
 * Created by designer4 on 14.07.14.
 */
package view.ApplicationQuit {

import controller.requests.ApplicationQuitRequest;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ApplicationQuitMediator extends Mediator{

	[Inject]
	public var _view:ApplicationQuitComponent;

	[Inject]
	public var applicationQuitRequest:ApplicationQuitRequest;

	public function ApplicationQuitMediator() {
	}

	override public function initialize():void {
		_view.onClickSignal.add(clickHandler);
	}

    override public function destroy(): void
    {
        super.destroy();

        _view.onClickSignal.remove(clickHandler);
    }

	private function clickHandler():void{
		applicationQuitRequest.dispatch(true);
	}
}
}
