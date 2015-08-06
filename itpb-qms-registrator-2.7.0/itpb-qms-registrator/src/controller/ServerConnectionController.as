/**
 * @author  Alexander Bulko
 * @email   alex@esynctraining.com
 * @company eSyncTraining
 **/
package controller
{
    import flash.events.Event;
    import flash.utils.clearInterval;
    import flash.utils.setInterval;

    import org.osflash.signals.Signal;

    import spark.core.SpriteVisualElement;

    public class ServerConnectionController extends SpriteVisualElement
    {
        public var onCheckConnectionSignal: Signal = new Signal();

        private var timer: uint;

        public function ServerConnectionController()
        {
            super();
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        public function setTimer(): void
        {
            /*var date: Date = new Date();
            trace( 'setTimer : ' + date.getSeconds() );*/
            timer = setInterval( checkConnection, 2000 );
        }

        private function onAddedToStage( event: Event ): void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            setTimer();
        }

        private function checkConnection(): void
        {
            clearInterval( timer );
            timer = null;
            onCheckConnectionSignal.dispatch();
        }
    }
}
