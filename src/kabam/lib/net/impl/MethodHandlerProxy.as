package kabam.lib.net.impl {
import kabam.lib.net.api.MessageHandlerProxy;

public class MethodHandlerProxy implements MessageHandlerProxy {

    private var method:Function;


    public function setMethod(_arg1:Function):MethodHandlerProxy {
        this.method = _arg1;
        return (this);
    }

    public function getMethod():Function {
        return (this.method);
    }


}
}
