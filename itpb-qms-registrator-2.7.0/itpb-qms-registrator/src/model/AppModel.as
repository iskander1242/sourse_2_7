/**
 * @author  Alexander Bulko
 * @email   alex@esynctraining.com
 * @company eSyncTraining
 **/
package model
{
    public class AppModel
    {
        [Bindable]
        public var isTicketButtonActive: Boolean = true;

        [Bindable]
        public var showErrorMessage: Boolean;

        [Bindable]
        public var errorMessage: String;

        public var noPrintToPrinter: Boolean;


        public function AppModel()
        {
        }
    }
}
