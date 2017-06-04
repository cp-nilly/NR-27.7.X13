package kabam.rotmg.queue {
import kabam.rotmg.queue.control.ShowQueueCommand;
import kabam.rotmg.queue.control.ShowQueueSignal;
import kabam.rotmg.queue.control.UpdateQueueSignal;
import kabam.rotmg.queue.view.QueueMediator;
import kabam.rotmg.queue.view.QueueView;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class QueueConfig implements IConfig {
    
    [Inject]
    public var injector:Injector;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var mediatorMap:IMediatorMap;
    
    
    public function configure():void {
        this.injector.map(UpdateQueueSignal).asSingleton();
        this.commandMap.map(ShowQueueSignal).toCommand(ShowQueueCommand);
        this.mediatorMap.map(QueueView).toMediator(QueueMediator);
    }
    
    
}
}
