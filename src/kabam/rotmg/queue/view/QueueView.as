package kabam.rotmg.queue.view {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class QueueView extends Sprite {
    
    private const textPrefix:String = "Queue Position: ";
    private static const msgFormat:TextFormat = defaultTextFormat();
    
    protected var msg_:TextField;
    
    
    private static function defaultTextFormat():TextFormat {
        var tFormat:TextFormat = new TextFormat();
        tFormat.color = 0xFFA800;
        tFormat.size = 14;
        tFormat.bold = true;
        tFormat.font = "Myriad Pro";
        return tFormat;
    }
    
    public function QueueView() {
        super();
        mouseEnabled = false;
        doubleClickEnabled = false;
        mouseChildren = false;
        
        msg_ = new TextField();
        msg_.defaultTextFormat = msgFormat;
        msg_.autoSize = TextFieldAutoSize.LEFT;
    }
    
    public function update(pos:int, cnt:int):void {
        msg_.text = getPositionText(pos, cnt);
    }
    
    private function getPositionText(pos:int, cnt:int):String {
        return textPrefix + pos + "/" + cnt;
    }
    
    public function show():void {
        addChild(msg_);
    }
    
    public function remove():void {
        parent && parent.removeChild(this);
    }
    
    
}
}