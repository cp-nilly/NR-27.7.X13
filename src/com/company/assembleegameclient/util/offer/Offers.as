package com.company.assembleegameclient.util.offer {
public class Offers {

    private static const BEST_DEAL:String = "(Best deal)";
    private static const MOST_POPULAR:String = "(Most popular)";

    public var tok:String;
    public var exp:String;
    public var offerList:Vector.<Offer>;

    public function Offers(_arg1:XML) {
        this.tok = _arg1.Tok;
        this.exp = _arg1.Exp;
        this.makeOffers(_arg1);
    }

    private function makeOffers(_arg1:XML):void {
        this.makeOfferList(_arg1);
        this.sortOfferList();
        this.defineBonuses();
        this.defineMostPopularTagline();
        this.defineBestDealTagline();
    }

    private function makeOfferList(_arg1:XML):void {
        var _local2:XML;
        this.offerList = new <Offer>[];
        for each (_local2 in _arg1.Offer) {
            this.offerList.push(this.makeOffer(_local2));
        }
    }

    private function makeOffer(_arg1:XML):Offer {
        var _local2:String = _arg1.Id;
        var _local3:Number = Number(_arg1.Price);
        var _local4:int = int(_arg1.RealmGold);
        var _local5:String = _arg1.CheckoutJWT;
        var _local6:String = _arg1.Data;
        var _local7:String = ((_arg1.hasOwnProperty("Currency")) ? _arg1.Currency : null);
        return (new Offer(_local2, _local3, _local4, _local5, _local6, _local7));
    }

    private function sortOfferList():void {
        this.offerList.sort(this.sortOffers);
    }

    private function defineBonuses():void {
        var _local5:int;
        var _local6:int;
        var _local7:Number;
        var _local8:Number;
        if (this.offerList.length == 0) {
            return;
        }
        var _local1:int = this.offerList[0].realmGold_;
        var _local2:int = this.offerList[0].price_;
        var _local3:Number = (_local1 / _local2);
        var _local4:int = 1;
        while (_local4 < this.offerList.length) {
            _local5 = this.offerList[_local4].realmGold_;
            _local6 = this.offerList[_local4].price_;
            _local7 = (_local6 * _local3);
            _local8 = (_local5 - _local7);
            this.offerList[_local4].bonus = (_local8 / _local6);
            _local4++;
        }
    }

    private function sortOffers(_arg1:Offer, _arg2:Offer):int {
        return ((_arg1.price_ - _arg2.price_));
    }

    private function defineMostPopularTagline():void {
        var _local1:Offer;
        for each (_local1 in this.offerList) {
            if (_local1.price_ == 10) {
                _local1.tagline = MOST_POPULAR;
            }
        }
    }

    private function defineBestDealTagline():void {
        this.offerList[(this.offerList.length - 1)].tagline = BEST_DEAL;
    }


}
}
