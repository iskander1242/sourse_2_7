/**
 * Created by designer4 on 13.07.14.
 */
package controller.commands.changePassword {

import com.junkbyte.console.Cc;

import mx.events.CloseEvent;
import mx.managers.PopUpManager;

import robotlegs.bender.bundles.mvcs.Command;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.viewManager.api.IViewManager;

import spark.components.TitleWindow;

import view.ChangePassword.ChangePasswordComponent;

public class ChangePasswordCommand extends Command {

	[Inject]
	public var contextView:ContextView;

	[Inject]
	public var vm:IViewManager;

	public var popup:ChangePasswordComponent;

	public function ChangePasswordCommand() {
	}


	override public function execute():void {
		Cc.log(this);

		popup = new ChangePasswordComponent();
		vm.addContainer(popup);

		var window:TitleWindow = new TitleWindow();
		window.title = "Изменение пароля";
		window.addEventListener(CloseEvent.CLOSE, closeHandler);
		window.addElement(popup);

		popup.popupWindow = window;

		PopUpManager.addPopUp(window, contextView.view, true);
		PopUpManager.centerPopUp(window);
	}

	private function closeHandler(e:CloseEvent):void {
		vm.removeContainer(popup);
		PopUpManager.removePopUp(e.target as TitleWindow);
	}
}
}
