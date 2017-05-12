package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.map.Map;
import com.company.util.PointUtil;

import flash.utils.Dictionary;

import kabam.rotmg.messaging.impl.incoming.AccountList;

public class Party {

    public static const NUM_MEMBERS:int = 6;
    private static const SORT_ON_FIELDS:Array = ["starred_", "distSqFromThisPlayer_", "objectId_"];
    private static const SORT_ON_PARAMS:Array = [(Array.NUMERIC | Array.DESCENDING), Array.NUMERIC, Array.NUMERIC];
    private static const PARTY_DISTANCE_SQ:int = (50 * 50);//2500

    public var map_:Map;
    public var members_:Array;
    private var starred_:Dictionary;
    private var ignored_:Dictionary;
    private var lastUpdate_:int = -2147483648;

    public function Party(_arg1:Map) {
        this.members_ = [];
        this.starred_ = new Dictionary(true);
        this.ignored_ = new Dictionary(true);
        super();
        this.map_ = _arg1;
    }

    public function update(_arg1:int, _arg2:int):void {
        var _local4:GameObject;
        var _local5:Player;
        if (_arg1 < (this.lastUpdate_ + 500)) {
            return;
        }
        this.lastUpdate_ = _arg1;
        this.members_.length = 0;
        var _local3:Player = this.map_.player_;
        if (_local3 == null) {
            return;
        }
        for each (_local4 in this.map_.goDict_) {
            _local5 = (_local4 as Player);
            if (!(((_local5 == null)) || ((_local5 == _local3)))) {
                _local5.starred_ = !((this.starred_[_local5.accountId_] == undefined));
                _local5.ignored_ = !((this.ignored_[_local5.accountId_] == undefined));
                _local5.distSqFromThisPlayer_ = PointUtil.distanceSquaredXY(_local3.x_, _local3.y_, _local5.x_, _local5.y_);
                if (!(((_local5.distSqFromThisPlayer_ > PARTY_DISTANCE_SQ)) && (!(_local5.starred_)))) {
                    this.members_.push(_local5);
                }
            }
        }
        this.members_.sortOn(SORT_ON_FIELDS, SORT_ON_PARAMS);
        if (this.members_.length > NUM_MEMBERS) {
            this.members_.length = NUM_MEMBERS;
        }
    }

    public function lockPlayer(_arg1:Player):void {
        this.starred_[_arg1.accountId_] = 1;
        this.lastUpdate_ = int.MIN_VALUE;
        this.map_.gs_.gsc_.editAccountList(0, true, _arg1.objectId_);
    }

    public function unlockPlayer(_arg1:Player):void {
        delete this.starred_[_arg1.accountId_];
        _arg1.starred_ = false;
        this.lastUpdate_ = int.MIN_VALUE;
        this.map_.gs_.gsc_.editAccountList(0, false, _arg1.objectId_);
    }

    public function setStars(_arg1:AccountList):void {
        var _local3:String;
        var _local2:int;
        while (_local2 < _arg1.accountIds_.length) {
            _local3 = _arg1.accountIds_[_local2];
            this.starred_[_local3] = 1;
            this.lastUpdate_ = int.MIN_VALUE;
            _local2++;
        }
    }

    public function removeStars(_arg1:AccountList):void {
        var _local3:String;
        var _local2:int;
        while (_local2 < _arg1.accountIds_.length) {
            _local3 = _arg1.accountIds_[_local2];
            delete this.starred_[_local3];
            this.lastUpdate_ = int.MIN_VALUE;
            _local2++;
        }
    }

    public function ignorePlayer(_arg1:Player):void {
        this.ignored_[_arg1.accountId_] = 1;
        this.lastUpdate_ = int.MIN_VALUE;
        this.map_.gs_.gsc_.editAccountList(1, true, _arg1.objectId_);
    }

    public function unignorePlayer(_arg1:Player):void {
        delete this.ignored_[_arg1.accountId_];
        _arg1.ignored_ = false;
        this.lastUpdate_ = int.MIN_VALUE;
        this.map_.gs_.gsc_.editAccountList(1, false, _arg1.objectId_);
    }

    public function setIgnores(_arg1:AccountList):void {
        var _local3:String;
        this.ignored_ = new Dictionary(true);
        var _local2:int;
        while (_local2 < _arg1.accountIds_.length) {
            _local3 = _arg1.accountIds_[_local2];
            this.ignored_[_local3] = 1;
            this.lastUpdate_ = int.MIN_VALUE;
            _local2++;
        }
    }


}
}
