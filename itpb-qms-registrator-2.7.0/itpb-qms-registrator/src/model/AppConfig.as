/**
 * Created by designer4 on 6/4/14.
 */
package model {

import controller.KeyController;
import controller.KeyControllerMediator;
import controller.PreStartController;
import controller.PreStartMediator;
    import controller.ServerConnectionController;
    import controller.ServerConnectionMediator;
    import controller.commands.ApplicationQuitCommand;
import controller.commands.changePassword.ChangePasswordCommand;
import controller.commands.CheckServerConnectionCommand;
import controller.commands.changePassword.CloseChangePasswordCommand;
import controller.commands.pincode.ClosePincodeCommand;
import controller.commands.config.LoadConfigFileCommand;
import controller.commands.settings.CloseSettingsCommand;
import controller.commands.settings.LoadSettingsFileCommand;
import controller.commands.settings.OpenSettingsCommand;
import controller.commands.pincode.OpenPincodeCommand;
import controller.commands.PreStartCommand;
import controller.commands.settings.RevertSettingsCommand;
import controller.commands.config.SaveConfigFileCommand;
import controller.commands.settings.SaveSettingsFileCommand;
import controller.commands.settings.SaveSettingsCommand;
import controller.commands.TakeTicketCommand;
import controller.requests.ApplicationQuitRequest;
import controller.requests.changePassword.ChangePasswordRequest;
import controller.requests.CheckServerConnectionRequest;
import controller.requests.changePassword.CloseChangePasswordRequest;
import controller.requests.pincode.ClosePincodeRequest;
import controller.requests.settings.CloseSettingsRequest;
import controller.requests.config.LoadConfigFileRequest;
import controller.requests.settings.LoadSettingsFileRequest;
import controller.requests.settings.OpenSettingsRequest;
import controller.requests.pincode.OpenPincodeRequest;
import controller.requests.pincode.PincodeResetRequest;
import controller.requests.pincode.PincodeSubmitRequest;
import controller.requests.PreStartRequest;
import controller.requests.settings.RevertSettingsRequest;
import controller.requests.config.SaveConfigFileRequest;
import controller.requests.settings.SaveSettingsFileRequest;
import controller.requests.settings.SaveSettingsRequest;
import controller.requests.TakeTicketReqest;
    import controller.signals.ResetCheckServerConnectionTimerSignal;
	import controller.signals.ShowPrintTicketSignal;

	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

import view.ApplicationQuit.ApplicationQuitComponent;
import view.ApplicationQuit.ApplicationQuitMediator;

import view.ChangePassword.ChangePasswordComponent;
import view.ChangePassword.ChangePasswordMediator;

import view.background.BackgroundComponent;
import view.background.BackgroundMediator;
import view.copyright.CopyrightComponent;
import view.copyright.CopyrightMediator;
    /*import view.errorMessage.ErrorMessageComponent;
    import view.errorMessage.ErrorMessageMediator;*/
    import view.pincodePopup.PincodePopupComponent;
import view.pincodePopup.PincodePopupMediator;
import view.settings.SettingsComponent;
import view.settings.SettingsComponentMediator;
import view.settings.tabs.AppearanceTab;
import view.settings.tabs.AppearanceTabMediator;
import view.settings.tabs.CommunicationsTab;
import view.settings.tabs.CommunicationsTabMediator;
import view.settings.tabs.TicketTab;
import view.settings.tabs.TicketTabMediator;
import view.takeTicket.TakeTicketComponent;
import view.takeTicket.TakeTicketMediator;

public class AppConfig implements IConfig {

	[Inject]
	public var injector:IInjector;
	[Inject]
	public var mediatorMap:IMediatorMap;
	[Inject]
	public var signalCommandMap:ISignalCommandMap;

	//===========================================================================

	public function configure():void {
		dependencies();
		mediators();
		signals();
	}

	//---------------------------------------------------------------------------

	private function dependencies():void {
        injector.map(AppModel).asSingleton(true);
		injector.map(AppProxy).asSingleton(true);
		injector.map(CurrentSettings).asSingleton(true);
		injector.map(SavedSettings).asSingleton(true);

		injector.map(PincodeResetRequest).asSingleton();
		injector.map(PincodeSubmitRequest).asSingleton();
        injector.map( ResetCheckServerConnectionTimerSignal ).asSingleton();
		injector.map( ShowPrintTicketSignal ).asSingleton();
	}

	private function mediators():void {
		mediatorMap.map(PreStartController).toMediator(PreStartMediator);
		mediatorMap.map(TakeTicketComponent).toMediator(TakeTicketMediator);
		mediatorMap.map(KeyController).toMediator(KeyControllerMediator);
        mediatorMap.map( ServerConnectionController ).toMediator( ServerConnectionMediator );

        //mediatorMap.map( ErrorMessageComponent ).toMediator( ErrorMessageMediator );

		// Settings mapping
		mediatorMap.map(SettingsComponent).toMediator(SettingsComponentMediator);
		mediatorMap.map(AppearanceTab).toMediator(AppearanceTabMediator);
		mediatorMap.map(TicketTab).toMediator(TicketTabMediator);
		mediatorMap.map(CommunicationsTab).toMediator(CommunicationsTabMediator);

		// views mapping
		mediatorMap.map(BackgroundComponent).toMediator(BackgroundMediator);
		mediatorMap.map(CopyrightComponent).toMediator(CopyrightMediator);
		mediatorMap.map(PincodePopupComponent).toMediator(PincodePopupMediator);
		mediatorMap.map(ChangePasswordComponent).toMediator(ChangePasswordMediator);

		mediatorMap.map(ApplicationQuitComponent).toMediator(ApplicationQuitMediator);
	}

	private function signals():void {
		signalCommandMap.map(PreStartRequest).toCommand(PreStartCommand);

		signalCommandMap.map(TakeTicketReqest).toCommand(TakeTicketCommand);

		signalCommandMap.map(OpenSettingsRequest).toCommand(OpenSettingsCommand);
		signalCommandMap.map(CloseSettingsRequest).toCommand(CloseSettingsCommand);

		signalCommandMap.map(SaveSettingsRequest).toCommand(SaveSettingsCommand);
		signalCommandMap.map(RevertSettingsRequest).toCommand(RevertSettingsCommand);

		signalCommandMap.map(SaveSettingsFileRequest).toCommand(SaveSettingsFileCommand);
		signalCommandMap.map(LoadSettingsFileRequest).toCommand(LoadSettingsFileCommand);
		signalCommandMap.map(SaveConfigFileRequest).toCommand(SaveConfigFileCommand);
		signalCommandMap.map(LoadConfigFileRequest).toCommand(LoadConfigFileCommand);

		signalCommandMap.map(CheckServerConnectionRequest).toCommand(CheckServerConnectionCommand);

		signalCommandMap.map(OpenPincodeRequest).toCommand(OpenPincodeCommand);
		signalCommandMap.map(ClosePincodeRequest).toCommand(ClosePincodeCommand);

		signalCommandMap.map(ChangePasswordRequest).toCommand(ChangePasswordCommand);
		signalCommandMap.map(CloseChangePasswordRequest).toCommand(CloseChangePasswordCommand);

		signalCommandMap.map(ApplicationQuitRequest).toCommand(ApplicationQuitCommand);


	}

}
}
