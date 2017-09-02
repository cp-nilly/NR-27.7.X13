package kabam.rotmg.ui.view {
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.ui.SoundIcon;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.transfer.view.KabamLoginView;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.model.EnvironmentData;
import kabam.rotmg.ui.view.components.DarkLayer;
import kabam.rotmg.ui.view.components.MapBackground;
import kabam.rotmg.ui.view.components.MenuOptionsBar;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class TitleView extends Sprite {

    public static const MIDDLE_OF_BOTTOM_BAND:Number = 589.45;

    static var TitleScreenGraphic:Class = TitleView_TitleScreenGraphic;
    public static var queueEmailConfirmation:Boolean = false;
    public static var queuePasswordPrompt:Boolean = false;
    public static var queuePasswordPromptFull:Boolean = false;
    public static var queueRegistrationPrompt:Boolean = false;
    public static var kabammigrateOpened:Boolean = false;

    private var versionText:TextFieldDisplayConcrete;
    private var copyrightText:TextFieldDisplayConcrete;
    private var menuOptionsBar:MenuOptionsBar;
    private var data:EnvironmentData;
    public var playClicked:Signal;
    public var serversClicked:Signal;
    public var accountClicked:Signal;
    public var legendsClicked:Signal;
    public var languagesClicked:Signal;
    public var supportClicked:Signal;
    public var kabamTransferClicked:Signal;
    public var editorClicked:Signal;
    public var textureEditorClicked:Signal;
    public var quitClicked:Signal;
    public var optionalButtonsAdded:Signal;
    private var migrateButton:TitleMenuOption;

    public function TitleView() {
        this.menuOptionsBar = this.makeMenuOptionsBar();
        this.optionalButtonsAdded = new Signal();
        super();
        addChild(new MapBackground());
        addChild(new DarkLayer());
        addChild(new TitleScreenGraphic());
        addChild(this.menuOptionsBar);
        addChild(new AccountScreen());
        this.makeChildren();
        addChild(new SoundIcon());
    }

    public function openKabamTransferView():void {
        var _local1:OpenDialogSignal = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
        _local1.dispatch(new KabamLoginView());
    }

    private function makeMenuOptionsBar():MenuOptionsBar {
        var _local1:TitleMenuOption = ButtonFactory.getPlayButton();
        var _local2:TitleMenuOption = ButtonFactory.getServersButton();
        var _local3:TitleMenuOption = ButtonFactory.getAccountButton();
        var _local4:TitleMenuOption = ButtonFactory.getLegendsButton();
        var _local5:TitleMenuOption = ButtonFactory.getSupportButton();
        var _local6:TitleMenuOption = ButtonFactory.getTextureEditorButton();
        this.playClicked = _local1.clicked;
        this.serversClicked = _local2.clicked;
        this.accountClicked = _local3.clicked;
        this.legendsClicked = _local4.clicked;
        this.supportClicked = _local5.clicked;
        this.textureEditorClicked = _local6.clicked;
        var _local7:MenuOptionsBar = new MenuOptionsBar();
        _local7.addButton(_local1, MenuOptionsBar.CENTER);
        _local7.addButton(_local2, MenuOptionsBar.LEFT);
        _local7.addButton(_local5, MenuOptionsBar.LEFT);
        _local7.addButton(_local3, MenuOptionsBar.RIGHT);
        _local7.addButton(_local4, MenuOptionsBar.RIGHT);
        _local7.addButton(_local6, MenuOptionsBar.LEFT);
        return (_local7);
    }

    private function makeChildren():void {
        this.versionText = this.makeText().setHTML(true).setAutoSize(TextFieldAutoSize.LEFT).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.versionText.y = MIDDLE_OF_BOTTOM_BAND;
        addChild(this.versionText);
        this.copyrightText = this.makeText().setAutoSize(TextFieldAutoSize.RIGHT).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.copyrightText.setStringBuilder(new LineBuilder().setParams(TextKey.COPYRIGHT));
        this.copyrightText.filters = [new DropShadowFilter(0, 0, 0)];
        this.copyrightText.x = 800;
        this.copyrightText.y = MIDDLE_OF_BOTTOM_BAND;
        addChild(this.copyrightText);
    }

    public function makeText():TextFieldDisplayConcrete {
        var _local1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(12).setColor(0x7F7F7F);
        _local1.filters = [new DropShadowFilter(0, 0, 0)];
        return (_local1);
    }

    public function initialize(_arg1:EnvironmentData):void {
        this.data = _arg1;
        this.updateVersionText();
        this.handleOptionalButtons();
    }

    public function putNoticeTagToOption(_arg1:TitleMenuOption, _arg2:String, _arg3:int = 14, _arg4:uint = 10092390, _arg5:Boolean = true):void {
        _arg1.createNoticeTag(_arg2, _arg3, _arg4, _arg5);
    }

    private function updateVersionText():void {
        this.versionText.setStringBuilder(new StaticStringBuilder(this.data.buildLabel));
    }

    private function handleOptionalButtons():void {
        ((this.data.canMapEdit) && (this.createEditorButton()));
        ((this.data.isDesktop) && (this.createQuitButton()));
        this.optionalButtonsAdded.dispatch();
    }

    private function createQuitButton():void {
        var _local1:TitleMenuOption = ButtonFactory.getQuitButton();
        this.menuOptionsBar.addButton(_local1, MenuOptionsBar.RIGHT);
        this.quitClicked = _local1.clicked;
    }

    private function createEditorButton():void {
        var _local1:TitleMenuOption = ButtonFactory.getEditorButton();
        this.menuOptionsBar.addButton(_local1, MenuOptionsBar.RIGHT);
        this.editorClicked = _local1.clicked;
    }

    private function makeMigrateButton():void {
        this.migrateButton = new TitleMenuOption("Want to migrate your Kabam.com account?", 16, false);
        this.migrateButton.setAutoSize(TextFieldAutoSize.CENTER);
        this.kabamTransferClicked = new NativeMappedSignal(this.migrateButton, MouseEvent.CLICK);
        this.migrateButton.setTextKey("Want to migrate your Kabam.com account?");
        this.migrateButton.x = 400;
        this.migrateButton.y = 500;
    }


}
}
