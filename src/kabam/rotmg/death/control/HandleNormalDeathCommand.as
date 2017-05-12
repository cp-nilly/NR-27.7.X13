package kabam.rotmg.death.control {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.parameters.Parameters;

import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.core.services.GetCharListTask;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.service.TrackingData;
import kabam.rotmg.core.signals.TrackEventSignal;
import kabam.rotmg.fame.control.ShowFameViewSignal;
import kabam.rotmg.fame.model.FameVO;
import kabam.rotmg.fame.model.SimpleFameVO;
import kabam.rotmg.messaging.impl.incoming.Death;

public class HandleNormalDeathCommand {

    [Inject]
    public var death:Death;
    [Inject]
    public var player:PlayerModel;
    [Inject]
    public var track:TrackEventSignal;
    [Inject]
    public var task:GetCharListTask;
    [Inject]
    public var showFame:ShowFameViewSignal;
    [Inject]
    public var monitor:TaskMonitor;
    private var fameVO:FameVO;


    public function execute():void {
        this.fameVO = new SimpleFameVO(this.death.accountId_, this.death.charId_);
        this.trackDeath();
        this.updateParameters();
        this.gotoFameView();
    }

    private function trackDeath():void {
        var _local1:SavedCharacter = this.player.getCharById(this.death.charId_);
        var _local2:int = ((_local1) ? _local1.level() : 0);
        var _local3:TrackingData = new TrackingData();
        _local3.category = "killedBy";
        _local3.action = this.death.killedBy_;
        _local3.value = _local2;
        this.track.dispatch(_local3);
    }

    private function updateParameters():void {
        Parameters.data_.needsRandomRealm = false;
        Parameters.save();
    }

    private function gotoFameView():void {
        if (this.player.getAccountId() == "") {
            this.gotoFameViewOnceDataIsLoaded();
        }
        else {
            this.showFame.dispatch(this.fameVO);
        }
    }

    private function gotoFameViewOnceDataIsLoaded():void {
        var _local1:TaskSequence = new TaskSequence();
        _local1.add(this.task);
        _local1.add(new DispatchSignalTask(this.showFame, this.fameVO));
        this.monitor.add(_local1);
        _local1.start();
    }


}
}
