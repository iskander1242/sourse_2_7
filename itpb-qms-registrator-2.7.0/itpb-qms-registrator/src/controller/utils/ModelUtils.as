/**
 * Created by designer4 on 30.06.14.
 */
package controller.utils {

import flash.display.DisplayObjectContainer;
import flash.xml.XMLDocument;
import flash.xml.XMLNode;

import model.vo.SettingsVO;

import mx.rpc.xml.SimpleXMLEncoder;
import mx.utils.ObjectUtil;

import robotlegs.bender.extensions.viewManager.api.IViewManager;

public class ModelUtils {
	public function ModelUtils() {
	}

	/**
	 * Copies all properties from source object to acceptor.
	 * Used for saving and reverting settings.
	 */
	public static function copyProperties(acceptor:SettingsVO, source:SettingsVO):void {
		var propList:Array = acceptor.properties;

		for(var i:uint = 0; i < propList.length; i++) {
			acceptor[propList[i]] = source[propList[i]];
		}
	}

	/**
	 * Converts source settings object to XML.
	 * Used to save settings as XML file to hard drive.
	 */
	public static function objectToXML(source:*, rootName:String):XML {
		var obj:Object = ObjectUtil.clone(source);
		try {
			delete obj.properties
		}
		catch(e:*) {
		}

		var qName:QName = new QName(rootName);
		var xmlDocument:XMLDocument = new XMLDocument();
		var simpleXMLEncoder:SimpleXMLEncoder = new SimpleXMLEncoder(xmlDocument);
		var xmlNode:XMLNode = simpleXMLEncoder.encodeValue(obj, qName, xmlDocument);
		var xml:XML = new XML(xmlDocument.toString());

		return xml;
	}

	public static function xmlToSettings(source:XML):SettingsVO {
		var settings:SettingsVO = new SettingsVO();

		var propList:Array = settings.properties;
		var prop:String;
		for(var i:uint = 0; i < propList.length; i++) {
			prop = source[propList[i]][0][0];
			if(prop == "false" || prop == "true"){
				settings[propList[i]] = Boolean(prop == "true");
			} else{
				settings[propList[i]] = prop;
			}
		}

		return settings;
	}

	public static function getContainerByClass(vm:IViewManager, clazz:Class):DisplayObjectContainer {
		for(var i:uint=0; i<vm.containers.length; i++){
			if(vm.containers[i] is clazz){
				return vm.containers[i];
			}
		}
		return null;
	}
}
}
