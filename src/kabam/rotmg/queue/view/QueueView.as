package kabam.rotmg.queue.view {
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class QueueView extends Sprite {
    
    private const textPrefix:String = "Queue Position: ";
    private const infoText:String = 
        "Server is full. You have been queued.\n" +
        "Using your nexus hotkey will put you back in the queue.\n" +
        "If you want to avoid it use /nexus instead.\n" +
        "Please be patient and leave the client open.";
    
    private static const msgFormat:TextFormat = defaultTextFormat();
    
    protected var queuePosition_:TextField;
    protected var queueMessage_:TextField;
    
    
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
        
        queuePosition_ = new TextField();
        queuePosition_.defaultTextFormat = msgFormat;
        queuePosition_.autoSize = TextFieldAutoSize.LEFT;
        
        queueMessage_ = new TextField();
        queueMessage_.defaultTextFormat = msgFormat;
        queueMessage_.autoSize = TextFieldAutoSize.LEFT;
        queueMessage_.y = 30;
        queueMessage_.text = infoText;
    }
    
    public function update(pos:int, cnt:int):void {
        queuePosition_.text = getPositionText(pos, cnt);
    }
    
    private function getPositionText(pos:int, cnt:int):String {
        return textPrefix + pos + "/" + cnt;
    }
    
    public function show():void {
        addChild(queuePosition_);
        addChild(queueMessage_);
    }
    
    public function remove():void {
        parent && parent.removeChild(this);
    }
    
    
}
}