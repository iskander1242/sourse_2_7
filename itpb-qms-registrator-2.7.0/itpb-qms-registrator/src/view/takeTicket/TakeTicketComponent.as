package view.takeTicket {

import flash.events.Event;
import flash.events.MouseEvent;
    import flash.utils.setTimeout;

    import org.osflash.signals.Signal;

import spark.components.supportClasses.SkinnableComponent;

public class TakeTicketComponent extends SkinnableComponent {

	[Bindable]
	public var takeTicketText:String;

    [Bindable]
    public var ticketTextFontSize:uint;

	[Bindable]
	public var ticketFont:String;

	[Bindable]
	public var ticketFontColor:uint;

	[Bindable]
	public var ticketBackground:uint;

    [Bindable]
    public var shadowVisible: Boolean;

	/** * Means instance is not responsive to clicks and size changes. */
	public var previewMode:Boolean;

	//---------------------------------------------------------------------------

	public var onTicketClickedSignal:Signal = new Signal();
    public var onButtonEnabledSignal:Signal = new Signal();

	//---------------------------------------------------------------------------

	private var _ticketWidth:uint;
	private var _ticketHeight:uint;

    private var _isTicketButtonActive:Boolean = true;

	//===========================================================================

	public function TakeTicketComponent() {

	}

	//---------------------------------------------------------------------------

	/*public function ticketClickHandler(e:MouseEvent):void{
		//if(!previewMode)
		onTicketClickedSignal.dispatch();
	}*/

    private function mouseDownHandler( event: MouseEvent ): void
    {
        shadowVisible = false;
        //this.scaleX = this.scaleY = 0.99;
    }

    private function mouseUpHandler( event: MouseEvent ): void
    {
        shadowVisible = true;
        removeButtonListeners();
        setTimeout( addButtonListeners, 1500 );
        onTicketClickedSignal.dispatch();
        //this.scaleX = this.scaleY = 1;

    }

    private function addButtonListeners(): void
    {
        if( isTicketButtonActive )
        {
            //this.addEventListener( MouseEvent.CLICK, ticketClickHandler );
            this.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
            this.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
            shadowVisible = true;
        }

        onButtonEnabledSignal.dispatch();
    }

    private function removeButtonListeners(): void
    {
        //this.removeEventListener(MouseEvent.CLICK, ticketClickHandler);
        this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        shadowVisible = false;
    }


    [Bindable(event="isTicketButtonActiveChanged")]
    public function get isTicketButtonActive():Boolean {
        return _isTicketButtonActive;
    }

    public function set isTicketButtonActive(value:Boolean):void
    {
        _isTicketButtonActive = value;

        if( value )
            addButtonListeners();
        else
            removeButtonListeners();

        dispatchEvent( new Event("isTicketButtonActiveChanged") );
    }

	//---------------------------------------------------------------------------

	[Bindable(event="ticketWidthChanged")]
	public function get ticketWidth():uint {
		return _ticketWidth;
	}

	public function set ticketWidth(value:uint):void {
        if( _ticketWidth == value ) return;
		_ticketWidth = value;

//		this.width = ticketWidth;
		this.width = previewMode ? 400: ticketWidth;

		dispatchEvent( new Event("ticketWidthChanged") );
	}

	//---------------------------------------------------------------------------

	[Bindable(event="ticketHeightChanged")]
	public function get ticketHeight():uint {
		return _ticketHeight;
	}

	public function set ticketHeight(value:uint):void {
		if(_ticketHeight == value) return;
		_ticketHeight = value;

//		this.height = ticketHeight;
		this.height = previewMode ? 120 : ticketHeight;

		dispatchEvent(new Event("ticketHeightChanged"));
	}
}
}
