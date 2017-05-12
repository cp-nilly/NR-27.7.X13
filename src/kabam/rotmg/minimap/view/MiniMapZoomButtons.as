package kabam.rotmg.minimap.view {
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

import org.osflash.signals.Signal;

public class MiniMapZoomButtons extends Sprite {

    private const FADE:ColorTransform = new ColorTransform(0.5, 0.5, 0.5);
    private const NORM:ColorTransform = new ColorTransform(1, 1, 1);
    public const zoom:Signal = new Signal(int);

    private var zoomOut:Sprite;
    private var zoomIn:Sprite;
    private var zoomLevels:int;
    private var zoomLevel:int;

    public function MiniMapZoomButtons() {
        this.zoomLevel = 0;
        this.makeZoomOut();
        this.makeZoomIn();
        this.updateButtons();
    }

    public function getZoomLevel():int {
        return (this.zoomLevel);
    }

    public function setZoomLevel(_arg1:int):int {
        if (this.zoomLevels == 0) {
            return (this.zoomLevel);
        }
        if (_arg1 < 0) {
            _arg1 = 0;
        }
        else {
            if (_arg1 >= (this.zoomLevels - 1)) {
                _arg1 = (this.zoomLevels - 1);
            }
        }
        this.zoomLevel = _arg1;
        this.updateButtons();
        return (this.zoomLevel);
    }

    public function setZoomLevels(_arg1:int):int {
        this.zoomLevels = _arg1;
        if (this.zoomLevel >= this.zoomLevels) {
            this.zoomLevel = (this.zoomLevels - 1);
        }
        this.updateButtons();
        return (this.zoomLevels);
    }

    private function makeZoomOut():void {
        var _local2:Bitmap;
        var _local1:BitmapData = AssetLibrary.getImageFromSet("lofiInterface", 54);
        _local2 = new Bitmap(_local1);
        _local2.scaleX = 2;
        _local2.scaleY = 2;
        this.zoomOut = new Sprite();
        this.zoomOut.x = 0;
        this.zoomOut.y = 4;
        this.zoomOut.addChild(_local2);
        this.zoomOut.addEventListener(MouseEvent.CLICK, this.onZoomOut);
        addChild(this.zoomOut);
    }

    private function makeZoomIn():void {
        var _local2:Bitmap;
        var _local1:BitmapData = AssetLibrary.getImageFromSet("lofiInterface", 55);
        _local2 = new Bitmap(_local1);
        _local2.scaleX = 2;
        _local2.scaleY = 2;
        this.zoomIn = new Sprite();
        this.zoomIn.x = 0;
        this.zoomIn.y = 14;
        this.zoomIn.addChild(_local2);
        this.zoomIn.addEventListener(MouseEvent.CLICK, this.onZoomIn);
        addChild(this.zoomIn);
    }

    private function onZoomOut(_arg1:MouseEvent):void {
        _arg1.stopPropagation();
        if (this.canZoomOut()) {
            this.zoom.dispatch(--this.zoomLevel);
            this.zoomOut.transform.colorTransform = ((this.canZoomOut()) ? this.NORM : this.FADE);
        }
    }

    private function canZoomOut():Boolean {
        return ((this.zoomLevel > 0));
    }

    private function onZoomIn(_arg1:MouseEvent):void {
        _arg1.stopPropagation();
        if (this.canZoomIn()) {
            this.zoom.dispatch(++this.zoomLevel);
            this.zoomIn.transform.colorTransform = ((this.canZoomIn()) ? this.NORM : this.FADE);
        }
    }

    private function canZoomIn():Boolean {
        return ((this.zoomLevel < (this.zoomLevels - 1)));
    }

    private function updateButtons():void {
        this.zoomIn.transform.colorTransform = ((this.canZoomIn()) ? this.NORM : this.FADE);
        this.zoomOut.transform.colorTransform = ((this.canZoomOut()) ? this.NORM : this.FADE);
    }


}
}
