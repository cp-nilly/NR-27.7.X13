package kabam.rotmg.classes.control {
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.CharacterSkinState;
import kabam.rotmg.classes.model.ClassesModel;

public class ResetClassDataCommand {

    [Inject]
    public var classes:ClassesModel;


    public function execute():void {
        var _local1:int = this.classes.getCount();
        var _local2:int;
        while (_local2 < _local1) {
            this.resetClass(this.classes.getClassAtIndex(_local2));
            _local2++;
        }
    }

    private function resetClass(_arg1:CharacterClass):void {
        _arg1.setIsSelected((_arg1.id == ClassesModel.WIZARD_ID));
        this.resetClassSkins(_arg1);
    }

    private function resetClassSkins(_arg1:CharacterClass):void {
        var _local5:CharacterSkin;
        var _local2:CharacterSkin = _arg1.skins.getDefaultSkin();
        var _local3:int = _arg1.skins.getCount();
        var _local4:int;
        while (_local4 < _local3) {
            _local5 = _arg1.skins.getSkinAt(_local4);
            if (_local5 != _local2) {
                this.resetSkin(_arg1.skins.getSkinAt(_local4));
            }
            _local4++;
        }
    }

    private function resetSkin(_arg1:CharacterSkin):void {
        _arg1.setState(CharacterSkinState.LOCKED);
    }


}
}
