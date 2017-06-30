package kabam.rotmg.editor.view.components {
import com.company.assembleegameclient.editor.CommandEvent;
import com.company.assembleegameclient.editor.CommandMenu;
import com.company.assembleegameclient.editor.CommandMenuItem;
import com.company.util.KeyCodes;

public class TMCommandMenu extends CommandMenu {

    public static const NONE_COMMAND:int = 0;
    public static const DRAW_COMMAND:int = 1;
    public static const ERASE_COMMAND:int = 2;
    public static const SAMPLE_COMMAND:int = 3;

    public function TMCommandMenu() {
        addCommandMenuItem("(D)raw", KeyCodes.D, this.onDraw, DRAW_COMMAND);
        addCommandMenuItem("(E)rase", KeyCodes.E, this.onErase, ERASE_COMMAND);
        addCommandMenuItem("S(A)mple", KeyCodes.A, this.onSample, SAMPLE_COMMAND);
        addCommandMenuItem("(U)ndo", KeyCodes.U, this.onUndo, NONE_COMMAND);
        addCommandMenuItem("(R)edo", KeyCodes.R, this.onRedo, NONE_COMMAND);
        addCommandMenuItem("(C)lear", KeyCodes.C, this.onClear, NONE_COMMAND);
        addBreak();
        addBreak();//addCommandMenuItem("(L)oad", KeyCodes.L, this.onLoad, NONE_COMMAND);
        addBreak();//addCommandMenuItem("(S)ave", KeyCodes.S, this.onSave, NONE_COMMAND);
        addCommandMenuItem("E(X)port", KeyCodes.X, this.onExport, NONE_COMMAND);
        addBreak();
        addCommandMenuItem("(Q)uit", KeyCodes.Q, this.onQuit, NONE_COMMAND);
    }

    private function onDraw(_arg_1:CommandMenuItem):void {
        setSelected(_arg_1);
    }

    private function onErase(_arg_1:CommandMenuItem):void {
        setSelected(_arg_1);
    }

    private function onSample(_arg_1:CommandMenuItem):void {
        setSelected(_arg_1);
    }

    private function onUndo(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.UNDO_COMMAND_EVENT));
    }

    private function onRedo(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.REDO_COMMAND_EVENT));
    }

    private function onClear(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.CLEAR_COMMAND_EVENT));
    }

    private function onLoad(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.LOAD_COMMAND_EVENT));
    }

    private function onSave(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.SAVE_COMMAND_EVENT));
    }

    private function onExport(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.EXPORT_COMMAND_EVENT));
    }

    private function onQuit(_arg_1:CommandMenuItem):void {
        dispatchEvent(new CommandEvent(CommandEvent.QUIT_COMMAND_EVENT));
    }


}
}
