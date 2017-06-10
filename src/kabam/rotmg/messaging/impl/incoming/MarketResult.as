/**
 * Created by Fabian on 14.07.2015.
 */
package kabam.rotmg.messaging.impl.incoming {
import kabam.rotmg.messaging.impl.data.PlayerShopItem;

import flash.utils.IDataInput;

public class MarketResult extends IncomingMessage {

    public static const MARKET_ERROR:int = 0;
    public static const MARKET_SUCCESS:int = 1;
    public static const MARKET_REQUEST_RESULT:int = 2;

    public var commandId:int;
    public var message:String;
    public var error:Boolean;
    public var items:Vector.<PlayerShopItem>;

    public function MarketResult(packetId:uint, callback:Function) {
        this.items = new Vector.<PlayerShopItem>();
        super(packetId, callback);
    }

    override public function parseFromInput(rdr:IDataInput):void {

        commandId = rdr.readByte();
        switch (commandId) {
            case MARKET_ERROR:
            case MARKET_SUCCESS:
                message = rdr.readUTF();
                error = commandId == MARKET_ERROR;
                break;
            case MARKET_REQUEST_RESULT:
                this.items.length = 0;
                var len:int = rdr.readInt();
                for(var i:int = 0; i < len; i++) {
                    var item:PlayerShopItem = new PlayerShopItem();
                    item.parseFromInput(rdr);
                    this.items.push(item);
                }
                break;
        }
    }
}
}
