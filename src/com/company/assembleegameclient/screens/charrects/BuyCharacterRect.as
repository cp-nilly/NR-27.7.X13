package com.company.assembleegameclient.screens.charrects {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.assets.services.IconFactory;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class BuyCharacterRect extends CharacterRect {

    public static const BUY_CHARACTER_RECT_CLASS_NAME_TEXT:String = "BuyCharacterRect.classNameText";

    private var model:PlayerModel;

    public function BuyCharacterRect(_arg1:PlayerModel) {
        this.model = _arg1;
        super.color = 0x1F1F1F;
        super.overColor = 0x424242;
        className = new LineBuilder().setParams(BUY_CHARACTER_RECT_CLASS_NAME_TEXT, {"nth": (_arg1.getMaxCharacters() + 1)});
        super.init();
        this.makeIcon();
        //this.makeTagline();
        this.makePriceText();
        this.makeCurrency();
    }

    private function makeCurrency():void {
        var dat:BitmapData = this.model.getCharSlotCurrency() == 0 ?
                IconFactory.makeCoin() :
                IconFactory.makeFame();
        var cur:Bitmap = new Bitmap(dat);
        cur.x = WIDTH - 43;
        cur.y = (HEIGHT - cur.height) * 0.5 - 1;
        selectContainer.addChild(cur);
    }

    private function makePriceText():void {
        var _local1:TextFieldDisplayConcrete;
        _local1 = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setAutoSize(TextFieldAutoSize.RIGHT);
        _local1.setStringBuilder(new StaticStringBuilder(this.model.getCharSlotPrice().toString()));
        _local1.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        _local1.x = (WIDTH - 43);
        _local1.y = 19;
        selectContainer.addChild(_local1);
    }

    private function makeTagline():void {
        var _local1:int = (100 - (this.model.getCharSlotPrice() / 10));
        var _local2:String = String(_local1);
        if (_local1 != 0) {
            makeTaglineText(new LineBuilder().setParams(TextKey.BUY_CHARACTER_RECT_TAGLINE_TEXT, {"percentage": _local2}));
        }
    }

    private function makeIcon():void {
        var _local1:Shape;
        _local1 = this.buildIcon();
        _local1.x = (CharacterRectConstants.ICON_POS_X + 5);
        _local1.y = ((HEIGHT - _local1.height) * 0.5);
        addChild(_local1);
    }

    private function buildIcon():Shape {
        var _local1:Shape = new Shape();
        _local1.graphics.beginFill(3880246);
        _local1.graphics.lineStyle(1, 4603457);
        _local1.graphics.drawCircle(19, 19, 19);
        _local1.graphics.lineStyle();
        _local1.graphics.endFill();
        _local1.graphics.beginFill(0x1F1F1F);
        _local1.graphics.drawRect(11, 17, 16, 4);
        _local1.graphics.endFill();
        _local1.graphics.beginFill(0x1F1F1F);
        _local1.graphics.drawRect(17, 11, 4, 16);
        _local1.graphics.endFill();
        return (_local1);
    }


}
}
