/**
 * Created by designer4 on 08.07.14.
 */
package view.pincodePopup {

import com.junkbyte.console.Cc;

import controller.requests.pincode.ClosePincodeRequest;
import controller.requests.pincode.PincodeResetRequest;
import controller.requests.pincode.PincodeSubmitRequest;

import model.AppProxy;

import robotlegs.bender.bundles.mvcs.Mediator;

import spark.components.Alert;

public class PincodePopupMediator extends Mediator {

	[Inject]
	public var _view:PincodePopupComponent;

	[Inject]
	public var appProxy:AppProxy;

	[Inject]
	public var pinCodeResetRequest:PincodeResetRequest;

	[Inject]
	public var pincodeSubmitRequest:PincodeSubmitRequest;

	[Inject]
	public var closePopupRequest:ClosePincodeRequest;

	public function PincodePopupMediator() {
	}

	override public function initialize():void {
		_view.onResetSignal.add(resetHandler);
		_view.onSubmitSignal.add(submitHandler);

		pinCodeResetRequest.add(resetHandler);
		pincodeSubmitRequest.add(submitHandler);
	}

    override public function destroy(): void
    {
        super.destroy();

        _view.onResetSignal.remove(resetHandler);
        _view.onSubmitSignal.remove(submitHandler);

        pinCodeResetRequest.remove(resetHandler);
        pincodeSubmitRequest.remove(submitHandler);
    }

	private function resetHandler():void {
		_view.pincodeText = "";
	}

	private function submitHandler():void {
		Cc.log('Pincode submitted:'+_view.pincodeText);

		if(_view.pincodeText == appProxy.password) {
			_view.onSuccessRequest.dispatch(false);
			resetHandler();
			closePopupRequest.dispatch();
		} else {
			Alert.show("Неверный пароль","Ошибка");
			resetHandler();
		}
	}


}
}
