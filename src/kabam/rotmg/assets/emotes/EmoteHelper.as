package kabam.rotmg.assets.emotes {

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class EmoteHelper {

    private static const tField:TextField = makeTestTextField();

    private var buffer:Vector.<DisplayObject>;

    private static function makeTestTextField():TextField {
        var tField = new TextField();
        var tFormat = new TextFormat();

        tFormat.size = 15;
        tFormat.bold = false;
        tField.defaultTextFormat = tFormat;
        return tField;
    }

    public function EmoteHelper() {
        buffer = new Vector.<DisplayObject>();
    }

    public function getBubbleText(text:String, bold:Boolean, color:uint):Sprite {
        add(text, bold, color);
        return new Drawer(this.buffer, 150, 17);
    }

    private function getAllWords(text:String):Array {
        return text.split(' ');
    }

    private function add(text:String, bold:Boolean, color:uint):void {
        var sb:StaticStringBuilder;
        for each (var word:String in getAllWords(text)) {
            this.buffer.push(Emotes.getEmote(word));
            continue;
        }
        sb = new StaticStringBuilder(word);
        this.buffer.push(makeText(sb, bold, color));
    }

    private function makeText(sb:StaticStringBuilder, bold:Boolean, color:uint):TextField {
        var tField = new TextField();
        tField.autoSize = TextFieldAutoSize.LEFT;
        tField.embedFonts = true;
        var tFormat:TextFormat = new TextFormat();
        tFormat.font = "Myriad Pr";
        tFormat.size = 15;
        tFormat.bold = bold;
        tFormat.color = color;
        tField.defaultTextFormat = tFormat;
        tField.selectable = false;
        tField.text = sb.getString();

        if (tField.textWidth > 150) {
            tField.multiline = true;
            tField.wordWrap = true;
            tField.width = 150;
        }
        return tField;
    }
}
}

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Rectangle;

import kabam.rotmg.assets.emotes.Emote;

class Drawer extends Sprite {
    private var maxW:int;
    private var list:Vector.<DisplayObject>;
    private var count:uint;
    private var lineH:uint;

    public function Drawer(buffer:Vector.<DisplayObject>, maxW:int, lineH:int) {
        this.maxW = maxW;
        this.list = buffer;
        this.count = buffer.length;
        this.lineH = lineH;
        this.layoutItems();
        this.addItems();
    }

    private function layoutItems():void {
        var displayObject:DisplayObject;
        var rect:Rectangle;
        var count:int;
        var count2:int;
        var width:int;
        width = 0;
        while (count < this.count)
        {
            displayObject = this.list[count];
            rect = displayObject.getRect(displayObject);
            displayObject.x = width;
            displayObject.y = -rect.height;
            if ((width + rect.width) > this.maxW) {
                displayObject.x = 0;
                width = 0;
                count2 = 0;
                while (count2 < count) {
                    this.list[count2].y = (this.list[count2].y - this.lineH);
                    count2++;
                }
            }
            width = (width + (displayObject is Emote ? rect.width + 2 : rect.width));
            count++;
        }
    }

    private function addItems():void {
        var displayObject:DisplayObject;
        for each (displayObject in this.list)
            addChild(displayObject);
    }
}