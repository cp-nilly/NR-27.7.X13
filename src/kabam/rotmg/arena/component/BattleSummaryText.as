package kabam.rotmg.arena.component {
import flash.display.Sprite;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class BattleSummaryText extends Sprite {

    private var titleText:StaticTextDisplay;
    private var waveText:StaticTextDisplay;
    private var timeText:StaticTextDisplay;

    public function BattleSummaryText(_arg1:String, _arg2:int, _arg3:int) {
        this.titleText = this.makeTitleText();
        this.waveText = this.makeSubtitleText();
        this.timeText = this.makeSubtitleText();
        super();
        this.titleText.setStringBuilder(new LineBuilder().setParams(_arg1));
        this.waveText.setStringBuilder(new LineBuilder().setParams(TextKey.BATTLE_SUMMARY_WAVENUMBER, {"waveNumber": (_arg2 - 1)}));
        this.timeText.setStringBuilder(new StaticStringBuilder(this.createTimerString(_arg3)));
        this.align();
    }

    private function align():void {
        this.titleText.x = ((width / 2) - (this.titleText.width / 2));
        this.waveText.y = (this.titleText.height + 10);
        this.waveText.x = ((width / 2) - (this.waveText.width / 2));
        this.timeText.y = ((this.waveText.y + this.waveText.height) + 5);
        this.timeText.x = ((width / 2) - (this.timeText.width / 2));
    }

    private function createTimerString(_arg1:int):String {
        var _local2:int = (_arg1 / 60);
        var _local3:int = (_arg1 % 60);
        var _local4:String = (((_local2 < 10)) ? "0" : "");
        _local4 = (_local4 + (_local2 + ":"));
        _local4 = (_local4 + (((_local3 < 10)) ? "0" : ""));
        _local4 = (_local4 + _local3);
        return (_local4);
    }

    private function makeTitleText():StaticTextDisplay {
        var _local1:StaticTextDisplay;
        _local1 = new StaticTextDisplay();
        _local1.setSize(16).setBold(true).setColor(0xFFFFFF);
        _local1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        addChild(_local1);
        return (_local1);
    }

    private function makeSubtitleText():StaticTextDisplay {
        var _local1:StaticTextDisplay = new StaticTextDisplay();
        _local1.setSize(14).setBold(true).setColor(0xB3B3B3);
        _local1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        addChild(_local1);
        return (_local1);
    }


}
}
