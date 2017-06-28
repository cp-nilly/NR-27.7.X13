package kabam.rotmg.editor.view.components {

public class PictureType {

    public static const INVALID:int = 0;
    public static const CHARACTER:int = 1;
    public static const ITEM:int = 2;
    public static const ENVIRONMENT:int = 3;
    public static const PROJECTILE:int = 4;
    public static const TEXTILE:int = 5;
    public static const INTERFACE:int = 6;
    public static const MISCELLANEOUS:int = 7;
    public static const TYPES:Vector.<PictureType> = new <PictureType>[new PictureType("Any Type", ""), new PictureType("Character", "(e.g. humans, orcs, slimes, etc.)"), new PictureType("Item", "(e.g. swords, armor, rings, etc.)"), new PictureType("Environment", "(e.g. trees, rocks, portals, etc.)"), new PictureType("Projectile", "(e.g. arrows, magic bolts, etc.)"), new PictureType("Textile", "(clothing for players)"), new PictureType("Interface", "(e.g. icons, etc.)"), new PictureType("Miscellaneous", "(anything else)")];

    public var name_:String;
    public var examples_:String;

    public function PictureType(_arg_1:String, _arg_2:String) {
        this.name_ = _arg_1;
        this.examples_ = _arg_2;
    }

    public static function nameToType(_arg_1:String):int {
        var _local_2:int;
        while (_local_2 < TYPES.length) {
            if (TYPES[_local_2].name_ == _arg_1) {
                return (_local_2);
            }
            _local_2++;
        }
        return (INVALID);
    }


}
}
