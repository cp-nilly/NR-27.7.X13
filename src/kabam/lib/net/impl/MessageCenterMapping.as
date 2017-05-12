package kabam.lib.net.impl {
import kabam.lib.net.api.MessageHandlerProxy;
import kabam.lib.net.api.MessageMapping;

import org.swiftsuspenders.Injector;

public class MessageCenterMapping implements MessageMapping {

    private const nullHandler:NullHandlerProxy = new NullHandlerProxy();

    private var id:int;
    private var injector:Injector;
    private var messageType:Class;
    private var population:int = 1;
    private var handler:MessageHandlerProxy;

    public function MessageCenterMapping() {
        this.handler = this.nullHandler;
        super();
    }

    public function setID(_arg1:int):MessageMapping {
        this.id = _arg1;
        return (this);
    }

    public function setInjector(_arg1:Injector):MessageCenterMapping {
        this.injector = _arg1;
        return (this);
    }

    public function toMessage(_arg1:Class):MessageMapping {
        this.messageType = _arg1;
        return (this);
    }

    public function toHandler(_arg1:Class):MessageMapping {
        this.handler = new ClassHandlerProxy().setType(_arg1).setInjector(this.injector);
        return (this);
    }

    public function toMethod(_arg1:Function):MessageMapping {
        this.handler = new MethodHandlerProxy().setMethod(_arg1);
        return (this);
    }

    public function setPopulation(_arg1:int):MessageMapping {
        this.population = _arg1;
        return (this);
    }

    public function makePool():MessagePool {
        var _local1:MessagePool = new MessagePool(this.id, this.messageType, this.handler.getMethod());
        _local1.populate(this.population);
        return (_local1);
    }


}
}

import kabam.lib.net.api.MessageHandlerProxy;

class NullHandlerProxy implements MessageHandlerProxy {


    public function getMethod():Function {
        return (null);
    }


}

