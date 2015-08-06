/**
 * @author  Alexander Bulko
 * @email   alex@esynctraining.com
 * @company eSyncTraining
 **/
package controller.signals
{
    import org.osflash.signals.Signal;

    public class ShowPrintTicketSignal extends Signal
    {
        public function ShowPrintTicketSignal()
        {
            super( Boolean );
        }
    }
}
