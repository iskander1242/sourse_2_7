package {
import model.AppConfig;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.impl.Context;

import spark.components.Application;

public class RegistratorApp extends Application {

	public function RegistratorApp() {
		super();
		setupContext();
	}

	protected var context:IContext;

	private function setupContext():void {
		context = new Context()
				.install(MVCSBundle, SignalCommandMapExtension)
				.configure(AppConfig)
				.configure(new ContextView(this));

		//context.logLevel = LogLevel.DEBUG;
	}
}
}
