package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.objects.ImageFactory;
import com.company.assembleegameclient.ui.icons.IconButton;
import com.company.assembleegameclient.ui.icons.IconButtonFactory;
import com.company.ui.BaseSimpleText;
import com.company.util.GraphicsUtil;

import flash.display.Bitmap;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class TabStripView extends Sprite {

    public const tabSelected:Signal = new Signal(String);
    public const WIDTH:Number = 186;
    public const HEIGHT:Number = 153;
    private const tabSprite:Sprite = new Sprite();
    private const background:Sprite = new Sprite();
    private const containerSprite:Sprite = new Sprite();

    public var iconButtonFactory:IconButtonFactory;
    public var imageFactory:ImageFactory;
    private var _width:Number;
    private var _height:Number;
    public var tabs:Vector.<TabView>;
    private var contents:Vector.<Sprite>;
    public var currentTabIndex:int;
    public var friendsBtn:IconButton;

    public function TabStripView(_arg1:Number = 186, _arg2:Number = 153) {
        this.tabs = new Vector.<TabView>();
        this.contents = new Vector.<Sprite>();
        super();
        this._width = _arg1;
        this._height = _arg2;
        this.tabSprite.addEventListener(MouseEvent.CLICK, this.onTabClicked);
        addChild(this.tabSprite);
        this.drawBackground();
        addChild(this.containerSprite);
        this.containerSprite.y = TabConstants.TAB_TOP_OFFSET;
    }

    public function initFriendList(_arg1:ImageFactory, _arg2:IconButtonFactory, _arg3:Function):void {
        this.friendsBtn = _arg2.create(_arg1.getImageFromSet("lofiInterfaceBig", 13), "", TextKey.OPTIONS_FRIEND, "");
        this.friendsBtn.x = 160;
        this.friendsBtn.y = 6;
        this.friendsBtn.addEventListener(MouseEvent.CLICK, _arg3);
        addChild(this.friendsBtn);
    }

    private function onTabClicked(_arg1:MouseEvent):void {
        this.selectTab((_arg1.target.parent as TabView));
    }

    public function setSelectedTab(_arg1:uint):void {
        this.selectTab(this.tabs[_arg1]);
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

    public function drawBackground():void {
        var _local1:GraphicsSolidFill = new GraphicsSolidFill(TabConstants.BACKGROUND_COLOR, 1);
        var _local2:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        var _local3:Vector.<IGraphicsData> = new <IGraphicsData>[_local1, _local2, GraphicsUtil.END_FILL];
        GraphicsUtil.drawCutEdgeRect(0, 0, this._width, (this._height - TabConstants.TAB_TOP_OFFSET), 6, [1, 1, 1, 1], _local2);
        this.background.graphics.drawGraphicsData(_local3);
        this.background.y = TabConstants.TAB_TOP_OFFSET;
        addChild(this.background);
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

    public function addTab(_arg1:*, _arg2:Sprite):void {
        var _local4:TabView;
        var _local3:int = this.tabs.length;
        if ((_arg1 is Bitmap)) {
            _local4 = this.addIconTab(_local3, (_arg1 as Bitmap));
        }
        else {
            if ((_arg1 is BaseSimpleText)) {
                _local4 = this.addTextTab(_local3, (_arg1 as BaseSimpleText));
            }
        }
        this.tabs.push(_local4);
        this.tabSprite.addChild(_local4);
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

    public function removeTab():void {
    }

    private function addIconTab(_arg1:int, _arg2:Bitmap):TabIconView {
        var _local4:TabIconView;
        var _local3:Sprite = new TabBackground();
        _local4 = new TabIconView(_arg1, _local3, _arg2);
        _local4.x = (_arg1 * (_local3.width + TabConstants.PADDING));
        _local4.y = TabConstants.TAB_Y_POS;
        return (_local4);
    }

    private function addTextTab(_arg1:int, _arg2:BaseSimpleText):TabTextView {
        var _local3:Sprite = new TabBackground();
        var _local4:TabTextView = new TabTextView(_arg1, _local3, _arg2);
        _local4.x = (_arg1 * (_local3.width + TabConstants.PADDING));
        _local4.y = TabConstants.TAB_Y_POS;
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


}
}
