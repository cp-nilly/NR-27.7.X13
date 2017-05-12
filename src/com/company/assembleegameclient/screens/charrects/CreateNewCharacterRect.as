package com.company.assembleegameclient.screens.charrects {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.FameUtil;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class CreateNewCharacterRect extends CharacterRect {

    private var bitmap_:Bitmap;

    public function CreateNewCharacterRect(_arg1:PlayerModel) {
        var _local2:int;
        super();
        super.className = new LineBuilder().setParams(TextKey.CREATE_NEW_CHARACTER_RECT_NEW_CHARACTER);
        super.color = 0x545454;
        super.overColor = 0x777777;
        super.init();
        this.makeBitmap();
        if (_arg1.getNumStars() != FameUtil.maxStars()) {
            _local2 = (FameUtil.maxStars() - _arg1.getNumStars());
            super.makeTaglineIcon();
            super.makeTaglineText(new LineBuilder().setParams(TextKey.CREATE_NEW_CHARACTER_RECT_TAGLINE, {"remainingStars": _local2}));
            taglineText.x = (taglineText.x + taglineIcon.width);
        }
    }

    public function makeBitmap():void {
        var _local1:XML = ObjectLibrary.playerChars_[int((ObjectLibrary.playerChars_.length * Math.random()))];
        var _local2:BitmapData = SavedCharacter.getImage(null, _local1, AnimatedChar.RIGHT, AnimatedChar.STAND, 0, false, false);
        _local2 = BitmapUtil.cropToBitmapData(_local2, 6, 6, (_local2.width - 12), (_local2.height - 6));
        this.bitmap_ = new Bitmap();
        this.bitmap_.bitmapData = _local2;
        this.bitmap_.x = CharacterRectConstants.ICON_POS_X;
        this.bitmap_.y = CharacterRectConstants.ICON_POS_Y;
        selectContainer.addChild(this.bitmap_);
    }


}
}
