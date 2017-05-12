package kabam.rotmg.dialogs.view {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;

public class DialogsView extends Sprite {

    private var background:Sprite;
    private var container:DisplayObjectContainer;
    private var current:Sprite;
    private var pushed:DisplayObject;

    public function DialogsView() {
        addChild((this.background = new Sprite()));
        addChild((this.container = new Sprite()));
        this.background.visible = false;
        this.background.mouseEnabled = true;
    }

    public function showBackground(_arg1:int = 0x151515):void {
        var _local2:Graphics = this.background.graphics;
        _local2.clear();
        _local2.beginFill(_arg1, 0.6);
        _local2.drawRect(0, 0, 800, 600);
        _local2.endFill();
        this.background.visible = true;
    }

    public function show(_arg1:Sprite, _arg2:Boolean):void {
        this.removeCurrentDialog();
        this.addDialog(_arg1);
        ((_arg2) && (this.showBackground()));
    }

    public function hideAll():void {
        this.background.visible = false;
        this.removeCurrentDialog();
    }

    public function push(_arg1:Sprite):void {
        this.current.visible = false;
        this.pushed = _arg1;
        addChild(_arg1);
        this.background.visible = true;
    }

    public function getPushed():DisplayObject {
        return (this.pushed);
    }

    public function pop():void {
        removeChild(this.pushed);
        this.current.visible = true;
    }

    private function addDialog(_arg1:Sprite):void {
        this.current = _arg1;
        _arg1.addEventListener(Event.REMOVED, this.onRemoved);
        this.container.addChild(_arg1);
    }

    private function onRemoved(_arg1:Event):void {
        var _local2:Sprite = (_arg1.target as Sprite);
        if (this.current == _local2) {
            this.background.visible = false;
            this.current = null;
        }
    }

    private function removeCurrentDialog():void {
        if (((this.current) && (this.container.contains(this.current)))) {
            this.current.removeEventListener(Event.REMOVED, this.onRemoved);
            this.container.removeChild(this.current);
            this.background.visible = false;
        }
    }


}
}
