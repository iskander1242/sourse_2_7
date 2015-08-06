/**
 * Created by designer4 on 04.07.14.
 */
package model {

import flash.utils.describeType;

public class AppProxy {

	//public var appSettingsPath:String;
	public var password:String;

	public var properties:Array;

	//===========================================================================

	public function AppProxy() {
		properties = enumerateProperties();
		password = "1234";
	}

	private function enumerateProperties():Array {
		var propList:Array = [];

		var typeXML:XML = describeType(this);
		var propXMLList:XMLList = typeXML..variable.@name;

		for(var i:uint = 0; i < propXMLList.length(); i++) {
			var prop:String = propXMLList[i].toString();

			if(prop != "properties")
				propList.push(prop);
		}

		return propList;
	}
}
}
