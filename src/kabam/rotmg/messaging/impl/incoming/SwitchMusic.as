/**
 * Created by cp-nilly on 6/9/2017.
 */
package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class SwitchMusic extends IncomingMessage {
    public var music:String;

    public function SwitchMusic(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.music = _arg1.readUTF();
    }

    override public function toString():String {
        return (formatToString("SWITCHMUSIC", "music_"));
    }


}
}