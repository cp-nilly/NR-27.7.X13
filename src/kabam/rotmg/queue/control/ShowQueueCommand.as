package kabam.rotmg.queue.control {
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.queue.view.QueueView;

public class ShowQueueCommand {
    
    [Inject]
    public var layers:Layers;
    [Inject]
    public var view:QueueView;
    
    
    public function execute():void {
        this.layers.top.addChild(this.view);
    }
    
    
}
}