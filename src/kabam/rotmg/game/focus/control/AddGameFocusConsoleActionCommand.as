package kabam.rotmg.game.focus.control {
import kabam.lib.console.signals.RegisterConsoleActionSignal;
import kabam.lib.console.vo.ConsoleAction;

public class AddGameFocusConsoleActionCommand {

    [Inject]
    public var register:RegisterConsoleActionSignal;
    [Inject]
    public var setFocus:SetGameFocusSignal;


    public function execute():void {
        var _local1:ConsoleAction;
        _local1 = new ConsoleAction();
        _local1.name = "follow";
        _local1.description = "follow a game object (by name)";
        this.register.dispatch(_local1, this.setFocus);
    }


}
}
