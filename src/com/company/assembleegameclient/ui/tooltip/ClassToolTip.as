package com.company.assembleegameclient.ui.tooltip {
import com.company.assembleegameclient.appengine.CharacterStats;
import com.company.assembleegameclient.appengine.SavedCharactersList;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.LineBreakDesign;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.FameUtil;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.CachingColorTransformer;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

import kabam.rotmg.assets.services.IconFactory;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class ClassToolTip extends ToolTip {

    private static const unlockReqCT = new ColorTransform(0, 0, 0, 0.5, 0, 0, 0, 0);

    private var portrait_:Bitmap;
    private var nameText_:TextFieldDisplayConcrete;
    private var descriptionText_:TextFieldDisplayConcrete;
    private var lineBreak_:LineBreakDesign;
    private var bestLevel_:TextFieldDisplayConcrete;
    private var toUnlockText_:TextFieldDisplayConcrete;
    private var unlockText_:TextFieldDisplayConcrete;
    private var nextClassQuest_:TextFieldDisplayConcrete;
    private var costText_:TextFieldDisplayConcrete;
    private var coinBitmap_:Bitmap;
    private var showUnlockRequirements:Boolean;

    public function ClassToolTip(_arg1:XML, _arg2:PlayerModel, _arg3:CharacterStats) {
        var _local8:AppendingLineBuilder;
        var _local9:XML;
        var _local10:BitmapData;
        var _local11:int;
        var _local12:int;
        var _local13:int;
        var _local14:int;
        super(0x363636, 1, 0xFFFFFF, 1);
        var _local4:AnimatedChar = AnimatedChars.getAnimatedChar(String(_arg1.AnimatedTexture.File), int(_arg1.AnimatedTexture.Index));
        var _local5:MaskedImage = _local4.imageFromDir(AnimatedChar.RIGHT, AnimatedChar.STAND, 0);
        var _local6:int = ((4 / _local5.width()) * 100);
        var _local7:BitmapData = TextureRedrawer.redraw(_local5.image_, _local6, true, 0);
        this.showUnlockRequirements = this.shouldShowUnlockRequirements(_arg2, _arg1);
        if (this.showUnlockRequirements) {
            _local7 = CachingColorTransformer.transformBitmapData(_local7, unlockReqCT);
        }
        this.portrait_ = new Bitmap();
        this.portrait_.bitmapData = _local7;
        this.portrait_.x = -4;
        this.portrait_.y = -4;
        addChild(this.portrait_);
        this.nameText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
        this.nameText_.setBold(true);
        this.nameText_.setStringBuilder(new LineBuilder().setParams(getDisplayId(_arg1)));
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        waiter.push(this.nameText_.textChanged);
        addChild(this.nameText_);
        this.descriptionText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3).setWordWrap(true).setMultiLine(true).setTextWidth(174);
        this.descriptionText_.setStringBuilder(new LineBuilder().setParams(_arg1.Description));
        this.descriptionText_.filters = [new DropShadowFilter(0, 0, 0)];
        waiter.push(this.descriptionText_.textChanged);
        addChild(this.descriptionText_);
        this.lineBreak_ = new LineBreakDesign(100, 0x1C1C1C);
        addChild(this.lineBreak_);
        if (this.showUnlockRequirements) {
            this.toUnlockText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3).setTextWidth(174).setBold(true);
            this.toUnlockText_.setStringBuilder(new LineBuilder().setParams(TextKey.TO_UNLOCK));
            this.toUnlockText_.filters = [new DropShadowFilter(0, 0, 0)];
            waiter.push(this.toUnlockText_.textChanged);
            addChild(this.toUnlockText_);
            this.unlockText_ = new TextFieldDisplayConcrete().setSize(13).setColor(16549442).setTextWidth(174).setWordWrap(false).setMultiLine(true);
            _local8 = new AppendingLineBuilder();
            for each (_local9 in _arg1.UnlockLevel) {
                _local11 = ObjectLibrary.idToType_[_local9.toString()];
                _local12 = int(_local9.@level);
                if (_arg2.getBestLevel(_local11) < int(_local9.@level)) {
                    _local8.pushParams(TextKey.TO_UNLOCK_REACH_LEVEL, {
                        "unlockLevel": _local12,
                        "typeToDisplay": ObjectLibrary.typeToDisplayId_[_local11]
                    });
                }
            }
            this.unlockText_.setStringBuilder(_local8);
            this.unlockText_.filters = [new DropShadowFilter(0, 0, 0)];
            waiter.push(this.unlockText_.textChanged);
            addChild(this.unlockText_);
            this.costText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xFF00);
            this.costText_.setStringBuilder(new LineBuilder().setParams(TextKey.OR_BUY_NOW, {"unlockCost": _arg1.UnlockCost}));
            this.costText_.filters = [new DropShadowFilter(0, 0, 0)];
            waiter.push(this.costText_.textChanged);
            addChild(this.costText_);
            _local10 = IconFactory.makeCoin();
            this.coinBitmap_ = new Bitmap(_local10);
            addChild(this.coinBitmap_);
        }
        else {
            _local13 = (((_arg3 == null)) ? 0 : _arg3.numStars());
            this.bestLevel_ = new TextFieldDisplayConcrete().setSize(14).setColor(6206769).setMultiLine(true);
            this.bestLevel_.setStringBuilder(new LineBuilder().setParams(TextKey.BEST_LEVEL_STATS, {
                "numStars": _local13,
                "bestLevel": (((_arg3) != null) ? _arg3.bestLevel() : 0),
                "fame": (((_arg3) != null) ? _arg3.bestFame() : 0)
            }));
            this.bestLevel_.filters = [new DropShadowFilter(0, 0, 0)];
            waiter.push(this.bestLevel_.textChanged);
            addChild(this.bestLevel_);
            _local14 = FameUtil.nextStarFame((((_arg3 == null)) ? 0 : _arg3.bestFame()), 0);
            if (_local14 > 0) {
                this.nextClassQuest_ = new TextFieldDisplayConcrete().setSize(13).setColor(16549442).setTextWidth(160).setMultiLine(true).setWordWrap(true);
                this.nextClassQuest_.setStringBuilder(new LineBuilder().setParams(TextKey.NEXT_CLASS_QUEST, {
                    "nextStarFame": _local14,
                    "typeToDisplay": getDisplayId(_arg1)
                }));
                this.nextClassQuest_.filters = [new DropShadowFilter(0, 0, 0)];
                waiter.push(this.nextClassQuest_.textChanged);
                addChild(this.nextClassQuest_);
            }
        }
    }

    public static function getDisplayId(_arg1:XML):String {
        return ((((_arg1.DisplayId == undefined)) ? _arg1.@id : _arg1.DisplayId));
    }


    override protected function alignUI():void {
        this.nameText_.x = 32;
        this.nameText_.y = 6;
        this.descriptionText_.x = 8;
        this.descriptionText_.y = 40;
        this.lineBreak_.x = 6;
        this.lineBreak_.y = height;
        if (this.showUnlockRequirements) {
            this.toUnlockText_.x = 8;
            this.toUnlockText_.y = (height - 2);
            this.unlockText_.x = 12;
            this.unlockText_.y = (height - 4);
            this.costText_.x = 12;
            this.costText_.y = (height - 4);
            this.coinBitmap_.y = (this.costText_.y - 2);
            this.coinBitmap_.x = ((this.costText_.x + this.costText_.getBounds(this.costText_).width) + 4);
        }
        else {
            this.bestLevel_.x = 8;
            this.bestLevel_.y = (height - 2);
            if (this.nextClassQuest_) {
                this.nextClassQuest_.x = 8;
                this.nextClassQuest_.y = (height - 2);
            }
        }
        this.draw();
        position();
    }

    private function shouldShowUnlockRequirements(_arg1:PlayerModel, _arg2:XML):Boolean {
        var _local3:Boolean = _arg1.isClassAvailability(String(_arg2.@id), SavedCharactersList.UNRESTRICTED);
        var _local4:Boolean = _arg1.isLevelRequirementsMet(int(_arg2.@type));
        return (((!(_local3)) && (!(_local4))));
    }

    override public function draw():void {
        this.lineBreak_.setWidthColor((width - 10), 0x1C1C1C);
        super.draw();
    }


}
}
