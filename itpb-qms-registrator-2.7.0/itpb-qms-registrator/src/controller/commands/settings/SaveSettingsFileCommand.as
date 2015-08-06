package controller.commands.settings {

import com.junkbyte.console.Cc;

import controller.requests.config.SaveConfigFileRequest;
import controller.requests.settings.SaveSettingsRequest;
import controller.utils.ModelUtils;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import model.AppProxy;
import model.SavedSettings;

import robotlegs.bender.bundles.mvcs.Command;

import spark.components.Alert;

/**
 * Generates XML from <code>SavedSettings</code> and saves is as config.xml file to hard drive.
 *
 */
public class SaveSettingsFileCommand extends Command {

	[Inject]
	public var saveSettingsRequest:SaveSettingsRequest;

	[Inject]
	public var savedSettings:SavedSettings;

	[Inject]
	public var appProxy:AppProxy;

	[Inject]
	public var saveAppConfigFileRequest:SaveConfigFileRequest;

	//---------------------------------------------------------------------------

	private var prefsFile:File;
	private var stream:FileStream;
	private var outputString:String;

	//===========================================================================

	public function SaveSettingsFileCommand() {
	}

	override public function execute():void {
		Cc.log(this);

		// save current settings
		saveSettingsRequest.dispatch();

		// prepare XML
		var settingsXML:XML = ModelUtils.objectToXML(savedSettings.settings, "RegistratorSettings");
		outputString = '<?xml version="1.0" encoding="utf-8"?>\n';
		outputString += settingsXML.toXMLString();
		outputString = outputString.replace(/\n/g, File.lineEnding);

		// prepare file
		prefsFile = File.applicationStorageDirectory;
		prefsFile = prefsFile.resolvePath("config.xml");

        var stream:FileStream = new FileStream();
        stream.openAsync(prefsFile, FileMode.WRITE);
        stream.writeUTFBytes(outputString);
        stream.close();
		/*prefsFile.addEventListener(Event.SELECT, fileSelectHandler);
		prefsFile.addEventListener(IOErrorEvent.IO_ERROR, browseIOErrorHandler, false, 0, true);

		try {
			prefsFile.browseForSave("Сохранить настройки");
		}
		catch(e:Error) {
			Alert.show(e.message, e.name);
			Cc.errorch(e.message, e.name);

			prefsFile.removeEventListener(Event.SELECT, fileSelectHandler);
			prefsFile.removeEventListener(IOErrorEvent.IO_ERROR, browseIOErrorHandler);
		}*/

	}

	private function fileSelectHandler(e:Event):void {
		prefsFile.removeEventListener(Event.SELECT, fileSelectHandler);

		var newFile:File = e.target as File;
		saveData(newFile);

		//appProxy.appSettingsPath = newFile.nativePath;
		saveAppConfigFileRequest.dispatch();
	}

	private function saveData(file:File):void {
		stream = new FileStream();
		try {
			stream.open(file, FileMode.WRITE);
		}
		catch(e:Error) {
			Alert.show(e.message, e.name);
			stream.close();

			prefsFile.removeEventListener(Event.SELECT, fileSelectHandler);
			prefsFile.removeEventListener(IOErrorEvent.IO_ERROR, browseIOErrorHandler);

			return;
		}
		stream.writeUTFBytes(outputString);
		stream.close();

		Cc.infoch('Saved settings as: '+prefsFile.nativePath);

		prefsFile.removeEventListener(Event.SELECT, fileSelectHandler);
		prefsFile.removeEventListener(IOErrorEvent.IO_ERROR, browseIOErrorHandler);
	}

	private function browseIOErrorHandler(e:IOErrorEvent):void {
		prefsFile.removeEventListener(IOErrorEvent.IO_ERROR, browseIOErrorHandler);
		Alert.show(e.type, "Операция не поддерживается на данном устройстве.");
	}
}
}
