package com.company.assembleegameclient.game.events {
import kabam.rotmg.messaging.impl.incoming.KeyInfoResponse;

import org.osflash.signals.Signal;

public class KeyInfoResponseSignal extends Signal {

    public function KeyInfoResponseSignal() {
        super(KeyInfoResponse);
    }

}
}
