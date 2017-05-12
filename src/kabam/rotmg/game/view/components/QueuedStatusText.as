package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.map.mapoverlay.CharacterStatusText;
import com.company.assembleegameclient.objects.GameObject;

import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class QueuedStatusText extends CharacterStatusText {

    public var list:QueuedStatusTextList;
    public var next:QueuedStatusText;
    public var stringBuilder:StringBuilder;

    public function QueuedStatusText(_arg1:GameObject, _arg2:StringBuilder, _arg3:uint, _arg4:int, _arg5:int = 0) {
        this.stringBuilder = _arg2;
        super(_arg1, _arg3, _arg4, _arg5);
        setStringBuilder(_arg2);
    }

    override public function dispose():void {
        this.list.shift();
    }


}
}
