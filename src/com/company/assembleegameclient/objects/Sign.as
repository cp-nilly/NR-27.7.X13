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

    public function Sign(xml:XML) {
        super(xml);
        texture_ = null;
        this.stringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
        this.fontModel = StaticInjectorContext.getInjector().getInstance(FontModel);
    }

    override protected function getTexture(camera:Camera, currentMS:int):BitmapData {
        if (texture_ != null) {
            return texture_;
        }
        var txtField:TextField = new TextField();
        txtField.multiline = true;
        txtField.wordWrap = false;
        txtField.autoSize = TextFieldAutoSize.LEFT;
        txtField.textColor = 0xFFFFFF;
        txtField.embedFonts = true;
        var txtFormat:TextFormat = new TextFormat();
        txtFormat.align = TextFormatAlign.CENTER;
        txtFormat.font = this.fontModel.getFont().getName();
        txtFormat.size = 24;
        txtFormat.color = 0xFFFFFF;
        txtFormat.bold = true;
        txtField.defaultTextFormat = txtFormat;

        var signTxt:String = this.stringMap.getValue(this.stripCurlyBrackets(name_));
        if (signTxt == null) {
            signTxt = name_;
        }
        txtField.text = signTxt.split("|").join("\n");
        var bmpData:BitmapData = new BitmapDataSpy(txtField.width, txtField.height, true, 0);
        bmpData.draw(txtField);
        texture_ = TextureRedrawer.redraw(bmpData, size_, false, 0);
        return texture_;
    }

    private function stripCurlyBrackets(txt:String):String {
        var hasCurly:Boolean = txt != null && txt.charAt(0) == "{" && txt.charAt(txt.length - 1) == "}";
        return hasCurly ? txt.substr(1, txt.length - 2) : txt;
    }


}
}
