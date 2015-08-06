/**
 * @author  Alexander Bulko
 * @email   alex@esynctraining.com
 * @company eSyncTraining
 **/
package controller
{
    import controller.requests.CheckServerConnectionRequest;
    import controller.signals.ResetCheckServerConnectionTimerSignal;

    import robotlegs.bender.bundles.mvcs.Mediator;

    public class ServerConnectionMediator extends Mediator
    {
        [Inject]
        public var _view: ServerConnectionController;

        [Inject]
        public var checkServerConnectionRequest:CheckServerConnectionRequest;

        [Inject]
        public var resetCheckServerConnectionTimerSignal: ResetCheckServerConnectionTimerSignal;

        public function ServerConnectionMediator()
        {
            super();
        }

        override public function initialize(): void
        {
            _view.onCheckConnectionSignal.add( checkConnection );

            resetCheckServerConnectionTimerSignal.add( _view.setTimer );
        }

        override public function destroy(): void
        {
            super.destroy();

            _view.onCheckConnectionSignal.remove( checkConnection );

            resetCheckServerConnectionTimerSignal.remove( _view.setTimer );
        }

        private function checkConnection(): void
        {
            checkServerConnectionRequest.dispatch();
        }
    }
}
