package kabam.rotmg.dialogs.control {
import org.osflash.signals.Signal;

public class AddPopupToStartupQueueSignal extends Signal {

    public function AddPopupToStartupQueueSignal() {
        super(String, Signal, int, Object);
    }

}
}
