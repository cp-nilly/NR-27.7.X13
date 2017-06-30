package kabam.rotmg.messaging.impl {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.Projectile;

import flash.utils.ByteArray;

import kabam.lib.net.impl.SocketServer;
import kabam.rotmg.servers.api.Server;

import org.osflash.signals.Signal;

public class GameServerConnection {

    public static const FAILURE:int = 0;
    public static const CREATE_SUCCESS:int = 81;
    public static const CREATE:int = 12;
    public static const PLAYERSHOOT:int = 66;
    public static const MOVE:int = 16;
    public static const PLAYERTEXT:int = 47;
    public static const TEXT:int = 96;
    public static const SERVERPLAYERSHOOT:int = 92;
    public static const DAMAGE:int = 97;
    public static const UPDATE:int = 42;
    public static const UPDATEACK:int = 91;
    public static const NOTIFICATION:int = 33;
    public static const NEWTICK:int = 68;
    public static const INVSWAP:int = 25;
    public static const USEITEM:int = 1;
    public static const SHOWEFFECT:int = 38;
    public static const HELLO:int = 9;
    public static const GOTO:int = 30;
    public static const INVDROP:int = 18;
    public static const INVRESULT:int = 63;
    public static const RECONNECT:int = 14;
    public static const PING:int = 85;
    public static const PONG:int = 64;
    public static const MAPINFO:int = 74;
    public static const LOAD:int = 26;
    public static const PIC:int = 46;
    public static const SETCONDITION:int = 60;
    public static const TELEPORT:int = 45;
    public static const USEPORTAL:int = 6;
    public static const DEATH:int = 83;
    public static const BUY:int = 93;
    public static const BUYRESULT:int = 50;
    public static const AOE:int = 89;
    public static const GROUNDDAMAGE:int = 98;
    public static const PLAYERHIT:int = 10;
    public static const ENEMYHIT:int = 19;
    public static const AOEACK:int = 77;
    public static const SHOOTACK:int = 35;
    public static const OTHERHIT:int = 57;
    public static const SQUAREHIT:int = 13;
    public static const GOTOACK:int = 79;
    public static const EDITACCOUNTLIST:int = 62;
    public static const ACCOUNTLIST:int = 44;
    public static const QUESTOBJID:int = 28;
    public static const CHOOSENAME:int = 23;
    public static const NAMERESULT:int = 22;
    public static const CREATEGUILD:int = 95;
    public static const GUILDRESULT:int = 82;
    public static const GUILDREMOVE:int = 49;
    public static const GUILDINVITE:int = 41;
    public static const ALLYSHOOT:int = 36;
    public static const ENEMYSHOOT:int = 52;
    public static const REQUESTTRADE:int = 34;
    public static const TRADEREQUESTED:int = 80;
    public static const TRADESTART:int = 31;
    public static const CHANGETRADE:int = 55;
    public static const TRADECHANGED:int = 4;
    public static const ACCEPTTRADE:int = 3;
    public static const CANCELTRADE:int = 39;
    public static const TRADEDONE:int = 94;
    public static const TRADEACCEPTED:int = 78;
    public static const CLIENTSTAT:int = 75;
    public static const CHECKCREDITS:int = 20;
    public static const ESCAPE:int = 87;
    public static const FILE:int = 56;
    public static const INVITEDTOGUILD:int = 58;
    public static const JOINGUILD:int = 27;
    public static const CHANGEGUILDRANK:int = 11;
    public static const PLAYSOUND:int = 59;
    public static const GLOBAL_NOTIFICATION:int = 24;
    public static const RESKIN:int = 15;
    public static const PETUPGRADEREQUEST:int = 67;
    public static const ACTIVE_PET_UPDATE_REQUEST:int = 90;
    public static const ACTIVEPETUPDATE:int = 76;
    public static const NEW_ABILITY:int = 21;
    public static const PETYARDUPDATE:int = 53;
    public static const EVOLVE_PET:int = 7;
    public static const DELETE_PET:int = 8;
    public static const HATCH_PET:int = 86;
    public static const ENTER_ARENA:int = 48;
    public static const IMMINENT_ARENA_WAVE:int = 5;
    public static const ARENA_DEATH:int = 17;
    public static const ACCEPT_ARENA_DEATH:int = 84;
    public static const VERIFY_EMAIL:int = 61;
    public static const RESKIN_UNLOCK:int = 40;
    public static const PASSWORD_PROMPT:int = 69;
    public static const QUEST_FETCH_ASK:int = 51;
    public static const QUEST_REDEEM:int = 37;
    public static const QUEST_FETCH_RESPONSE:int = 65;
    public static const QUEST_REDEEM_RESPONSE:int = 88;
    public static const SERVER_FULL = 110;
    public static const QUEUE_PING = 111;
    public static const QUEUE_PONG = 112;
    public static const MARKET_COMMAND = 99;
    public static const PET_CHANGE_FORM_MSG:int = 150;
    public static const QUEST_ROOM_MSG:int = 155;
    public static const KEY_INFO_REQUEST:int = 151;
    public static const KEY_INFO_RESPONSE:int = 152;
    public static const MARKET_RESULT = 100;
    public static const SET_FOCUS = 108;
    public static const SWITCH_MUSIC = 106;
    public static const CLAIM_LOGIN_REWARD_MSG:int = 153;
    public static const LOGIN_REWARD_MSG:int = 154;
    
    public static var instance:GameServerConnection;

    public var changeMapSignal:Signal;
    public var gs_:AGameSprite;
    public var server_:Server;
    public var gameId_:int;
    public var createCharacter_:Boolean;
    public var charId_:int;
    public var keyTime_:int;
    public var key_:ByteArray;
    public var mapJSON_:String;
    public var isFromArena_:Boolean = false;
    public var lastTickId_:int = -1;
    public var jitterWatcher_:JitterWatcher;
    public var serverConnection:SocketServer;
    public var outstandingBuy_:Boolean;


    public function chooseName(_arg1:String):void {
    }

    public function createGuild(_arg1:String):void {
    }

    public function connect():void {
    }

    public function disconnect():void {
    }

    public function checkCredits():void {
    }

    public function escape():void {
    }

    public function useItem(_arg1:int, _arg2:int, _arg3:int, _arg4:int, _arg5:Number, _arg6:Number, _arg7:int):void {
    }

    public function useItem_new(_arg1:GameObject, _arg2:int):Boolean {
        return (false);
    }

    public function enableJitterWatcher():void {
    }

    public function disableJitterWatcher():void {
    }

    public function editAccountList(_arg1:int, _arg2:Boolean, _arg3:int):void {
    }

    public function guildRemove(_arg1:String):void {
    }

    public function guildInvite(_arg1:String):void {
    }

    public function requestTrade(_arg1:String):void {
    }

    public function changeTrade(_arg1:Vector.<Boolean>):void {
    }

    public function acceptTrade(_arg1:Vector.<Boolean>, _arg2:Vector.<Boolean>):void {
    }

    public function cancelTrade():void {
    }

    public function joinGuild(_arg1:String):void {
    }

    public function changeGuildRank(_arg1:String, _arg2:int):void {
    }

    public function isConnected():Boolean {
        return (false);
    }

    public function teleport(_arg1:int):void {
    }

    public function usePortal(_arg1:int):void {
    }

    public function getNextDamage(_arg1:uint, _arg2:uint):uint {
        return (0);
    }

    public function groundDamage(_arg1:int, _arg2:Number, _arg3:Number):void {
    }

    public function playerShoot(_arg1:int, _arg2:Projectile):void {
    }

    public function playerHit(_arg1:int, _arg2:int):void {
    }

    public function enemyHit(_arg1:int, _arg2:int, _arg3:int, _arg4:Boolean):void {
    }

    public function otherHit(_arg1:int, _arg2:int, _arg3:int, _arg4:int):void {
    }

    public function squareHit(_arg1:int, _arg2:int, _arg3:int):void {
    }

    public function playerText(_arg1:String):void {
    }

    public function invSwap(_arg1:Player, _arg2:GameObject, _arg3:int, _arg4:int, _arg5:GameObject, _arg6:int, _arg7:int):Boolean {
        return (false);
    }

    public function invSwapPotion(_arg1:Player, _arg2:GameObject, _arg3:int, _arg4:int, _arg5:GameObject, _arg6:int, _arg7:int):Boolean {
        return (false);
    }

    public function invDrop(_arg1:GameObject, _arg2:int, _arg3:int):void {
    }

    public function setCondition(_arg1:uint, _arg2:Number):void {
    }

    public function buy(_arg1:int, _arg2:int):void {
    }

    public function questFetch():void {
    }

    public function questRedeem(_arg1:int, _arg2:int, _arg3:int):void {
    }

    public function keyInfoRequest(_arg1:int):void {
    }

    public function gotoQuestRoom():void {
    }


}
}
