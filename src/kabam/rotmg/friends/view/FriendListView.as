package kabam.rotmg.friends.view {
import com.company.assembleegameclient.account.ui.TextInputField;
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.assembleegameclient.ui.dialogs.DialogCloser;
import com.company.ui.BaseSimpleText;
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.friends.model.FriendConstant;
import kabam.rotmg.friends.model.FriendVO;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class FriendListView extends Sprite implements DialogCloser {

    public static const TEXT_WIDTH:int = 500;
    public static const TEXT_HEIGHT:int = 500;
    public static const LIST_ITEM_WIDTH:int = 490;
    public static const LIST_ITEM_HEIGHT:int = 40;

    private const closeButton:DialogCloseButton = PetsViewAssetFactory.returnCloseButton(TEXT_WIDTH);

    public var closeDialogSignal:Signal = new Signal();
    public var actionSignal = new Signal(String, String);
    public var tabSignal = new Signal(String);
    public var _tabView:FriendTabView;
    public var _w:int;
    public var _h:int;
    private var _friendTotalText:TextFieldDisplayConcrete;
    private var _friendDefaultText:TextFieldDisplayConcrete;
    private var _inviteDefaultText:TextFieldDisplayConcrete;
    private var _addButton:DeprecatedTextButton;
    private var _findButton:DeprecatedTextButton;
    private var _nameInput:TextInputField;
    private var _friendsContainer:FriendListContainer;
    private var _invitationsContainer:FriendListContainer;
    private var _currentServerName:String;
    private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0x333333, 1);
    private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
    private var lineStyle_:GraphicsStroke = new GraphicsStroke(2, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_);
    private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());

    private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[lineStyle_, backgroundFill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];

    public function FriendListView() {
        super();
    }

    public function init(_arg1:Vector.<FriendVO>, _arg2:Vector.<FriendVO>, _arg3:String):void {
        this._w = TEXT_WIDTH;
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this._tabView = new FriendTabView(TEXT_WIDTH, TEXT_HEIGHT);
        this._tabView.tabSelected.add(this.onTabClicked);
        addChild(this._tabView);
        this.createFriendTab();
        this.createInvitationsTab();
        addChild(this.closeButton);
        this.drawBackground();
        this._currentServerName = _arg3;
        this.seedData(_arg1, _arg2);
        this._tabView.setSelectedTab(0);
    }

    public function destroy():void {
        while (numChildren > 0) {
            this.removeChildAt((numChildren - 1));
        }
        this._addButton.removeEventListener(MouseEvent.CLICK, this.onAddFriendClicked);
        this._addButton = null;
        this._tabView.destroy();
        this._tabView = null;
        this._nameInput.removeEventListener(FocusEvent.FOCUS_IN, this.onFocusIn);
        this._nameInput = null;
        this._friendsContainer = null;
        this._invitationsContainer = null;
    }

    public function updateFriendTab(_arg1:Vector.<FriendVO>, _arg2:String):void {
        var _local3:FriendVO;
        var _local4:FListItem;
        var _local5:int;
        this._friendDefaultText.visible = (_arg1.length <= 0);
        _local5 = (this._friendsContainer.getTotal() - _arg1.length);
        while (_local5 > 0) {
            this._friendsContainer.removeChildAt((this._friendsContainer.getTotal() - 1));
            _local5--;
        }
        _local5 = 0;
        while (_local5 < this._friendsContainer.getTotal()) {
            _local3 = _arg1.pop();
            if (_local3 != null) {
                _local4 = (this._friendsContainer.getChildAt(_local5) as FListItem);
                _local4.update(_local3, _arg2);
            }
            _local5++;
        }
        for each (_local3 in _arg1) {
            _local4 = new FriendListItem(_local3, LIST_ITEM_WIDTH, LIST_ITEM_HEIGHT, _arg2);
            _local4.actionSignal.add(this.onListItemAction);
            _local4.x = 2;
            this._friendsContainer.addListItem(_local4);
        }
        _arg1.length = 0;
        _arg1 = null;
    }

    public function updateInvitationTab(_arg1:Vector.<FriendVO>):void {
        var _local2:FriendVO;
        var _local3:FListItem;
        var _local4:int;
        this._tabView.showTabBadget(1, _arg1.length);
        this._inviteDefaultText.visible = (_arg1.length == 0);
        _local4 = (this._invitationsContainer.getTotal() - _arg1.length);
        while (_local4 > 0) {
            this._invitationsContainer.removeChildAt((this._invitationsContainer.getTotal() - 1));
            _local4--;
        }
        _local4 = 0;
        while (_local4 < this._invitationsContainer.getTotal()) {
            _local2 = _arg1.pop();
            if (_local2 != null) {
                _local3 = (this._invitationsContainer.getChildAt(_local4) as FListItem);
                _local3.update(_local2, "");
            }
            _local4++;
        }
        for each (_local2 in _arg1) {
            _local3 = new InvitationListItem(_local2, LIST_ITEM_WIDTH, LIST_ITEM_HEIGHT);
            _local3.actionSignal.add(this.onListItemAction);
            this._invitationsContainer.addListItem(_local3);
        }
        _arg1.length = 0;
        _arg1 = null;
    }

    private function createFriendTab():void {
        var _local1:Sprite = new Sprite();
        _local1.name = FriendConstant.FRIEND_TAB;
        this._nameInput = new TextInputField(TextKey.FRIEND_ADD_TITLE, false);
        this._nameInput.x = 3;
        this._nameInput.y = 0;
        this._nameInput.addEventListener(FocusEvent.FOCUS_IN, this.onFocusIn);
        _local1.addChild(this._nameInput);
        this._addButton = new DeprecatedTextButton(14, TextKey.FRIEND_ADD_BUTTON, 110);
        this._addButton.y = 30;
        this._addButton.x = 253;
        this._addButton.addEventListener(MouseEvent.CLICK, this.onAddFriendClicked);
        _local1.addChild(this._addButton);
        this._findButton = new DeprecatedTextButton(14, TextKey.EDITOR_SEARCH, 110);
        this._findButton.y = 30;
        this._findButton.x = 380;
        this._findButton.addEventListener(MouseEvent.CLICK, this.onSearchFriendClicked);
        _local1.addChild(this._findButton);
        this._friendDefaultText = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        this._friendDefaultText.setStringBuilder(new LineBuilder().setParams(TextKey.FRIEND_DEFAULT_TEXT));
        this._friendDefaultText.x = 250;
        this._friendDefaultText.y = 200;
        _local1.addChild(this._friendDefaultText);
        this._friendTotalText = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        this._friendTotalText.x = 400;
        this._friendTotalText.y = 0;
        _local1.addChild(this._friendTotalText);
        this._friendsContainer = new FriendListContainer(TEXT_WIDTH, (TEXT_HEIGHT - 110));
        this._friendsContainer.x = 3;
        this._friendsContainer.y = 80;
        _local1.addChild(this._friendsContainer);
        var _local2:BaseSimpleText = new BaseSimpleText(18, 0xFFFFFF, false, 100, 26);
        _local2.setAlignment(TextFormatAlign.CENTER);
        _local2.text = FriendConstant.FRIEND_TAB;
        this._tabView.addTab(_local2, _local1);
    }

    private function createInvitationsTab():void {
        var _local1:Sprite;
        _local1 = new Sprite();
        _local1.name = FriendConstant.INVITE_TAB;
        this._invitationsContainer = new FriendListContainer(TEXT_WIDTH, (TEXT_HEIGHT - 30));
        this._invitationsContainer.x = 3;
        _local1.addChild(this._invitationsContainer);
        this._inviteDefaultText = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        this._inviteDefaultText.setStringBuilder(new LineBuilder().setParams(TextKey.FRIEND_INVITATION_DEFAULT_TEXT));
        this._inviteDefaultText.x = 250;
        this._inviteDefaultText.y = 200;
        _local1.addChild(this._inviteDefaultText);
        var _local2:BaseSimpleText = new BaseSimpleText(18, 0xFFFFFF, false, 100, 26);
        _local2.text = FriendConstant.INVITE_TAB;
        _local2.setAlignment(TextFormatAlign.CENTER);
        this._tabView.addTab(_local2, _local1);
    }

    private function seedData(_arg1:Vector.<FriendVO>, _arg2:Vector.<FriendVO>):void {
        this._friendTotalText.setStringBuilder(new LineBuilder().setParams(TextKey.FRIEND_TOTAL, {"total": _arg1.length}));
        this.updateFriendTab(_arg1, this._currentServerName);
        this.updateInvitationTab(_arg2);
    }

    private function onTabClicked(_arg1:String):void {
        this.tabSignal.dispatch(_arg1);
    }

    public function getCloseSignal():Signal {
        return (this.closeDialogSignal);
    }

    public function updateInput(_arg1:String, _arg2:Object = null):void {
        this._nameInput.setError(_arg1, _arg2);
    }

    private function onFocusIn(_arg1:FocusEvent):void {
        this._nameInput.clearText();
        this._nameInput.clearError();
        this.actionSignal.dispatch(FriendConstant.SEARCH, this._nameInput.text());
    }

    private function onAddFriendClicked(_arg1:MouseEvent):void {
        this.actionSignal.dispatch(FriendConstant.INVITE, this._nameInput.text());
    }

    private function onSearchFriendClicked(_arg1:MouseEvent):void {
        this.actionSignal.dispatch(FriendConstant.SEARCH, this._nameInput.text());
    }

    private function onListItemAction(_arg1:String, _arg2:String):void {
        this.actionSignal.dispatch(_arg1, _arg2);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.destroy();
    }

    private function drawBackground():void {
        this._h = (TEXT_HEIGHT + 8);
        x = ((800 / 2) - (this._w / 2));
        y = ((600 / 2) - (this._h / 2));
        graphics.clear();
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(-6, -6, (this._w + 12), (this._h + 12), 4, [1, 1, 1, 1], this.path_);
        graphics.drawGraphicsData(this.graphicsData_);
    }


}
}
