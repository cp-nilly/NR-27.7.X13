package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.appengine.SavedNewsItem;

import flash.display.Sprite;

import kabam.rotmg.core.model.PlayerModel;

public class Graveyard extends Sprite {

    private var lines_:Vector.<GraveyardLine>;
    private var hasCharacters_:Boolean = false;

    public function Graveyard(_arg1:PlayerModel) {
        var _local2:SavedNewsItem;
        this.lines_ = new Vector.<GraveyardLine>();
        super();
        for each (_local2 in _arg1.getNews()) {
            if (_local2.isCharDeath()) {
                this.addLine(new GraveyardLine(_local2.getIcon(), _local2.title_, _local2.tagline_, _local2.link_, _local2.date_, _arg1.getAccountId()));
                this.hasCharacters_ = true;
            }
        }
    }

    public function hasCharacters():Boolean {
        return (this.hasCharacters_);
    }

    public function addLine(_arg1:GraveyardLine):void {
        _arg1.y = (4 + (this.lines_.length * (GraveyardLine.HEIGHT + 4)));
        this.lines_.push(_arg1);
        addChild(_arg1);
    }


}
}
