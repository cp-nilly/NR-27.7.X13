package kabam.rotmg.account.steam.model {
import com.company.assembleegameclient.util.offer.Offer;

import kabam.rotmg.account.core.model.MoneyConfig;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class SteamMoneyConfig implements MoneyConfig {


    public function showPaymentMethods():Boolean {
        return (false);
    }

    public function showBonuses():Boolean {
        return (false);
    }

    public function parseOfferPrice(_arg1:Offer):StringBuilder {
        return (new LineBuilder().setParams(TextKey.PAYMENTS_STEAM_COST, {
            "cost": _arg1.price_,
            "currency": _arg1.currency_
        }));
    }

    public function jsInitializeFunction():String {
        throw (new Error("No current support for new Kabam offer wall on Steam."));
    }


}
}
