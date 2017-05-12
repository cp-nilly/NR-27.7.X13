package com.company.assembleegameclient.editor {
public class CommandList {

    private var list_:Vector.<Command>;

    public function CommandList() {
        this.list_ = new Vector.<Command>();
        super();
    }

    public function empty():Boolean {
        return ((this.list_.length == 0));
    }

    public function addCommand(_arg1:Command):void {
        this.list_.push(_arg1);
    }

    public function execute():void {
        var _local1:Command;
        for each (_local1 in this.list_) {
            _local1.execute();
        }
    }

    public function unexecute():void {
        var _local1:Command;
        for each (_local1 in this.list_) {
            _local1.unexecute();
        }
    }


}
}
