package controller.commands.settings {

import com.junkbyte.console.Cc;

import controller.requests.pincode.OpenPincodeRequest;
import controller.requests.settings.CloseSettingsRequest;
import controller.requests.settings.OpenSettingsRequest;

import flash.display.DisplayObjectContainer;
import flash.events.Event;

import model.AppProxy;
import model.CurrentSettings;

import mx.events.CloseEvent;
import mx.events.FlexMouseEvent;
import mx.managers.PopUpManager;

import robotlegs.bender.bundles.mvcs.Command;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.viewManager.api.IViewManager;

import spark.components.TitleWindow;

import view.settings.SettingsComponent;

public class OpenSettingsCommand extends Command {

	[Inject]
	public var param_wthPermission:Boolean;

	[Inject]
	public var appProxy:AppProxy;

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var vm:IViewManager;

	[Inject]
	public var contextView:ContextView;

	[Inject]
	public var openPincodeRequest:OpenPincodeRequest;

	[Inject]
	public var openSettingsRequest:OpenSettingsRequest;

	[Inject]
	public var closeSettingsRequest:CloseSettingsRequest;

	public var popup:SettingsComponent;

	override public function execute():void {
		//Cc.log(this);

		if(param_wthPermission) {
			if(currentSettings.settings.settingsProtected) {
				openPincodeRequest.dispatch(openSettingsRequest);
			} else {
				openSettings();
			}
		} else {
			openSettings();
		}

	}

	private function openSettings():void {
		var parent:DisplayObjectContainer = contextView.view;

		var window:TitleWindow = new TitleWindow();
		window.width = 680;
		window.height = 760;
		window.title = "Настройки регистратора";
		window.addEventListener(CloseEvent.CLOSE, closeHandler);
		//window.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, closeHandler);

		popup = new SettingsComponent();
		vm.addContainer(popup);

		window.addElement(popup);
		popup.popupWindow = window;

		PopUpManager.addPopUp(window, parent, true);
		PopUpManager.centerPopUp(window);
	}

	private function closeHandler(e:Event):void {
		closeSettingsRequest.dispatch(false);
	}

}
}
