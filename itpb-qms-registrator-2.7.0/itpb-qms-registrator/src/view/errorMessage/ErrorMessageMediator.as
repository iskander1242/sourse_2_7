/**
 * Created by designer4 on 14.07.14.
 */
package view.errorMessage {

    import model.AppModel;

    import mx.binding.utils.BindingUtils;

    import mx.binding.utils.ChangeWatcher;

    import robotlegs.bender.bundles.mvcs.Mediator;

    public class ErrorMessageMediator extends Mediator {

    [Inject]
    public var _view: ErrorMessageComponent;

    [Inject]
    public var appModel: AppModel;

    private var showErrorMessageWatcher: ChangeWatcher;
    private var errorMessageWatcher: ChangeWatcher;

	public function ErrorMessageMediator() {



	}

        override public function initialize():void
        {
            errorMessageWatcher = BindingUtils.bindProperty(_view, "errorMessage", appModel, "errorMessage");
            showErrorMessageWatcher = BindingUtils.bindProperty(_view, "showErrorMessage", appModel, "showErrorMessage");
        }

        override public function destroy():void
        {
            errorMessageWatcher.unwatch();
            showErrorMessageWatcher.unwatch();
        }
}
}
