package kabam.rotmg.fortune.components {
import flash.events.TimerEvent;
import flash.utils.Timer;

public class TimerCallback {

    private var f:Function;
    private var data1;
    private var data2;
    private var data3;
    private var data4;
    private var data5;
    private var data6;
    private var data7;
    private var data8;
    private var tbo:Timer;

    public function TimerCallback(_arg1:Number, _arg2:Function, _arg3:* = null, _arg4:* = null, _arg5:* = null, _arg6:* = null, _arg7:* = null, _arg8:* = null, _arg9:* = null, _arg10:* = null) {
        this.f = _arg2;
        if (_arg3 != null) {
            this.data1 = _arg3;
        }
        if (_arg4 != null) {
            this.data2 = _arg4;
        }
        if (_arg5 != null) {
            this.data3 = _arg5;
        }
        if (_arg6 != null) {
            this.data4 = _arg6;
        }
        if (_arg7 != null) {
            this.data5 = _arg7;
        }
        if (_arg8 != null) {
            this.data6 = _arg8;
        }
        if (_arg9 != null) {
            this.data7 = _arg9;
        }
        if (_arg10 != null) {
            this.data8 = _arg10;
        }
        this.tbo = new Timer((_arg1 * 1000), 1);
        this.tbo.addEventListener(TimerEvent.TIMER_COMPLETE, this.callbackWrapper);
        this.tbo.start();
    }

    public function callbackWrapper(_arg1:TimerEvent):void {
        this.tbo.removeEventListener(TimerEvent.TIMER_COMPLETE, this.callbackWrapper);
        if (this.data8 != null) {
            this.f(this.data1, this.data2, this.data3, this.data4, this.data5, this.data6, this.data7, this.data8);
        }
        else {
            if (this.data7 != null) {
                this.f(this.data1, this.data2, this.data3, this.data4, this.data5, this.data6, this.data7);
            }
            else {
                if (this.data6 != null) {
                    this.f(this.data1, this.data2, this.data3, this.data4, this.data5, this.data6);
                }
                else {
                    if (this.data5 != null) {
                        this.f(this.data1, this.data2, this.data3, this.data4, this.data5);
                    }
                    else {
                        if (this.data4 != null) {
                            this.f(this.data1, this.data2, this.data3, this.data4);
                        }
                        else {
                            if (this.data3 != null) {
                                this.f(this.data1, this.data2, this.data3);
                            }
                            else {
                                if (this.data2 != null) {
                                    this.f(this.data1, this.data2);
                                }
                                else {
                                    if (this.data1 != null) {
                                        this.f(this.data1);
                                    }
                                    else {
                                        this.f();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }


}
}
