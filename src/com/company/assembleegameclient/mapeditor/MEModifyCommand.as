package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.editor.Command;

public class MEModifyCommand extends Command {

    private var map_:MEMap;
    private var x_:int;
    private var y_:int;
    private var layer_:int;
    private var oldType_:int;
    private var newType_:int;

    public function MEModifyCommand(_arg1:MEMap, _arg2:int, _arg3:int, _arg4:int, _arg5:int, _arg6:int) {
        this.map_ = _arg1;
        this.x_ = _arg2;
        this.y_ = _arg3;
        this.layer_ = _arg4;
        this.oldType_ = _arg5;
        this.newType_ = _arg6;
    }

    override public function execute():void {
        this.map_.modifyTile(this.x_, this.y_, this.layer_, this.newType_);
    }

    override public function unexecute():void {
        this.map_.modifyTile(this.x_, this.y_, this.layer_, this.oldType_);
    }


}
}
