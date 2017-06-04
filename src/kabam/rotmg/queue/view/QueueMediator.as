package kabam.rotmg.queue.view {
import kabam.rotmg.maploading.signals.HideMapLoadingSignal;
import kabam.rotmg.queue.control.UpdateQueueSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class QueueMediator extends Mediator {
    
    [Inject]
    public var view:QueueView;
    [Inject]
    public var hide:HideMapLoadingSignal;
    [Inject]
    public var update:UpdateQueueSignal;
    
    
    override public function initialize():void {
        this.view.show();
        this.hide.add(this.onHide);
        this.update.add(this.onUpdate);
    }
    
    override public function destroy():void {
        this.hide.remove(this.onHide);
        this.update.remove(this.onUpdate);
    }
    
    private function onHide():void {
        this.view.remove();
    }
    
    private function onUpdate(pos:int, cnt:int) {
        this.view.update(pos, cnt);
    }


}
}