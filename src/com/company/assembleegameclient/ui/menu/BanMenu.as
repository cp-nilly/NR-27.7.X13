package com.company.assembleegameclient.ui.menu {
import flash.events.MouseEvent;
import flash.globalization.DateTimeFormatter;
import flash.globalization.LocaleID;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.messaging.impl.GameServerConnection;

import mx.utils.StringUtil;
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.game.AGameSprite;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import com.adobe.serialization.json.JSON;

class BanMenu extends Frame {
    public var gs_:AGameSprite;
    private var player:Player;
    private var banReasons:TextInputField;
    private var liftTime:TextInputField;

    function BanMenu(plr:Player) {
        this.player = plr;

        super("Ban options for player " + plr.name_,TextKey.FRAME_CANCEL,"Ban");
        this.banReasons = new TextInputField("Ban Reasons", false);
        addTextInputField(this.banReasons);
        addPlainText("");

        this.liftTime = new TextInputField("Ban lift time", false);
        var Time:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
        Time.setDateTimePattern("yyyy-MM-dd HH:mm:ss");
        this.liftTime.inputText_.text = Time.formatUTC(new Date());
        addTextInputField(this.liftTime);
        addPlainText("");
        addPlainText("Ban Lift Format:");
        addPlainText("yyyy-MM-dd HH:mm:ss");
        addPlainText("Timezone: UTC");
        addPlainText("Pernament Ban: -1");
        leftButton_.addEventListener(MouseEvent.CLICK, onCancel);
        rightButton_.addEventListener(MouseEvent.CLICK, this.onAction);
    }

    public static function onCancel(me:MouseEvent):void {
        StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal).dispatch();
    }

    private function onAction(me:MouseEvent):void {
        var BanDate:Date = null;
        var BanLiftTime:Number = NaN;
        var jsonString:String = null;
        if(!StringUtil.trim(this.banReasons.text())) {
            this.banReasons.setError("Please add a ban reason.");
            return;
        }
        if(isValidDate(this.liftTime.text()) && this.liftTime.text() != "-1") {
            BanDate = parseUTCDate(this.liftTime.text());
            BanLiftTime = Math.round(BanDate.getTime() / 1000);
            jsonString = com.adobe.serialization.json.JSON.encode({
                "accountId":this.player.accountId_,
                "banReasons":this.banReasons.text(),
                "banLiftTime":BanLiftTime
            });
            GameServerConnection.instance.playerText("/ban " + jsonString);
            StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal).dispatch();
        }
        this.liftTime.setError("Invalid date.");
    }

    private static function parseUTCDate(message:String):Date {
        var timeArray:Array = message.match(/(\d\d\d\d)-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)/);
        var date:Date = new Date();
        date.setUTCFullYear(int(timeArray[1]), int(timeArray[2]) - 1, int(timeArray[3]));
        date.setUTCHours(int(timeArray[4]), int(timeArray[5]), int(timeArray[6]),0);
        return date;
    }

    private static function isValidDate(time:String):Boolean {
        return time.match(/(\d\d\d\d)-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)/) != null;
    }
}
}
