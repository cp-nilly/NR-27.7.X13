package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.editor.Command;

public class MEReplaceCommand extends Command {

    private var map_:MEMap;
    private var x_:int;
    private var y_:int;
    private var oldTile_:METile;
    private var newTile_:METile;

    public function MEReplaceCommand(_arg1:MEMap, _arg2:int, _arg3:int, _arg4:METile, _arg5:METile) {
        this.map_ = _arg1;
        this.x_ = _arg2;
        this.y_ = _arg3;
        if (_arg4 != null) {
            this.oldTile_ = _arg4.clone();
        }
        if (_arg5 != null) {
            this.newTile_ = _arg5.clone();
        }
    }

    override public function execute():void {
        if (this.newTile_ == null) {
            this.map_.eraseTile(this.x_, this.y_);
        }
        else {
            this.map_.setTile(this.x_, this.y_, this.newTile_);
        }
    }

    override public function unexecute():void {
        if (this.oldTile_ == null) {
            this.map_.eraseTile(this.x_, this.y_);
        }
        else {
            this.map_.setTile(this.x_, this.y_, this.oldTile_);
        }
    }


}
}
