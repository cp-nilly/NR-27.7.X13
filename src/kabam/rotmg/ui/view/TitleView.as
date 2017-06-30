package kabam.rotmg.ui.view {
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.ui.SoundIcon;

import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.transfer.view.KabamLoginView;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.model.EnvironmentData;
import kabam.rotmg.ui.view.components.DarkLayer;
import kabam.rotmg.ui.view.components.MapBackground;
import kabam.rotmg.ui.view.components.MenuOptionsBar;

import org.osflash.signals.Signal;

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
    public var mapClicked:Signal;
    public var spriteClicked:Signal;
    public var quitClicked:Signal;
    public var optionalButtonsAdded:Signal;

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
        var openDialogSig:OpenDialogSignal = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
        openDialogSig.dispatch(new KabamLoginView());
    }

    private function makeMenuOptionsBar():MenuOptionsBar {
        var play:TitleMenuOption = ButtonFactory.getPlayButton();
        this.playClicked = play.clicked;

        var server:TitleMenuOption = ButtonFactory.getServersButton();
        this.serversClicked = server.clicked;

        var account:TitleMenuOption = ButtonFactory.getAccountButton();
        this.accountClicked = account.clicked;

        var legends:TitleMenuOption = ButtonFactory.getLegendsButton();
        this.legendsClicked = legends.clicked;

        var support:TitleMenuOption = ButtonFactory.getSupportButton();
        this.supportClicked = support.clicked;

        var bar:MenuOptionsBar = new MenuOptionsBar();
        bar.addButton(play, MenuOptionsBar.CENTER);
        bar.addButton(server, MenuOptionsBar.LEFT);
        bar.addButton(support, MenuOptionsBar.LEFT);
        bar.addButton(account, MenuOptionsBar.RIGHT);
        bar.addButton(legends, MenuOptionsBar.RIGHT);
        return bar;
    }

    private function makeChildren():void {
        this.versionText = this.makeText()
                .setHTML(true)
                .setAutoSize(TextFieldAutoSize.LEFT)
                .setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.versionText.y = MIDDLE_OF_BOTTOM_BAND;
        addChild(this.versionText);

        this.copyrightText = this.makeText()
                .setAutoSize(TextFieldAutoSize.RIGHT)
                .setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.copyrightText.x = 800;
        this.copyrightText.y = MIDDLE_OF_BOTTOM_BAND;
        addChild(this.copyrightText);
    }

    public function makeText():TextFieldDisplayConcrete {
        var txtField:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(12).setColor(0x7F7F7F);
        txtField.filters = [new DropShadowFilter(0, 0, 0)];
        return txtField;
    }

    public function initialize(_arg1:EnvironmentData):void {
        this.data = _arg1;
        this.updateVersionText();
        this.updateCopyrightText();
        this.handleOptionalButtons();
    }

    public function putNoticeTagToOption(menuOpt:TitleMenuOption, text:String, size:int = 14, color:uint = 10092390, bold:Boolean = true):void {
        menuOpt.createNoticeTag(text, size, color, bold);
    }

    private function updateVersionText():void {
        this.versionText.setStringBuilder(new StaticStringBuilder(this.data.buildLabel));
    }

    private function updateCopyrightText():void {
        this.copyrightText.setStringBuilder(new LineBuilder().setParams(this.data.copyrightLabel));
        this.copyrightText.filters = [new DropShadowFilter(0, 0, 0)];
    }

    private function handleOptionalButtons():void {
        this.data.canMapEdit && this.createMapButton();
        this.data.canSprite && this.createSpriteButton();
        this.data.isDesktop && this.createQuitButton();
        this.optionalButtonsAdded.dispatch();
    }

    private function createQuitButton():void {
        var menuOpt:TitleMenuOption = ButtonFactory.getQuitButton();
        this.menuOptionsBar.addButton(menuOpt, MenuOptionsBar.RIGHT);
        this.quitClicked = menuOpt.clicked;
    }

    private function createMapButton():void {
        var menuOpt:TitleMenuOption = ButtonFactory.getMapButton();
        this.menuOptionsBar.addButton(menuOpt, MenuOptionsBar.RIGHT);
        this.mapClicked = menuOpt.clicked;
    }

    private function createSpriteButton():void {
        var menuOpt:TitleMenuOption = ButtonFactory.getSpriteButton();
        this.menuOptionsBar.addButton(menuOpt, MenuOptionsBar.LEFT);
        this.spriteClicked = menuOpt.clicked;
    }


}
}
