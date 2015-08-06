/**
 * Created by designer4 on 05.07.14.
 */
package controller.commands.config {

import com.junkbyte.console.Cc;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import model.AppProxy;

import robotlegs.bender.bundles.mvcs.Command;

import spark.components.Alert;

public class LoadConfigFileCommand extends Command {

	[Inject]
	public var appProxy:AppProxy;

	public function LoadConfigFileCommand() {
	}


	override public function execute():void {
		Cc.log(this);

		//prepare file
		var prefsFile:File = File.applicationStorageDirectory;
		prefsFile = prefsFile.resolvePath("appConfig.xml");

		if(!prefsFile.exists){
			return;
		}

		// read file
		var stream:FileStream = new FileStream();
		stream.open(prefsFile, FileMode.READ);
		var receivedString:String = stream.readUTFBytes(stream.bytesAvailable);
		stream.close();

		// deserialize data and apply to appProxy
		var receivedXML:XML = new XML(receivedString);

		var propList:Array = appProxy.properties;
		for (var i:uint=0; i<propList.length; i++){
			appProxy[propList[i]] = receivedXML[propList[i]];
		}
	}
}
}
