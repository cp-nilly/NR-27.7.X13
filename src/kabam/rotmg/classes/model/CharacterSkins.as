package kabam.rotmg.classes.model {
public class CharacterSkins {

    private const skins:Vector.<CharacterSkin> = new <CharacterSkin>[];
    private const map:Object = {};

    private var defaultSkin:CharacterSkin;
    private var selectedSkin:CharacterSkin;
    private var maxLevelAchieved:int;


    public function getCount():int {
        return (this.skins.length);
    }

    public function getDefaultSkin():CharacterSkin {
        return (this.defaultSkin);
    }

    public function getSelectedSkin():CharacterSkin {
        return (this.selectedSkin);
    }

    public function getSkinAt(_arg1:int):CharacterSkin {
        return (this.skins[_arg1]);
    }

    public function addSkin(_arg1:CharacterSkin, _arg2:Boolean = false):void {
        _arg1.changed.add(this.onSkinChanged);
        this.skins.push(_arg1);
        this.map[_arg1.id] = _arg1;
        this.updateSkinState(_arg1);
        if (_arg2) {
            this.defaultSkin = _arg1;
            if (!this.selectedSkin) {
                this.selectedSkin = _arg1;
                _arg1.setIsSelected(true);
            }
        }
        else {
            if (_arg1.getIsSelected()) {
                this.selectedSkin = _arg1;
            }
        }
    }

    private function onSkinChanged(_arg1:CharacterSkin):void {
        if (((_arg1.getIsSelected()) && (!((this.selectedSkin == _arg1))))) {
            ((this.selectedSkin) && (this.selectedSkin.setIsSelected(false)));
            this.selectedSkin = _arg1;
        }
    }

    public function updateSkins(_arg1:int):void {
        var _local2:CharacterSkin;
        this.maxLevelAchieved = _arg1;
        for each (_local2 in this.skins) {
            this.updateSkinState(_local2);
        }
    }

    private function updateSkinState(_arg1:CharacterSkin):void {
        if (!_arg1.skinSelectEnabled) {
            _arg1.setState(CharacterSkinState.UNLISTED);
        }
        else {
            if (_arg1.getState().isSkinStateDeterminedByLevel()) {
                _arg1.setState(this.getSkinState(_arg1));
            }
        }
    }

    private function getSkinState(_arg1:CharacterSkin):CharacterSkinState {
        if (!_arg1.skinSelectEnabled) {
            return (CharacterSkinState.UNLISTED);
        }
        if ((((this.maxLevelAchieved >= _arg1.unlockLevel)) && ((_arg1.unlockSpecial == null)))) {
            return (CharacterSkinState.PURCHASABLE);
        }
        return (CharacterSkinState.LOCKED);
    }

    public function getSkin(_arg1:int):CharacterSkin {
        return (((this.map[_arg1]) || (this.defaultSkin)));
    }

    public function getListedSkins():Vector.<CharacterSkin> {
        var _local2:CharacterSkin;
        var _local1:Vector.<CharacterSkin> = new Vector.<CharacterSkin>();
        for each (_local2 in this.skins) {
            if (_local2.getState() != CharacterSkinState.UNLISTED) {
                _local1.push(_local2);
            }
        }
        return (_local1);
    }


}
}
