package kabam.rotmg.ui.view {
import flash.display.Sprite;

import kabam.rotmg.ui.model.Key;

import mx.core.BitmapAsset;

public class KeysView extends Sprite {

    private static var keyBackgroundPng:Class = KeysView_keyBackgroundPng;
    private static var greenKeyPng:Class = KeysView_greenKeyPng;
    private static var redKeyPng:Class = KeysView_redKeyPng;
    private static var yellowKeyPng:Class = KeysView_yellowKeyPng;
    private static var purpleKeyPng:Class = KeysView_purpleKeyPng;

    private var base:BitmapAsset;
    private var keys:Vector.<BitmapAsset>;

    public function KeysView() {
        this.base = new keyBackgroundPng();
        addChild(this.base);
        this.keys = new Vector.<BitmapAsset>(4, true);
        this.keys[0] = new purpleKeyPng();
        this.keys[1] = new greenKeyPng();
        this.keys[2] = new redKeyPng();
        this.keys[3] = new yellowKeyPng();
        var _local1:int;
        while (_local1 < 4) {
            this.keys[_local1].x = (12 + (40 * _local1));
            this.keys[_local1].y = 12;
            _local1++;
        }
    }

    public function showKey(_arg1:Key):void {
        var _local2:BitmapAsset = this.keys[_arg1.position];
        if (!contains(_local2)) {
            addChild(_local2);
        }
    }

    public function hideKey(_arg1:Key):void {
        var _local2:BitmapAsset = this.keys[_arg1.position];
        if (contains(_local2)) {
            removeChild(_local2);
        }
    }


}
}
