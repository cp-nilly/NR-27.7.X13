package kabam.rotmg.account.core.model {
import com.company.assembleegameclient.util.offer.Offer;

import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public interface MoneyConfig {

    function showPaymentMethods():Boolean;

    function showBonuses():Boolean;

    function parseOfferPrice(_arg1:Offer):StringBuilder;

    function jsInitializeFunction():String;

}
}
