package model.vo {

import flash.events.EventDispatcher;
import flash.utils.describeType;

import model.consts.BackgroundType;

[Bindable]
public class SettingsVO extends EventDispatcher {

	// Title
	public var copyright:String;
    public var copyrightTextColor:uint;
	public var copyrightTextFontSize:uint;

	// Main Background
	public var backgroundType:uint;
	public var backgroundImageURL:String;
	public var backgroundColor:uint;

	// Ticket Button Appearance
	public var takeTicketText:String;
	public var ticketWidth:uint;
	public var ticketHeight:uint;
    public var ticketTextFontSize:uint;
	public var ticketFont:String;
	public var ticketFontColor:uint;
	public var ticketBackground:uint;
	// Passwords
	//TODO add passwords protection feature
	public var actualPassword:String;
	public var closeProtected:Boolean;
	public var settingsProtected:Boolean;

	// Ticket Design
	public var line1Visible:Boolean;
	public var line1Text:String;
	public var line1FontSize:uint;

	public var line2Visible:Boolean;
	public var line2Text:String;
	public var line2FontSize:uint;

	public var includeTicketNumber:Boolean;
	public var includeTicketTime:Boolean;
	public var ticketBottomText:String;
    public var ticketNumberFontSize:uint;
    public var mainFontSize:uint;

	public var noPrintToPrinter: Boolean;


	// Communications
	public var host:String;
	public var port:String;
	public var connectColor:uint;

	//-------------------------------------------------------

	// enumerable properties
	public var properties:Array;

	//=======================================================

	public function SettingsVO() {
		properties = enumerateProperties();
	}

	public function createDefaultValues():void {

		// Title
		copyright = 'Система управления очередью';
        copyrightTextColor = 0x000000;
		copyrightTextFontSize = 16;

		// Main Background

		backgroundType = BackgroundType.SOLID_COLOR;
		backgroundImageURL = "";
		backgroundColor = 0xFFFFFF;

		// Ticket Appearance
		takeTicketText = "Взять талон";
		ticketWidth = 400;
		ticketHeight = 120;
        ticketTextFontSize = 26;
		ticketFont = "Arial";
		ticketFontColor = 0x00FF00;
		ticketBackground = 0xC80000;

		// Passwords
		actualPassword = "";
		closeProtected = false;
		settingsProtected = false;

		// Ticket Design
		line1Visible = true;
		line1Text = "Система управления очередью";
		line1FontSize = 10;

		line2Visible = true;
		line2Text = "www.company.com";
		line2FontSize = 10;

        ticketNumberFontSize = 20;
        mainFontSize = 10;

		includeTicketNumber = true;
		includeTicketTime = true;
		ticketBottomText = "Режим работы пн.-пт. 9.00-18.00";
		noPrintToPrinter = false;

		// Communications
		host = "localhost";
		port = "port";
		connectColor = 0xFFFFFF;
	}

	//-------------------------------------------------------

	private function enumerateProperties():Array {
		var propList:Array = [];

		var typeXML:XML = describeType(this);
		var propXMLList:XMLList = typeXML..accessor.@name;

		for(var i:uint = 0; i < propXMLList.length(); i++) {
			var prop:String = propXMLList[i].toString();

			if(prop != "properties")
				propList.push(prop);
		}

		return propList;
	}
}
}
