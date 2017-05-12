package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.util.FreeList;

public class BubbleParticle extends Particle {

    private const SPREAD_DAMPER:Number = 0.0025;

    public var startTime:int;
    public var speed:Number;
    public var spread:Number;
    public var dZ:Number;
    public var life:Number;
    public var lifeVariance:Number;
    public var speedVariance:Number;
    public var timeLeft:Number;
    public var frequencyX:Number;
    public var frequencyY:Number;

    public function BubbleParticle(_arg1:uint, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number) {
        super(_arg1, 0, (75 + (Math.random() * 50)));
        this.dZ = _arg2;
        this.life = (_arg3 * 1000);
        this.lifeVariance = _arg4;
        this.speedVariance = _arg5;
        this.spread = _arg6;
        this.frequencyX = 0;
        this.frequencyY = 0;
    }

    public static function create(_arg1:*, _arg2:uint, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number, _arg7:Number):BubbleParticle {
        var _local8:BubbleParticle = (FreeList.getObject(_arg1) as BubbleParticle);
        if (!_local8) {
            _local8 = new (BubbleParticle)(_arg2, _arg3, _arg4, _arg5, _arg6, _arg7);
        }
        return (_local8);
    }


    public function restart(_arg1:int, _arg2:int):void {
        this.startTime = _arg1;
        var _local3:Number = Math.random();
        this.speed = ((this.dZ - (this.dZ * (_local3 * (1 - this.speedVariance)))) * 10);
        if (this.spread > 0) {
            this.frequencyX = ((Math.random() * this.spread) - 0.1);
            this.frequencyY = ((Math.random() * this.spread) - 0.1);
        }
        var _local4:Number = ((_arg2 - _arg1) / 1000);
        this.timeLeft = (this.life - (this.life * (_local3 * (1 - this.lifeVariance))));
        z_ = (this.speed * _local4);
    }

    override public function removeFromMap():void {
        super.removeFromMap();
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local3:Number = ((_arg1 - this.startTime) / 1000);
        this.timeLeft = (this.timeLeft - _arg2);
        if (this.timeLeft <= 0) {
            return (false);
        }
        z_ = (this.speed * _local3);
        if (this.spread > 0) {
            moveTo((x_ + ((this.frequencyX * _arg2) * this.SPREAD_DAMPER)), (y_ + ((this.frequencyY * _arg2) * this.SPREAD_DAMPER)));
        }
        return (true);
    }


}
}
