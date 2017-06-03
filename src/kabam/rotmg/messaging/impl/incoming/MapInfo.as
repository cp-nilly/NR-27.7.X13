package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class MapInfo extends IncomingMessage {

    public var width_:int;
    public var height_:int;
    public var name_:String;
    public var displayName_:String;
    public var difficulty_:int;
    public var fp_:uint;
    public var background_:int;
    public var allowPlayerTeleport_:Boolean;
    public var showDisplays_:Boolean;
    public var clientXML_:Vector.<String>;
    public var extraXML_:Vector.<String>;
    public var music:String;

    public function MapInfo(_arg1:uint, _arg2:Function) {
        this.clientXML_ = new Vector.<String>();
        this.extraXML_ = new Vector.<String>();
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.parseProperties(_arg1);
        this.parseXML(_arg1);
        this.music = _arg1.readUTF();
    }

    private function parseProperties(_arg1:IDataInput):void {
        this.width_ = _arg1.readInt();
        this.height_ = _arg1.readInt();
        this.name_ = _arg1.readUTF();
        this.displayName_ = _arg1.readUTF();
        this.fp_ = _arg1.readUnsignedInt();
        this.background_ = _arg1.readInt();
        this.difficulty_ = _arg1.readInt();
        this.allowPlayerTeleport_ = _arg1.readBoolean();
        this.showDisplays_ = _arg1.readBoolean();
    }

    private function parseXML(_arg1:IDataInput):void {
        var _local2:int;
        var _local3:int;
        var _local4:int;
        _local2 = _arg1.readShort();
        this.clientXML_.length = 0;
        _local3 = 0;
        while (_local3 < _local2) {
            _local4 = _arg1.readInt();
            this.clientXML_.push(_arg1.readUTFBytes(_local4));
            _local3++;
        }
        _local2 = _arg1.readShort();
        this.extraXML_.length = 0;
        _local3 = 0;
        while (_local3 < _local2) {
            _local4 = _arg1.readInt();
            this.extraXML_.push(_arg1.readUTFBytes(_local4));
            _local3++;
        }
    }

    override public function toString():String {
        return (formatToString("MAPINFO", "width_", "height_", "name_", "fp_", "background_", "allowPlayerTeleport_", "showDisplays_", "clientXML_", "extraXML_"));
    }


}
}
