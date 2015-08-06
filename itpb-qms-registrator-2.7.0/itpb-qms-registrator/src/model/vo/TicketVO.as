/**
 * Created by designer4 on 14.07.14.
 */
package model.vo {

public class TicketVO {

	public var errorMessage:String;
	public var success:Boolean;
	public var ticketOrderNo:uint;

	public function TicketVO(errorMessage:String, success:Boolean, ticketOrderNo:uint) {
		this.errorMessage = errorMessage;
		this.success = success;
		this.ticketOrderNo = ticketOrderNo;
	}
}
}
