/**
 * Created by Fabian on 17.07.2015.
 */
package kabam.rotmg.messaging.impl.data {
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class MarketOffer {

    public var price:int;
    public var objectSlot:SlotObjectData;

    public function MarketOffer() {
        this.objectSlot = new SlotObjectData();
    }

    public function parseFromInput(rdr:IDataInput):void {
        this.price = rdr.readInt();
        this.objectSlot.parseFromInput(rdr);
    }

    public function writeToOutput(wtr:IDataOutput):void {
        wtr.writeInt(this.price);
        objectSlot.writeToOutput(wtr);
    }

    public function toString():String {
        return "price: " + this.price + " objectSlot: " + objectSlot.toString();
    }
}
}
