package kabam.rotmg.editor.services {
import com.adobe.images.PNGEncoder;

import flash.events.Event;
import flash.utils.ByteArray;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.editor.model.TextureData;

import ru.inspirit.net.MultipartURLLoader;

public class SaveTextureTask extends BaseTask {

    [Inject]
    public var account:Account;
    [Inject]
    public var data:TextureData;
    [Inject]
    public var setup:ApplicationSetup;


    override protected function startTask():void {
        var _local_1:MultipartURLLoader = new MultipartURLLoader();
        _local_1.addVariable("guid", this.account.getUserId());
        _local_1.addVariable("password", this.account.getPassword());
        _local_1.addVariable("secret", "");
        _local_1.addVariable("name", this.data.name);
        _local_1.addVariable("dataType", this.data.type);
        _local_1.addVariable("tags", this.data.tags);
        _local_1.addVariable("overwrite", "on");
        var _local_2:String = (this.setup.getAppEngineUrl(true) + "/picture/save");
        var _local_3:ByteArray = PNGEncoder.encode(this.data.bitmapData);
        _local_1.addFile(_local_3, "Foo.png", "data");
        _local_1.addEventListener(Event.COMPLETE, this.onSaveComplete);
        _local_1.load(_local_2);
    }

    private function onSaveComplete(_arg_1:Event):void {
        completeTask(true);
    }


}
}
