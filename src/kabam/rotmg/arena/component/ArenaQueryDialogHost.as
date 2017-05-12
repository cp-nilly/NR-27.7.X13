package kabam.rotmg.arena.component {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import kabam.rotmg.arena.view.HostQueryDialog;

public class ArenaQueryDialogHost extends Sprite {

    private const speechBubble:HostQuerySpeechBubble = makeSpeechBubble();
    private const detailBubble:HostQueryDetailBubble = makeDetailBubble();
    private const icon:Bitmap = makeHostIcon();


    private function makeSpeechBubble():HostQuerySpeechBubble {
        var _local1:HostQuerySpeechBubble;
        _local1 = new HostQuerySpeechBubble(HostQueryDialog.QUERY);
        _local1.x = 60;
        addChild(_local1);
        return (_local1);
    }

    private function makeDetailBubble():HostQueryDetailBubble {
        var _local1:HostQueryDetailBubble;
        _local1 = new HostQueryDetailBubble();
        _local1.y = 60;
        return (_local1);
    }

    private function makeHostIcon():Bitmap {
        var _local1:Bitmap = new Bitmap(this.makeDebugBitmapData());
        _local1.x = 0;
        _local1.y = 0;
        addChild(_local1);
        return (_local1);
    }

    private function makeDebugBitmapData():BitmapData {
        return (new BitmapData(42, 42, true, 0xFF00FF00));
    }

    public function showDetail(_arg1:String):void {
        this.detailBubble.setText(_arg1);
        removeChild(this.speechBubble);
        addChild(this.detailBubble);
    }

    public function showSpeech():void {
        removeChild(this.detailBubble);
        addChild(this.speechBubble);
    }

    public function setHostIcon(_arg1:BitmapData):void {
        this.icon.bitmapData = _arg1;
    }


}
}
