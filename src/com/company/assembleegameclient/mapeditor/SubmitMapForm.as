package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.account.ui.CheckBoxField;
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;

import kabam.lib.json.JsonParser;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.editor.view.components.savedialog.TagsInputField;
import kabam.rotmg.fortune.components.TimerCallback;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

import ru.inspirit.net.MultipartURLLoader;

public class SubmitMapForm extends Frame {

    public static var cancel:Signal;

    var mapName:TextInputField;
    var descr:TextInputField;
    var tags:TagsInputField;
    var mapjm:String;
    var mapInfo:Object;
    var account:Account;
    var checkbox:CheckBoxField;

    public function SubmitMapForm(_arg1:String, _arg2:Object, _arg3:Account) {
        super("SubmitMapForm.Title", TextKey.FRAME_CANCEL, TextKey.WEB_CHANGE_PASSWORD_RIGHT, 300);
        cancel = new Signal();
        this.account = _arg3;
        this.mapjm = _arg1;
        this.mapInfo = _arg2;
        this.mapName = new TextInputField("Map Name");
        addTextInputField(this.mapName);
        this.tags = new TagsInputField("", 238, 50, true);
        addComponent(this.tags, 12);
        this.descr = new TextInputField("Description", false, 238, 100, 20, 0x0100, true);
        addTextInputField(this.descr);
        addSpace(35);
        this.checkbox = new CheckBoxField("Overwrite", true, 12);
        addCheckBox(this.checkbox);
        this.enableButtons();
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    public static function isInitialized():Boolean {
        return (!((cancel == null)));
    }


    private function disableButtons():void {
        rightButton_.removeEventListener(MouseEvent.CLICK, this.onSubmit);
        leftButton_.removeEventListener(MouseEvent.CLICK, this.onCancel);
    }

    private function enableButtons():void {
        rightButton_.addEventListener(MouseEvent.CLICK, this.onSubmit);
        leftButton_.addEventListener(MouseEvent.CLICK, this.onCancel);
    }

    private function onSubmit(_arg1:MouseEvent):void {
        this.disableButtons();
        this.mapName.clearError();
        var _local2:JsonParser = StaticInjectorContext.getInjector().getInstance(JsonParser);
        var _local3:Object = _local2.parse(this.mapjm);
        var _local4:int = _local3["width"];
        var _local5:int = _local3["height"];
        var _local6:MultipartURLLoader = new MultipartURLLoader();
        _local6.addVariable("guid", this.account.getUserId());
        _local6.addVariable("password", this.account.getPassword());
        _local6.addVariable("name", this.mapName.text());
        _local6.addVariable("description", this.descr.text());
        _local6.addVariable("width", _local4);
        _local6.addVariable("height", _local5);
        _local6.addVariable("mapjm", this.mapjm);
        _local6.addVariable("tags", this.tags.text());
        _local6.addVariable("totalObjects", this.mapInfo.numObjects);
        _local6.addVariable("totalTiles", this.mapInfo.numTiles);
        _local6.addFile(this.mapInfo.thumbnail, "foo.png", "thumbnail");
        _local6.addVariable("overwrite", ((this.checkbox.isChecked()) ? "on" : "off"));
        var _local7:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        var _local8 = (_local7.getAppEngineUrl(true) + "/ugc/save");
        this.enableButtons();
        var _local9:Object = {
            "name": this.mapName.text(),
            "description": this.descr.text(),
            "width": _local4,
            "height": _local5,
            "mapjm": this.mapjm,
            "tags": this.tags.text(),
            "totalObjects": this.mapInfo.numObjects,
            "totalTiles": this.mapInfo.numTiles,
            "thumbnail": this.mapInfo.thumbnail,
            "overwrite": ((this.checkbox.isChecked()) ? "on" : "off")
        };
        if (this.validated(_local9)) {
            _local6.addEventListener(Event.COMPLETE, this.onComplete);
            _local6.addEventListener(IOErrorEvent.IO_ERROR, this.onCompleteException);
            _local6.load(_local8);
        }
        else {
            this.enableButtons();
        }
    }

    private function onCompleteException(_arg1:IOErrorEvent):void {
        this.descr.setError("Exception. If persists, please contact dev team.");
        this.enableButtons();
    }

    private function onComplete(_arg1:Event):void {
        var _local3:Array;
        var _local4:String;
        var _local2:MultipartURLLoader = MultipartURLLoader(_arg1.target);
        if (_local2.loader.data == "<Success/>") {
            this.descr.setError("Success! Thank you!");
            new TimerCallback(2, this.onCancel);
        }
        else {
            _local3 = _local2.loader.data.match("<.*>(.*)</.*>");
            _local4 = (((_local3.length > 1)) ? _local3[1] : _local2.loader.data);
            this.descr.setError(_local4);
        }
        this.enableButtons();
    }

    private function onCancel(_arg1:MouseEvent = null):void {
        cancel.dispatch();
        if (parent) {
            parent.removeChild(this);
        }
    }

    private function onRemovedFromStage(_arg1:Event):void {
        if (rightButton_) {
            rightButton_.removeEventListener(MouseEvent.CLICK, this.onSubmit);
        }
        if (cancel) {
            cancel.removeAll();
            cancel = null;
        }
    }

    private function validated(_arg1:Object):Boolean {
        if ((((_arg1["name"].length < 6)) || ((_arg1["name"].length > 24)))) {
            this.mapName.setError("Map name length out of range (6-24 chars)");
            return (false);
        }
        if ((((_arg1["description"].length < 10)) || ((_arg1["description"].length > 250)))) {
            this.descr.setError("Description length out of range (10-250 chars)");
            return (false);
        }
        return (this.isValidMap());
    }

    private function isValidMap():Boolean {
        if (this.mapInfo.numExits < 1) {
            this.descr.setError("Must have at least one User Dungeon End region drawn in this dungeon. (tmp)");
            return (false);
        }
        if (this.mapInfo.numEntries < 1) {
            this.descr.setError("Must have at least one Spawn Region drawn in this dungeon. (tmp)");
            return (false);
        }
        return (true);
    }


}
}
