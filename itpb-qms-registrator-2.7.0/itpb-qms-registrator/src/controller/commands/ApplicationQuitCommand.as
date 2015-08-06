/**
 * Created by designer4 on 14.07.14.
 */
package controller.commands {

import com.junkbyte.console.Cc;

import controller.requests.ApplicationQuitRequest;
import controller.requests.pincode.OpenPincodeRequest;

import flash.desktop.NativeApplication;

import model.AppProxy;
import model.SavedSettings;

import robotlegs.bender.bundles.mvcs.Command;

public class ApplicationQuitCommand extends Command {

	[Inject]
	public var param_withPermission:Boolean;

	[Inject]
	public var appProxy:AppProxy;

	[Inject]
	public var savedSettings:SavedSettings;

	[Inject]
	public var openPincodeRequest:OpenPincodeRequest;

	[Inject]
	public var applicationQuitRequest:ApplicationQuitRequest;

	public function ApplicationQuitCommand() {
	}

	override public function execute():void {
		Cc.log(this);

		if(param_withPermission) {
			if(savedSettings.settings.closeProtected) {
				openPincodeRequest.dispatch(applicationQuitRequest);
			} else {
				appExit();
			}
		} else {
			appExit();
		}
	}

	private static function appExit():void {
		NativeApplication.nativeApplication.exit();
	}
}
}
