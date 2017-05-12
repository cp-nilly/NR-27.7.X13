package kabam.rotmg.characters.reskin.control {
import kabam.lib.console.signals.RegisterConsoleActionSignal;
import kabam.lib.console.vo.ConsoleAction;

public class AddReskinConsoleActionCommand {

    [Inject]
    public var register:RegisterConsoleActionSignal;
    [Inject]
    public var openReskinDialogSignal:OpenReskinDialogSignal;


    public function execute():void {
        var _local1:ConsoleAction;
        _local1 = new ConsoleAction();
        _local1.name = "reskin";
        _local1.description = "opens the reskin UI";
        this.register.dispatch(_local1, this.openReskinDialogSignal);
    }


}
}
