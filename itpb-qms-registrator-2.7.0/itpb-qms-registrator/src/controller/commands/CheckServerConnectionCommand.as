/**
 * Created by designer4 on 06.07.14.
 */
package controller.commands {

import com.junkbyte.console.Cc;

    import controller.signals.ResetCheckServerConnectionTimerSignal;

    import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

    import model.AppModel;

    import model.SavedSettings;
    import model.consts.AppConsts;

    import robotlegs.bender.bundles.mvcs.Command;

public class CheckServerConnectionCommand extends Command {

	[Inject]
	public var savedSettings:SavedSettings;

    [Inject]
    public var appModel: AppModel;

    [Inject]
    public var resetCheckServerConnectionTimerSignal: ResetCheckServerConnectionTimerSignal;

	//===========================================================================

	public function CheckServerConnectionCommand() {
	}

	//---------------------------------------------------------------------------

	override public function execute():void {
		//Cc.log(this);

		// prep address
		var prefix:String = "http://";
		var path:String = "/qms/status/get";
		var requestAddress:String = prefix + savedSettings.settings.host + ":" + savedSettings.settings.port + path;

		//Cc.log('Checking server connection, address:' + requestAddress);

		var loader:URLLoader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, completeHandler);
		loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);

		try {
			loader.load(new URLRequest(requestAddress));
		}
		catch(error:Error) {
			Cc.errorch('Error:', 'CheckServerConnectionCommand  --->  message:' + error.message);
			savedSettings.settings.connectColor = 0x990000;
            if( appModel.isTicketButtonActive )
            {
                appModel.isTicketButtonActive = false;
                appModel.errorMessage = AppConsts.SERVER_UNAVAILABLE_MESSAGE;
                //appModel.showErrorMessage = true;
            }
            resetTimer();
		}
	}

	private function completeHandler(e:Event):void {
		var rawData:* = (e.target as URLLoader).data;
		var results:* = {};

		try {
			results = JSON.parse(rawData);
		}
		catch(error:Error) {
			Cc.errorch('Error:',  'CheckServerConnectionCommand  --->  message:' + error.message);
			savedSettings.settings.connectColor = 0x990000;
            if( appModel.isTicketButtonActive )
            {
                appModel.isTicketButtonActive = false;
                appModel.errorMessage = AppConsts.SERVER_UNAVAILABLE_MESSAGE;
                //appModel.showErrorMessage = true;
            }
            resetTimer();
			return;
		}

		//Cc.infoch('Server connection status received:' + results);

		if(results.success) {
			savedSettings.settings.connectColor = 0x006600;
            if( !appModel.isTicketButtonActive )
            {
                appModel.isTicketButtonActive = true;
                appModel.errorMessage = null;
                //appModel.showErrorMessage = false;
            }
            resetTimer();
		} else {
			savedSettings.settings.connectColor = 0x990000;
            if( appModel.isTicketButtonActive )
            {
                appModel.isTicketButtonActive = false;

                if( results.errorCode == 'ERROR_NO_PAPER' )
                {
                    appModel.errorMessage = results.errorMessage;
                } else {
                    if( results.errorCode == 'ERROR_REG_OUT_OF_TIME' )
                    {
                        appModel.errorMessage = results.errorMessage;
                    }
                }

                //appModel.showErrorMessage = true;
            }
            resetTimer();
		}
	}

	private function errorHandler(errorEvent:ErrorEvent):void {
		Cc.errorch('Error!', 'CheckServerConnectionCommand  --->  type:' + errorEvent.type, 'text:' + errorEvent.text);
		savedSettings.settings.connectColor = 0x990000;
        if( appModel.isTicketButtonActive )
        {
            appModel.isTicketButtonActive = false;
            appModel.errorMessage = AppConsts.SERVER_UNAVAILABLE_MESSAGE;
            //appModel.showErrorMessage = true;
        }
        resetTimer();
	}

    private function resetTimer(): void
    {
        resetCheckServerConnectionTimerSignal.dispatch();
    }
}
}
