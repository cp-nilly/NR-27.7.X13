package kabam.rotmg.account.steam.services {
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;

import kabam.rotmg.account.steam.SteamApi;

import org.osflash.signals.OnceSignal;
import org.osflash.signals.Signal;

import robotlegs.bender.framework.api.ILogger;

public class LiveSteamApi extends Sprite implements SteamApi {

    private const _loaded:Signal = new Signal();
    private const _sessionReceived:Signal = new Signal(Boolean);
    private const _paymentAuthorized:Signal = new Signal(uint, String, Boolean);

    [Inject]
    public var logger:ILogger;
    private var loader:Loader;
    private var api;
    private var steamID:String;
    private var sessionTicket:String;


    public function load(_arg1:String):void {
        this.logger.info("LiveSteamApi load");
        addChild((this.loader = new Loader()));
        this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onAPILoaded);
        this.loader.load(new URLRequest(_arg1));
    }

    private function onAPILoaded(_arg1:Event):void {
        this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onAPILoaded);
        this.api = _arg1.target.content;
        this.api.addEventListener("STEAM_MICRO_TXN_AUTH", this.onSteamMicroTxnAuthEvent);
        this.loaded.dispatch();
    }

    private function onSteamMicroTxnAuthEvent(_arg1:*):void {
        this.logger.debug("LiveSteamApi onSteamMicroTxnAuthEvent: {0}", [this.sessionTicket]);
        var _local2:uint = uint(_arg1.appID);
        var _local3:String = String(_arg1.orderID);
        var _local4:Boolean = Boolean(_arg1.isAuthorized);
        this._paymentAuthorized.dispatch(_local2, _local3, _local4);
    }

    public function requestSessionTicket():void {
        this.logger.debug("LiveSteamApi requestSessionTicket");
        this.api.requestSessionTicket(this.onSessionTicketResponse);
    }

    private function onSessionTicketResponse(_arg1:String):void {
        var _local2 = !((_arg1 == null));
        ((_local2) && ((this.sessionTicket = _arg1)));
        this.logger.debug("LiveSteamApi sessionTicket: {0}", [this.sessionTicket]);
        this.sessionReceived.dispatch(_local2);
    }

    public function getSessionAuthentication():Object {
        var _local1:Object = {};
        _local1.steamid = (this.steamID = ((this.steamID) || (this.api.getSteamID())));
        _local1.sessionticket = this.sessionTicket;
        return (_local1);
    }

    public function getSteamId():String {
        return (this.api.getSteamID());
    }

    public function reportStatistic(_arg1:String, _arg2:int):void {
        this.api.setStatFromInt(_arg1, _arg2);
    }

    public function get loaded():Signal {
        return (this._loaded);
    }

    public function get sessionReceived():Signal {
        return (this._sessionReceived);
    }

    public function get paymentAuthorized():OnceSignal {
        return (this._paymentAuthorized);
    }

    public function get isOverlayEnabled():Boolean {
        return (this.api.isOverlayEnabled());
    }

    public function getPersonaName():String {
        return (this.api.getPersonaName());
    }


}
}
