package kabam.rotmg.mysterybox.services {
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

public class MysteryBoxModel {

    private var models:Object;
    private var initialized:Boolean = false;
    private var _isNew:Boolean = false;


    public function getBoxesOrderByWeight():Object {
        return (this.models);
    }

    public function setMysetryBoxes(_arg1:Array):void {
        var _local2:MysteryBoxInfo;
        this.models = {};
        for each (_local2 in _arg1) {
            this.models[_local2.id] = _local2;
        }
        this.initialized = true;
    }

    public function isInitialized():Boolean {
        return (this.initialized);
    }

    public function setInitialized(_arg1:Boolean):void {
        this.initialized = _arg1;
    }

    public function get isNew():Boolean {
        return (this._isNew);
    }

    public function set isNew(_arg1:Boolean):void {
        this._isNew = _arg1;
    }


}
}
