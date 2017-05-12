package com.company.assembleegameclient.util.offer {
public class Offer {

    public var id_:String;
    public var price_:Number;
    public var realmGold_:int;
    public var jwt_:String;
    public var data_:String;
    public var currency_:String;
    public var tagline:String;
    public var bonus:int;

    public function Offer(_arg1:String, _arg2:Number, _arg3:int, _arg4:String, _arg5:String, _arg6:String = null):void {
        this.id_ = _arg1;
        this.price_ = _arg2;
        this.realmGold_ = _arg3;
        this.jwt_ = _arg4;
        this.data_ = _arg5;
        this.currency_ = (((_arg6) != null) ? _arg6 : "USD");
    }

}
}
