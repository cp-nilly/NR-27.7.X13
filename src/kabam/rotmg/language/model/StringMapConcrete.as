package kabam.rotmg.language.model {
public class StringMapConcrete implements StringMap {

    private var valueMap:Object;
    private var languageFamilyMap:Object;

    public function StringMapConcrete() {
        this.valueMap = {};
        this.languageFamilyMap = {};
        super();
    }

    public function clear():void {
        this.valueMap = {};
        this.languageFamilyMap = {};
    }

    public function setValue(_arg1:String, _arg2:String, _arg3:String):void {
        this.valueMap[_arg1] = _arg2;
        this.languageFamilyMap[_arg1] = _arg3;
    }

    public function hasKey(_arg1:String):Boolean {
        return (!((this.valueMap[_arg1] == null)));
    }

    public function getValue(_arg1:String):String {
        return (this.valueMap[_arg1]);
    }

    public function getLanguageFamily(_arg1:String):String {
        return (this.languageFamilyMap[_arg1]);
    }


}
}
