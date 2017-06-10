/**
 * Created by Fabian on 14.07.2015.
 */
package kabam.rotmg.messaging.impl.data {
import flash.utils.IDataInput;

public class PlayerShopItem {

    public var id:int;
    public var itemId:uint;
    public var price:int;
    public var insertTime:int;
    public var count:int;
    public var isLast:Boolean;

    public function parseFromInput(rdr:IDataInput):void {
        this.id = rdr.readUnsignedInt();
        this.itemId = rdr.readUnsignedShort();
        this.price = rdr.readInt();
        this.insertTime = rdr.readInt();
        this.count = rdr.readInt();
        this.isLast = rdr.readBoolean();
    }
}
}
