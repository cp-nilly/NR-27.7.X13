package kabam.rotmg.friends.view {
import com.company.ui.BaseSimpleText;
import com.company.util.GraphicsUtil;

import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.game.view.components.TabBackground;
import kabam.rotmg.game.view.components.TabConstants;
import kabam.rotmg.game.view.components.TabTextView;
import kabam.rotmg.game.view.components.TabView;

import org.osflash.signals.Signal;

public class FriendTabView extends Sprite {

    public const tabSelected:Signal = new Signal(String);
    private const TAB_WIDTH:int = 120;
    private const TAB_HEIGHT:int = 30;
    private const tabSprite:Sprite = new Sprite();
    private const background:Sprite = new Sprite();
    private const containerSprite:Sprite = new Sprite();

    public var tabs:Vector.<TabView>;
    public var currentTabIndex:int;
    private var _width:Number;
    private var _height:Number;
    private var contents:Vector.<Sprite>;

    public function FriendTabView(_arg1:Number, _arg2:Number) {
        this.tabs = new Vector.<TabView>();
        this.contents = new Vector.<Sprite>();
        super();
        this._width = _arg1;
        this._height = _arg2;
        this.tabSprite.addEventListener(MouseEvent.CLICK, this.onTabClicked);
        addChild(this.tabSprite);
        this.drawBackground();
        addChild(this.containerSprite);
    }

    public function destroy():void {
        while (numChildren > 0) {
            this.removeChildAt((numChildren - 1));
        }
        this.tabSprite.removeEventListener(MouseEvent.CLICK, this.onTabClicked);
        this.tabs = null;
        this.contents = null;
    }

    public function addTab(_arg1:BaseSimpleText, _arg2:Sprite):void {
        var _local3:int = this.tabs.length;
        var _local4:TabView = this.addTextTab(_local3, (_arg1 as BaseSimpleText));
        this.tabs.push(_local4);
        this.tabSprite.addChild(_local4);
        _arg2.y = (this.TAB_HEIGHT + 5);
        this.contents.push(_arg2);
        this.containerSprite.addChild(_arg2);
        if (_local3 > 0) {
            _arg2.visible = false;
        }
        else {
            _local4.setSelected(true);
            this.showContent(0);
            this.tabSelected.dispatch(_arg2.name);
        }
    }

    public function clearTabs():void {
        var _local1:uint;
        this.currentTabIndex = 0;
        var _local2:uint = this.tabs.length;
        _local1 = 0;
        while (_local1 < _local2) {
            this.tabSprite.removeChild(this.tabs[_local1]);
            this.containerSprite.removeChild(this.contents[_local1]);
            _local1++;
        }
        this.tabs = new Vector.<TabView>();
        this.contents = new Vector.<Sprite>();
    }

    public function removeTab():void {
    }

    public function setSelectedTab(_arg1:uint):void {
        this.selectTab(this.tabs[_arg1]);
    }

    public function showTabBadget(_arg1:uint, _arg2:int):void {
        var _local3:TabView = this.tabs[_arg1];
        (_local3 as TabTextView).setBadge(_arg2);
    }

    private function onTabClicked(_arg1:MouseEvent):void {
        this.selectTab((_arg1.target.parent as TabView));
    }

    private function selectTab(_arg1:TabView):void {
        var _local2:TabView;
        if (_arg1) {
            _local2 = this.tabs[this.currentTabIndex];
            if (_local2.index != _arg1.index) {
                _local2.setSelected(false);
                _arg1.setSelected(true);
                this.showContent(_arg1.index);
                this.tabSelected.dispatch(this.contents[_arg1.index].name);
            }
        }
    }

    private function addTextTab(_arg1:int, _arg2:BaseSimpleText):TabTextView {
        var _local4:TabTextView;
        var _local3:Sprite = new TabBackground(this.TAB_WIDTH, this.TAB_HEIGHT);
        _local4 = new TabTextView(_arg1, _local3, _arg2);
        _local4.x = (_arg1 * (_arg2.width + 12));
        _local4.y = 4;
        return (_local4);
    }

    private function showContent(_arg1:int):void {
        var _local2:Sprite;
        var _local3:Sprite;
        if (_arg1 != this.currentTabIndex) {
            _local2 = this.contents[this.currentTabIndex];
            _local3 = this.contents[_arg1];
            _local2.visible = false;
            _local3.visible = true;
            this.currentTabIndex = _arg1;
        }
    }

    private function drawBackground():void {
        var _local1:GraphicsSolidFill = new GraphicsSolidFill(TabConstants.BACKGROUND_COLOR, 1);
        var _local2:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        var _local3:Vector.<IGraphicsData> = new <IGraphicsData>[_local1, _local2, GraphicsUtil.END_FILL];
        GraphicsUtil.drawCutEdgeRect(0, 0, this._width, (this._height - TabConstants.TAB_TOP_OFFSET), 6, [1, 1, 1, 1], _local2);
        this.background.graphics.drawGraphicsData(_local3);
        this.background.y = TabConstants.TAB_TOP_OFFSET;
        addChild(this.background);
    }


}
}
