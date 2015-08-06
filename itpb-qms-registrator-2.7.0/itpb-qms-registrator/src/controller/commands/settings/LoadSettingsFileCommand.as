/**
 * Created by designer4 on 01.07.14.
 */
package controller.commands.settings {

import com.junkbyte.console.Cc;

import controller.requests.config.SaveConfigFileRequest;
import controller.requests.settings.SaveSettingsRequest;
import controller.utils.ModelUtils;

import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.FileFilter;

import model.AppProxy;

import model.CurrentSettings;
import model.vo.SettingsVO;

import mx.events.CloseEvent;

import robotlegs.bender.bundles.mvcs.Command;

import spark.components.Alert;

public class LoadSettingsFileCommand extends Command {

	[Inject]
	public var appProxy:AppProxy;

	[Inject]
	public var saveSettingsRequest:SaveSettingsRequest;

	[Inject]
	public var saveAppConfigFileRequest:SaveConfigFileRequest;

	[Inject]
	public var currentSettings:CurrentSettings;

	[Inject]
	public var param_loadQuietly:Boolean;

	private var prefsFile:File;

	//===========================================================================

	public function LoadSettingsFileCommand() {
	}

	//---------------------------------------------------------------------------

	override public function execute():void {
		Cc.log(this);

		// prepare file dfgsrth
		/*if(appProxy.appSettingsPath){
			prefsFile = new File(appProxy.appSettingsPath);
		} else {*/
			prefsFile = File.applicationStorageDirectory;
			prefsFile = prefsFile.resolvePath("config.xml");
		//}

		// load without confirmation
		//if(param_loadQuietly) {
			if(prefsFile.exists) {
				readData(prefsFile);
			} else {
				Alert.show("Файл настроек не найден. Будут использованы настройки по умолчанию.", "Внимание!", Alert.OK, null, alertCloseHandler);
			}
		/*} else {
			// load with browse prompt
			browsePrompt();
		}*/
	}

	private function alertCloseHandler(e:CloseEvent):void {
		switch(e.detail){
			/*case Alert.OK:{
				browsePrompt();
				break;
			}*/
			case Alert.OK:{
				//Alert.show("Использованы настройки по умолчанию.", "Внимание!");
				currentSettings.settings.createDefaultValues();
				saveSettingsRequest.dispatch();
				break;
			}
			default:{break}
		}
	}

	private function browsePrompt():void {
		var filter:FileFilter = new FileFilter("XML", "*.xml");
		prefsFile.addEventListener(Event.SELECT, fileSelectHandler);
		prefsFile.addEventListener(Event.CANCEL, fileCancelHandler);

		try {
			prefsFile.browseForOpen("Загрузить настройки", [filter]);
		}
		catch(e:Error) {
			Alert.show(e.message, e.name);
		}
	}

	private function fileSelectHandler(e:Event):void {
		prefsFile.removeEventListener(Event.SELECT, fileSelectHandler);
		readData(e.target as File);
	}

	private function readData(file:File):void {
		// read file
		var stream:FileStream = new FileStream();
		try {
			stream.open(file, FileMode.READ);
		}
		catch(e:Error) {
			Alert.show(e.message, e.name);
			stream.close();
			return;
		}
		var receivedString:String = stream.readUTFBytes(stream.bytesAvailable);
		stream.close();

		Cc.infoch("Загружен файл настроек: "+prefsFile.nativePath);

		// deserialize
		var receivedXML:XML = new XML(receivedString);
		var newSettings:SettingsVO = ModelUtils.xmlToSettings(receivedXML);

		// apply settings
		ModelUtils.copyProperties(currentSettings.settings, newSettings);
		saveSettingsRequest.dispatch();

		// save appConfig
		//appProxy.appSettingsPath = file.nativePath;
		saveAppConfigFileRequest.dispatch();
	}


	private function fileCancelHandler(e:Event):void {

	}
}
}
