package kabam.rotmg.servers.api {
public final class LatLong {

    private static const TO_DEGREES:Number = (180 / Math.PI);//57.2957795130823
    private static const TO_RADIANS:Number = (Math.PI / 180);//0.0174532925199433
    private static const DISTANCE_SCALAR:Number = (((60 * 1.1515) * 1.609344) * 1000);//111189.57696

    public var latitude:Number;
    public var longitude:Number;

    public function LatLong(_arg1:Number, _arg2:Number) {
        this.latitude = _arg1;
        this.longitude = _arg2;
    }

    public static function distance(_arg1:LatLong, _arg2:LatLong):Number {
        var _local3:Number = (TO_RADIANS * (_arg1.longitude - _arg2.longitude));
        var _local4:Number = (TO_RADIANS * _arg1.latitude);
        var _local5:Number = (TO_RADIANS * _arg2.latitude);
        var _local6:Number = ((Math.sin(_local4) * Math.sin(_local5)) + ((Math.cos(_local4) * Math.cos(_local5)) * Math.cos(_local3)));
        _local6 = ((TO_DEGREES * Math.acos(_local6)) * DISTANCE_SCALAR);
        return (_local6);
    }


    public function toString():String {
        return ((((("(" + this.latitude) + ", ") + this.longitude) + ")"));
    }


}
}
