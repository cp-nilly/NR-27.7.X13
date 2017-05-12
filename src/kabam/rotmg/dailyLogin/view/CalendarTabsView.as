package kabam.rotmg.dailyLogin.view {
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.geom.Rectangle;

import kabam.rotmg.dailyLogin.config.CalendarSettings;

public class CalendarTabsView extends Sprite {

    private var fill_:GraphicsSolidFill;
    private var fillTransparent_:GraphicsSolidFill;
    private var lineStyle_:GraphicsStroke;
    private var path_:GraphicsPath;
    private var graphicsDataBackgroundTransparent:Vector.<IGraphicsData>;
    private var modalRectangle:Rectangle;
    private var tabs:Vector.<CalendarTabButton>;
    private var calendar:CalendarView;

    public function CalendarTabsView() {
        this.fill_ = new GraphicsSolidFill(0x363636, 1);
        this.fillTransparent_ = new GraphicsSolidFill(0x363636, 0);
        this.lineStyle_ = new GraphicsStroke(CalendarSettings.BOX_BORDER, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, new GraphicsSolidFill(0xFFFFFF));
        this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        this.graphicsDataBackgroundTransparent = new <IGraphicsData>[this.lineStyle_, this.fillTransparent_, this.path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        super();
    }

    public function init(_arg1:Rectangle):void {
        this.modalRectangle = _arg1;
        this.tabs = new Vector.<CalendarTabButton>();
    }

    public function addCalendar(_arg1:String, _arg2:String, _arg3:String):CalendarTabButton {
        var _local4:CalendarTabButton;
        _local4 = new CalendarTabButton(_arg1, _arg3, _arg2, CalendarTabButton.STATE_IDLE, this.tabs.length);
        this.addChild(_local4);
        _local4.x = ((CalendarSettings.TABS_WIDTH - 1) * this.tabs.length);
        this.tabs.push(_local4);
        return (_local4);
    }

    public function selectTab(_arg1:String):void {
        var _local2:CalendarTabButton;
        for each (_local2 in this.tabs) {
            if (_local2.calendarType == _arg1) {
                _local2.state = CalendarTabButton.STATE_SELECTED;
            }
            else {
                _local2.state = CalendarTabButton.STATE_IDLE;
            }
        }
        if (this.calendar) {
            removeChild(this.calendar);
        }
        this.calendar = new CalendarView();
        addChild(this.calendar);
        this.calendar.x = CalendarSettings.DAILY_LOGIN_TABS_PADDING;
    }

    public function drawTabs() {
        this.drawBorder();
    }

    private function drawBorder():void {
        var _local1:Sprite = new Sprite();
        this.drawRectangle(_local1, this.modalRectangle.width, this.modalRectangle.height);
        addChild(_local1);
        _local1.y = CalendarSettings.TABS_HEIGHT;
    }

    private function drawRectangle(_arg1:Sprite, _arg2:int, _arg3:int):void {
        _arg1.addChild(CalendarDayBox.drawRectangleWithCuts([0, 0, 1, 1], _arg2, _arg3, 0x363636, 1, this.graphicsDataBackgroundTransparent, this.path_));
    }


}
}
