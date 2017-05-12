package kabam.rotmg.util.components {
import flash.display.Sprite;

import kabam.lib.ui.api.Scrollbar;

import org.osflash.signals.Signal;

public class VerticalScrollbar extends Sprite implements Scrollbar {

    public static const WIDTH:int = 20;
    public static const BEVEL:int = 4;
    public static const PADDING:int = 0;

    public const groove:VerticalScrollbarGroove = new VerticalScrollbarGroove();
    public const bar:VerticalScrollbarBar = new VerticalScrollbarBar();

    private var _positionChanged:Signal;
    private var position:Number = 0;
    private var range:int;
    private var invRange:Number;
    private var isEnabled:Boolean = true;

    public function VerticalScrollbar() {
        addChild(this.groove);
        addChild(this.bar);
        this.addMouseListeners();
    }

    public function get positionChanged():Signal {
        return ((this._positionChanged = ((this._positionChanged) || (new Signal(Number)))));
    }

    public function getIsEnabled():Boolean {
        return (this.isEnabled);
    }

    public function setIsEnabled(_arg1:Boolean):void {
        if (this.isEnabled != _arg1) {
            this.isEnabled = _arg1;
            if (_arg1) {
                this.addMouseListeners();
            }
            else {
                this.removeMouseListeners();
            }
        }
    }

    private function addMouseListeners():void {
        this.groove.addMouseListeners();
        this.groove.clicked.add(this.onGrooveClicked);
        this.bar.addMouseListeners();
        this.bar.dragging.add(this.onBarDrag);
        this.bar.scrolling.add(this.scrollPosition);
    }

    private function removeMouseListeners():void {
        this.groove.removeMouseListeners();
        this.groove.clicked.remove(this.onGrooveClicked);
        this.bar.removeMouseListeners();
        this.bar.dragging.remove(this.onBarDrag);
        this.bar.scrolling.remove(this.scrollPosition);
    }

    public function setSize(_arg1:int, _arg2:int):void {
        this.bar.rect.height = _arg1;
        this.groove.rect.height = _arg2;
        this.range = ((_arg2 - _arg1) - (PADDING * 2));
        this.invRange = (1 / this.range);
        this.groove.redraw();
        this.bar.redraw();
        this.setPosition(this.getPosition());
    }

    public function getBarSize():int {
        return (this.bar.rect.height);
    }

    public function getGrooveSize():int {
        return (this.groove.rect.height);
    }

    public function getPosition():Number {
        return (this.position);
    }

    public function setPosition(_arg1:Number):void {
        if (_arg1 < 0) {
            _arg1 = 0;
        }
        else {
            if (_arg1 > 1) {
                _arg1 = 1;
            }
        }
        this.position = _arg1;
        this.bar.y = (PADDING + (this.range * this.position));
        ((this._positionChanged) && (this._positionChanged.dispatch(this.position)));
    }

    public function scrollPosition(_arg1:Number):void {
        var _local2:Number = (this.position + _arg1);
        this.setPosition(_local2);
    }

    private function onBarDrag(_arg1:int):void {
        this.setPosition(((_arg1 - PADDING) * this.invRange));
    }

    private function onGrooveClicked(_arg1:int):void {
        var _local2:int = this.bar.rect.height;
        var _local3:int = (_arg1 - (_local2 * 0.5));
        var _local4:int = (this.groove.rect.height - _local2);
        this.setPosition((_local3 / _local4));
    }


}
}
