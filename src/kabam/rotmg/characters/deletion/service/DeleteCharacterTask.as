package kabam.rotmg.characters.deletion.service {
import com.company.assembleegameclient.appengine.SavedCharacter;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.characters.model.CharacterModel;

public class DeleteCharacterTask extends BaseTask {

    [Inject]
    public var character:SavedCharacter;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var account:Account;
    [Inject]
    public var model:CharacterModel;


    override protected function startTask():void {
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/char/delete", this.getRequestPacket());
    }

    private function getRequestPacket():Object {
        var _local1:Object = this.account.getCredentials();
        _local1.charId = this.character.charId();
        _local1.reason = 1;
        return (_local1);
    }

    private function onComplete(_arg1:Boolean, _arg2:*):void {
        ((_arg1) && (this.updateUserData()));
        completeTask(_arg1, _arg2);
    }

    private function updateUserData():void {
        this.model.deleteCharacter(this.character.charId());
    }


}
}
