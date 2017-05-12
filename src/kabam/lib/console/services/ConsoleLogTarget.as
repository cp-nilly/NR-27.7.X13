package kabam.lib.console.services {
import kabam.lib.console.signals.ConsoleLogSignal;

import robotlegs.bender.extensions.logging.impl.LogMessageParser;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.LogLevel;

public class ConsoleLogTarget implements ILogTarget {

    private var consoleLog:ConsoleLogSignal;
    private var messageParser:LogMessageParser;

    public function ConsoleLogTarget(_arg1:IContext) {
        this.consoleLog = _arg1.injector.getInstance(ConsoleLogSignal);
        this.messageParser = new LogMessageParser();
    }

    public function log(_arg1:Object, _arg2:uint, _arg3:int, _arg4:String, _arg5:Array = null):void {
        var _local6:String = ((((LogLevel.NAME[_arg2] + " ") + _arg1) + " ") + this.messageParser.parseMessage(_arg4, _arg5));
        this.consoleLog.dispatch(_local6);
    }


}
}
