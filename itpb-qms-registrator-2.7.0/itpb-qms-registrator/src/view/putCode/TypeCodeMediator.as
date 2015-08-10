/**
 * Created by designer4 on 13.07.14.
 */
package view.putCode {
import controller.requests.TakeTicketReqest;
import controller.signals.ShowPrintTicketSignal;

import view.putCode.*;

import com.junkbyte.console.Cc;

import controller.requests.changePassword.CloseChangePasswordRequest;
import controller.requests.config.SaveConfigFileRequest;

import model.AppProxy;

import robotlegs.bender.bundles.mvcs.Mediator;

import spark.components.Alert;

public class TypeCodeMediator extends Mediator {

	[Inject]
	public var _view:TypeCodeComponent;

	[Inject]
	public var closeChangePasswordRequest:CloseChangePasswordRequest;

	[Inject]
	public var appProxy:AppProxy;

	[Inject]
	public var saveConfigFileRequest:SaveConfigFileRequest;

	[Inject]
	public var takeTicketRequest:TakeTicketReqest;

	[Inject]
	public var showPrintTicketSignal:ShowPrintTicketSignal;

	public function TypeCodeMediator() {
		super();
	}

	override public function initialize():void {
		_view.onResetSignal.add(resetHandler);
		_view.onSubmitSignal.add(submitHandler);
		_view.onCancelSignal.add(closeHandler);
	}

    override public function destroy(): void
    {
        super.destroy();

        _view.onResetSignal.remove(resetHandler);
        _view.onSubmitSignal.remove(submitHandler);
        _view.onCancelSignal.remove(closeHandler);
    }

	private function resetHandler():void {
		_view.activeTextInput.text = "";
	}

	private function submitHandler():void {
//		if(_view.oldPassword != appProxy.password) {
//			Alert.show("Действующий пароль неверен.", "Ошибка");
//			return;
//		}
//		if(_view.newPassword != _view.confirmPassword) {
//			Alert.show("Пароли не совпадают.", "Ошибка");
//			return;
//		}
//		appProxy.password = _view.newPassword;
//        Alert.show("Пароль успешно изменен.", "Информация");
//		//Cc.log("Пароль изменен, новый пароль: " + appProxy.password);
//		saveConfigFileRequest.dispatch();
//		closeChangePasswordRequest.dispatch();
		Alert.show("submitHandler1111");
		showPrintTicketSignal.dispatch(true);
		takeTicketRequest.dispatch();
	}

	private function closeHandler():void {
		//closeChangePasswordRequest.dispatch();
	}
}
}
