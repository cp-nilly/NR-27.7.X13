package com.company.assembleegameclient.objects.particles {
import com.company.assembleegameclient.objects.thrown.BitmapParticle;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

public class ParticleField extends BitmapParticle {

    private const SMALL:String = "SMALL";
    private const LARGE:String = "LARGE";

    private var bitmapSize:String;
    private var width:int;
    private var height:int;
    public var lifetime_:int;
    public var timeLeft_:int;
    private var spriteSource:Sprite;
    private var squares:Array;
    private var visibleHeight:Number;
    private var offset:Number;
    private var timer:Timer;
    private var doDestroy:Boolean;

    public function ParticleField(_arg1:Number, _arg2:Number) {
        this.spriteSource = new Sprite();
        this.squares = [];
        this.setDimensions(_arg2, _arg1);
        this.setBitmapSize();
        this.createTimer();
        var _local3:BitmapData = new BitmapData(this.width, this.height, true, 0);
        _local3.draw(this.spriteSource);
        super(_local3, 0);
    }

    private function createTimer():void {
        this.timer = new Timer(this.getInterval());
        this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
        this.timer.start();
    }

    private function setDimensions(_arg1:Number, _arg2:Number):void {
        this.visibleHeight = ((_arg1 * 5) + 40);
        this.offset = (this.visibleHeight * 0.5);
        this.width = ((_arg2 * 5) + 40);
        this.height = (this.visibleHeight + this.offset);
    }

    private function setBitmapSize():void {
        this.bitmapSize = (((this.width == 8)) ? this.SMALL : this.LARGE);
    }

    override public function update(_arg1:int, _arg2:int):Boolean {
        var _local3:uint;
        if (this.doDestroy) {
            return (false);
        }
        var _local4:uint = this.squares.length;
        _local3 = 0;
        while (_local3 < _local4) {
            if (this.squares[_local3]) {
                this.squares[_local3].move();
            }
            _local3++;
        }
        _bitmapData = new BitmapData(this.width, this.height, true, 0);
        _bitmapData.draw(this.spriteSource);
        return (true);
    }

    private function onTimer(_arg1:TimerEvent):void {
        var _local2:Square = new Square(this.getStartPoint(), this.getEndPoint(), this.getLifespan());
        _local2.complete.add(this.onSquareComplete);
        this.squares.push(_local2);
        this.spriteSource.addChild(_local2);
    }

    private function getLifespan():uint {
        return ((((this.bitmapSize == this.SMALL)) ? 15 : 30));
    }

    private function getInterval():uint {
        return ((((this.bitmapSize == this.SMALL)) ? 100 : 50));
    }

    private function onSquareComplete(_arg1:Square):void {
        _arg1.complete.removeAll();
        this.spriteSource.removeChild(_arg1);
        this.squares.splice(this.squares.indexOf(_arg1), 1);
    }

    private function getStartPoint():Point {
        var _local1:Array = (((Math.random() < 0.5)) ? ["x", "y", "width", "visibleHeight"] : ["y", "x", "visibleHeight", "width"]);
        var _local2:Point = new Point(0, 0);
        _local2[_local1[0]] = (Math.random() * this[_local1[2]]);
        _local2[_local1[1]] = (((Math.random() < 0.5)) ? 0 : this[_local1[3]]);
        return (_local2);
    }

    private function getEndPoint():Point {
        return (new Point((this.width / 2), (this.visibleHeight / 2)));
    }

    public function destroy():void {
        if (this.timer != null) {
            this.timer.removeEventListener(TimerEvent.TIMER, this.onTimer);
            this.timer.stop();
            this.timer = null;
        }
        this.spriteSource = null;
        this.squares = [];
        this.doDestroy = true;
    }


}
}

import flash.display.Shape;
import flash.geom.Point;

import org.osflash.signals.Signal;

class Square extends Shape {

    public var start:Point;
    public var end:Point;
    /*private*/
    var lifespan:uint;
    /*private*/
    var moveX:Number;
    /*private*/
    var moveY:Number;
    /*private*/
    var angle:Number;
    public var complete:Signal;

    public function Square(_arg1:Point, _arg2:Point, _arg3:uint) {
        this.complete = new Signal();
        super();
        this.start = _arg1;
        this.end = _arg2;
        this.lifespan = _arg3;
        this.moveX = ((_arg2.x - _arg1.x) / _arg3);
        this.moveY = ((_arg2.y - _arg1.y) / _arg3);
        graphics.beginFill(0xFFFFFF);
        graphics.drawRect(-2, -2, 4, 4);
        this.position();
    }

    /*private*/
    function position():void {
        this.x = this.start.x;
        this.y = this.start.y;
    }

    public function move():void {
        this.x = (this.x + this.moveX);
        this.y = (this.y + this.moveY);
        this.lifespan--;
        if (!this.lifespan) {
            this.complete.dispatch(this);
        }
    }


}

