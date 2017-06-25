package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.util.TextureRedrawer;

import flash.display.BitmapData;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.text.model.FontModel;

public class Sign extends GameObject {

    private var stringMap:StringMap;
    private var fontModel:FontModel;

    public function Sign(_arg1:XML) {
        super(_arg1);
        texture_ = null;
        this.stringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
        this.fontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
    }

    override protected function getTexture(_arg1:Camera, _arg2:int):BitmapData {
        if (texture_ != null) {
            return (texture_);
        }
        var _local3:TextField = new TextField();
        _local3.multiline = true;
        _local3.wordWrap = false;
        _local3.autoSize = TextFieldAutoSize.LEFT;
        _local3.textColor = 0xFFFFFF;
        _local3.embedFonts = true;
        var _local4:TextFormat = new TextFormat();
        _local4.align = TextFormatAlign.CENTER;
        _local4.font = this.fontModel.getFont().getName();
        _local4.size = 24;
        _local4.color = 0xFFFFFF;
        _local4.bold = true;
        _local3.defaultTextFormat = _local4;
        var _local5:String = this.stringMap.getValue(this.stripCurlyBrackets(name_));
        if (_local5 == null) {
            _local5 = "null";
        }
        _local3.text = _local5.split("|").join("\n");
        var _local6:BitmapData = new BitmapDataSpy(_local3.width, _local3.height, true, 0);
        _local6.draw(_local3);
        texture_ = TextureRedrawer.redraw(_local6, size_, false, 0, true, 5 * Camera.vToS_scale / 50);
        return (texture_);
    }

    private function stripCurlyBrackets(_arg1:String):String {
        var _local2:Boolean = ((((!((_arg1 == null))) && ((_arg1.charAt(0) == "{")))) && ((_arg1.charAt((_arg1.length - 1)) == "}")));
        return (((_local2) ? _arg1.substr(1, (_arg1.length - 2)) : _arg1));
    }


}
}
