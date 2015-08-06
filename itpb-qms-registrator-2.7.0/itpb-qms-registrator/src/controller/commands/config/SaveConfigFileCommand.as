/**
 * Created by designer4 on 05.07.14.
 */
package controller.commands.config {

import com.junkbyte.console.Cc;

import controller.utils.ModelUtils;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import model.AppProxy;

import robotlegs.bender.bundles.mvcs.Command;

public class SaveConfigFileCommand extends Command {

	[Inject]
	public var appProxy:AppProxy;

	//===========================================================================

	public function SaveConfigFileCommand() {}

	override public function execute():void {
		Cc.log(this);
		//prepare XML
		var outputXML:XML = ModelUtils.objectToXML(appProxy, "ApplicationProxy");
		var outputString:String = '<?xml version="1.0" encoding="utf-8"?>\n';
		outputString += outputXML.toXMLString();
		outputString = outputString.replace(/\n/g, File.lineEnding);

		//prepare File
		var prefsFile:File = File.applicationStorageDirectory;
		prefsFile = prefsFile.resolvePath("appConfig.xml");

        /*if(!prefsFile.exists){
            return;
        }*/
		// write file
		var stream:FileStream = new FileStream();
		stream.openAsync(prefsFile, FileMode.WRITE);
		stream.writeUTFBytes(outputString);
		stream.close();

		//Cc.infoch("Сохранен файл модели: "+prefsFile.nativePath);
	}

}
}
