package kabam.rotmg.friends.model {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.FameUtil;

import flash.utils.Dictionary;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.friends.service.FriendDataRequestTask;
import kabam.rotmg.servers.api.Server;
import kabam.rotmg.servers.api.ServerModel;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

public class FriendModel {

    [Inject]
    public var serverModel:ServerModel;
    public var friendsTask:FriendDataRequestTask;
    public var invitationsTask:FriendDataRequestTask;
    private var _onlineFriends:Vector.<FriendVO>;
    private var _offlineFriends:Vector.<FriendVO>;
    private var _friends:Dictionary;
    private var _invitations:Dictionary;
    private var _friendsLoadInProcess:Boolean;
    private var _invitationsLoadInProgress:Boolean;
    private var _friendTotal:int;
    private var _invitationTotal:int;
    private var _isFriDataOK:Boolean;
    private var _isInvDataOK:Boolean;
    private var _serverDict:Dictionary;
    private var _currentServer:Server;
    public var errorStr:String;
    public var dataSignal:Signal;

    public function FriendModel() {
        this.dataSignal = new Signal(Boolean);
        super();
        this._friendTotal = 0;
        this._invitationTotal = 0;
        this._invitationTotal = 0;
        this._friends = new Dictionary(true);
        this._onlineFriends = new Vector.<FriendVO>();
        this._offlineFriends = new Vector.<FriendVO>();
        this._friendsLoadInProcess = false;
        this._invitationsLoadInProgress = false;
        this.loadData();
    }

    public function setCurrentServer(_arg1:Server):void {
        this._currentServer = _arg1;
    }

    public function getCurrentServerName():String {
        return (((this._currentServer) ? this._currentServer.name : ""));
    }

    public function loadData():void {
        if (((this._friendsLoadInProcess) || (this._invitationsLoadInProgress))) {
            return;
        }
        var _local1:Injector = StaticInjectorContext.getInjector();
        this._friendsLoadInProcess = true;
        this.friendsTask = _local1.getInstance(FriendDataRequestTask);
        this.loadList(this.friendsTask, FriendConstant.getURL(FriendConstant.FRIEND_LIST), this.onFriendListResponse);
        this._invitationsLoadInProgress = true;
        this.invitationsTask = _local1.getInstance(FriendDataRequestTask);
        this.loadList(this.invitationsTask, FriendConstant.getURL(FriendConstant.INVITE_LIST), this.onInvitationListResponse);
    }

    private function loadList(_arg1:FriendDataRequestTask, _arg2:String, _arg3:Function):void {
        _arg1.requestURL = _arg2;
        _arg1.finished.addOnce(_arg3);
        _arg1.start();
    }

    private function onFriendListResponse(_arg1:FriendDataRequestTask, _arg2:Boolean, _arg3:String = ""):void {
        if (_arg2) {
            this.seedFriends(_arg1.xml);
        }
        this._isFriDataOK = _arg2;
        this.errorStr = _arg3;
        _arg1.reset();
        this._friendsLoadInProcess = false;
        this.reportTasksComplete();
    }

    private function onInvitationListResponse(_arg1:FriendDataRequestTask, _arg2:Boolean, _arg3:String = ""):void {
        if (_arg2) {
            this.seedInvitations(_arg1.xml);
        }
        this._isInvDataOK = _arg2;
        this.errorStr = _arg3;
        _arg1.reset();
        this._invitationsLoadInProgress = false;
        this.reportTasksComplete();
    }

    private function reportTasksComplete():void {
        if ((((this._friendsLoadInProcess == false)) && ((this._invitationsLoadInProgress == false)))) {
            this.dataSignal.dispatch(((this._isFriDataOK) && (this._isInvDataOK)));
        }
    }

    public function seedFriends(_arg1:XML):void {
        var _local2:String;
        var _local3:String;
        var _local4:String;
        var _local5:FriendVO;
        var _local6:XML;
        this._onlineFriends.length = 0;
        this._offlineFriends.length = 0;
        for each (_local6 in _arg1.Account) {
            _local2 = _local6.Name;
            _local5 = (((this._friends[_local2]) != null) ? (this._friends[_local2].vo as FriendVO) : new FriendVO(Player.fromPlayerXML(_local2, _local6.Character[0])));
            if (_local6.hasOwnProperty("Online")) {
                _local4 = String(_local6.Online);
                _local3 = this.serverNameDictionary()[_local4];
                _local5.online(_local3, _local4);
                this._onlineFriends.push(_local5);
                this._friends[_local5.getName()] = {
                    "vo": _local5,
                    "list": this._onlineFriends
                };
            }
            else {
                _local5.offline();
                this._offlineFriends.push(_local5);
                this._friends[_local5.getName()] = {
                    "vo": _local5,
                    "list": this._offlineFriends
                };
            }
        }
        this._onlineFriends.sort(this.sortFriend);
        this._offlineFriends.sort(this.sortFriend);
        this._friendTotal = (this._onlineFriends.length + this._offlineFriends.length);
    }

    public function seedInvitations(_arg1:XML):void {
        var _local2:String;
        var _local3:XML;
        var _local4:Player;
        this._invitations = new Dictionary(true);
        this._invitationTotal = 0;
        for each (_local3 in _arg1.Account) {
            if (this.starFilter(int(_local3.Character[0].ObjectType), int(_local3.Character[0].CurrentFame), _local3.Stats[0])) {
                _local2 = _local3.Name;
                _local4 = Player.fromPlayerXML(_local2, _local3.Character[0]);
                this._invitations[_local2] = new FriendVO(_local4);
                this._invitationTotal++;
            }
        }
    }

    public function isMyFriend(_arg1:String):Boolean {
        return (!((this._friends[_arg1] == null)));
    }

    public function updateFriendVO(_arg1:String, _arg2:Player):void {
        var _local3:Object;
        var _local4:FriendVO;
        if (this.isMyFriend(_arg1)) {
            _local3 = this._friends[_arg1];
            _local4 = (_local3.vo as FriendVO);
            _local4.updatePlayer(_arg2);
        }
    }

    public function getFilterFriends(_arg1:String):Vector.<FriendVO> {
        var _local3:FriendVO;
        var _local2:RegExp = new RegExp(_arg1, "gix");
        var _local4:Vector.<FriendVO> = new Vector.<FriendVO>();
        var _local5:int;
        while (_local5 < this._onlineFriends.length) {
            _local3 = this._onlineFriends[_local5];
            if (_local3.getName().search(_local2) >= 0) {
                _local4.push(_local3);
            }
            _local5++;
        }
        _local5 = 0;
        while (_local5 < this._offlineFriends.length) {
            _local3 = this._offlineFriends[_local5];
            if (_local3.getName().search(_local2) >= 0) {
                _local4.push(_local3);
            }
            _local5++;
        }
        return (_local4);
    }

    public function ifReachMax():Boolean {
        return ((this._friendTotal >= FriendConstant.FRIEMD_MAX_CAP));
    }

    public function getAllFriends():Vector.<FriendVO> {
        return (this._onlineFriends.concat(this._offlineFriends));
    }

    public function getAllInvitations():Vector.<FriendVO> {
        var _local2:FriendVO;
        var _local1:* = new Vector.<FriendVO>();
        for each (_local2 in this._invitations) {
            _local1.push(_local2);
        }
        _local1.sort(this.sortFriend);
        return (_local1);
    }

    public function removeFriend(_arg1:String):Boolean {
        var _local2:Object = this._friends[_arg1];
        if (_local2) {
            this.removeFromList(_local2.list, _arg1);
            this._friends[_arg1] = null;
            delete this._friends[_arg1];
            return (true);
        }
        return (false);
    }

    public function removeInvitation(_arg1:String):Boolean {
        if (this._invitations[_arg1] != null) {
            this._invitations[_arg1] = null;
            delete this._invitations[_arg1];
            return (true);
        }
        return (false);
    }

    private function removeFromList(_arg1:Vector.<FriendVO>, _arg2:String) {
        var _local3:FriendVO;
        var _local4:int;
        while (_local4 < _arg1.length) {
            _local3 = _arg1[_local4];
            if (_local3.getName() == _arg2) {
                _arg1.slice(_local4, 1);
                return;
            }
            _local4++;
        }
    }

    private function sortFriend(_arg1:FriendVO, _arg2:FriendVO):Number {
        if (_arg1.getName() < _arg2.getName()) {
            return (-1);
        }
        if (_arg1.getName() > _arg2.getName()) {
            return (1);
        }
        return (0);
    }

    private function serverNameDictionary():Dictionary {
        var _local2:Server;
        if (this._serverDict) {
            return (this._serverDict);
        }
        var _local1:Vector.<Server> = this.serverModel.getServers();
        this._serverDict = new Dictionary(true);
        for each (_local2 in _local1) {
            this._serverDict[_local2.address] = _local2.name;
        }
        return (this._serverDict);
    }

    private function starFilter(_arg1:int, _arg2:int, _arg3:XML):Boolean {
        return ((FameUtil.numAllTimeStars(_arg1, _arg2, _arg3) >= Parameters.data_.friendStarRequirement));
    }


}
}
