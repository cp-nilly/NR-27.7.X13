package kabam.lib.console.view {
import com.junkbyte.console.Console;
import com.junkbyte.console.ConsoleConfig;

import flash.display.BlendMode;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import kabam.lib.console.model.Watch;
import kabam.lib.resizing.view.Resizable;

public final class ConsoleOutputView extends Sprite implements Resizable {

    private static const DEFAULT_OUTPUT:String = "kabam.lib/console";

    private const PATTERN:RegExp = /\[0x(.+)\:(.+)\]/ig;
    private const HTML_TEMPLATE:String = "<font color='#$1'>$2</font>";
    private const logged:Array = [];
    private const watched:Array = [];
    private const watchMap:Object = {};

    private var watchTextField:TextField;
    private var logConsole:Console;
    private var watchBottom:Number;

    public function ConsoleOutputView() {
        this.watchTextField = new TextField();
        super();
        alpha = 0.8;
        blendMode = BlendMode.LAYER;
        addChild(this.watchTextField);
        this.watchTextField.alpha = 0.6;
        this.watchTextField.defaultTextFormat = new TextFormat("_sans", 14, 0xFFFFFF, true);
        this.watchTextField.htmlText = DEFAULT_OUTPUT;
        this.watchTextField.selectable = false;
        this.watchTextField.multiline = true;
        this.watchTextField.wordWrap = true;
        this.watchTextField.autoSize = TextFieldAutoSize.LEFT;
        this.watchTextField.background = true;
        this.watchTextField.border = false;
        this.watchTextField.backgroundColor = 0x3300;
        this.logConsole = new Console("", new ConsoleConfig());
        addChild(this.logConsole);
    }

    public function watch(_arg1:Watch):void {
        var _local2:Watch = (this.watchMap[_arg1.name] = ((this.watchMap[_arg1.name]) || (this.makeWatch(_arg1.name))));
        _local2.data = _arg1.data.replace(this.PATTERN, this.HTML_TEMPLATE);
        this.updateOutputText();
    }

    public function unwatch(_arg1:String):void {
        var _local2:Watch = this.watchMap[_arg1];
        if (_local2) {
            delete this.watchMap[_arg1];
            this.watched.splice(this.watched.indexOf(_local2), 1);
        }
    }

    private function makeWatch(_arg1:String):Watch {
        var _local2:Watch = new Watch(_arg1);
        this.watched.push(_local2);
        return (_local2);
    }

    public function log(_arg1:String):void {
        var _local2:String = _arg1.replace(this.PATTERN, this.HTML_TEMPLATE);
        this.logged.push(_local2);
        this.logConsole.addHTML(_local2);
    }

    public function clear():void {
        var _local1:String;
        this.logged.length = 0;
        this.watched.length = 0;
        for (_local1 in this.watchMap) {
            delete this.watchMap[_local1];
        }
    }

    public function resize(_arg1:Rectangle):void {
        this.watchBottom = (_arg1.height - ConsoleInputView.HEIGHT);
        x = _arg1.x;
        y = _arg1.y;
        this.watchTextField.width = _arg1.width;
        this.logConsole.width = _arg1.width;
        this.snapWatchTextToInputView();
    }

    private function snapWatchTextToInputView():void {
        this.watchTextField.y = (this.watchBottom - this.watchTextField.height);
    }

    private function updateOutputText():void {
        this.watchTextField.htmlText = this.watched.join("\n");
        this.snapWatchTextToInputView();
    }

    public function getText():String {
        return (this.logged.join("\r"));
    }


}
}
