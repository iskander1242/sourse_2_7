package controller.commands {

import com.junkbyte.console.Cc;

import flash.display.Sprite;

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.printing.PrintJob;
import flash.printing.PrintUIOptions;

	import model.AppModel;

	import model.CurrentSettings;
	import model.consts.AppConsts;
	import model.vo.TicketVO;

import mx.core.IVisualElement;

import mx.managers.PopUpManager;

import robotlegs.bender.bundles.mvcs.Command;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.viewManager.api.IViewManager;

import spark.components.Alert;
import spark.components.TitleWindow;

import view.ticket.TicketComponent;

public class TakeTicketCommand extends Command {

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var contextView:ContextView;

	[Inject]
	public var appModel: AppModel;

    private var popup:TicketComponent;

	override public function execute():void {
		var prefix:String = "http://";
		var path:String = "/qms/reg/register";
		var requestAddress:String = prefix
				                  + currentSettings.settings.host
								  + ":"
								  + currentSettings.settings.port
								  + path;

		//Cc.log('Ticket requested, address:'+requestAddress);

		var loader:URLLoader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, completeHandler);
		loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);

		try {
			loader.load(new URLRequest(requestAddress));
		}
		catch(error:Error) {
			appModel.isTicketButtonActive = false;
			appModel.errorMessage = AppConsts.SERVER_UNAVAILABLE_MESSAGE;//Alert.show(error.message, error.name);
			Cc.errorch('Error:', 'Could not connect to server --> message:' + error.message);
		}
		// imitate results {"errorMessage":null,"success":true,"ticketOrderNo":1}
//		var ticket:TicketVO = new TicketVO(null, true, 122);
//		printResults(ticket);
	}

	private function completeHandler(e:Event):void {
		var rawData:* = (e.target as URLLoader).data;
		var results:* = {};

		try {
			results = JSON.parse(rawData);
		}
		catch(error:Error) {
			Cc.errorch('Error:',  'TakeTicketCommand - Error in JSON parse  --->  message:' + error.message);
			return;
		}

		if(results.success){
			if( !appModel.isTicketButtonActive )
			{
				appModel.isTicketButtonActive = true;
				appModel.errorMessage = null;
			}
			var ticket:TicketVO = new TicketVO(results.errorMessage as String,
											   results.success as Boolean,
					 						   results.ticketOrderNo as uint);
			if( !appModel.noPrintToPrinter )
				printResults(ticket);
		} else {
			appModel.isTicketButtonActive = false;
			appModel.errorMessage = AppConsts.SERVER_UNAVAILABLE_MESSAGE;//Alert.show('Извините, связь с сервером потеряна. Пожалуйста, обратитесь к администратору.', "Ошибка");
		}
	}

	private function errorHandler(errorEvent:ErrorEvent):void {
		Cc.errorch('Error:', 'Could not connect to server --> message:' + errorEvent.text);
		appModel.isTicketButtonActive = false;
		appModel.errorMessage = AppConsts.SERVER_UNAVAILABLE_MESSAGE;
	}

	private function printResults(ticket:TicketVO):void
	{
		popup = new TicketComponent(ticket.ticketOrderNo);
		popup.settings = currentSettings.settings;
        popup.onPrintSendSignal.addOnce( removeTicketComponent );
		(contextView.view as QmsRegistrator).addElement(popup);
	}

    private function removeTicketComponent(): void
    {
        (contextView.view as QmsRegistrator).removeElement(popup);
    }

	private function closeHandler(e:Event):void{
		PopUpManager.removePopUp(e.target as TitleWindow);
	}
}
}
