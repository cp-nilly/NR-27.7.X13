package kabam.lib.console.controller {
import kabam.lib.console.model.Console;
import kabam.lib.console.signals.ConsoleLogSignal;

public final class ListActionsCommand {

    [Inject]
    public var console:Console;
    [Inject]
    public var log:ConsoleLogSignal;


    public function execute():void {
        var _local1:String = ("  " + this.console.getNames().join("\r  "));
        this.log.dispatch(_local1);
    }


}
}
