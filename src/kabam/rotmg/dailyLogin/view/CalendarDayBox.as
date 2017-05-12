package kabam.rotmg.dailyLogin.view {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.GraphicsUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.assets.services.IconFactory;
import kabam.rotmg.dailyLogin.config.CalendarSettings;
import kabam.rotmg.dailyLogin.model.CalendarDayModel;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class CalendarDayBox extends Sprite {

    private var fill_:GraphicsSolidFill;
    private var fillCurrent_:GraphicsSolidFill;
    private var fillBlack_:GraphicsSolidFill;
    private var lineStyle_:GraphicsStroke;
    private var path_:GraphicsPath;
    private var graphicsDataBackground:Vector.<IGraphicsData>;
    private var graphicsDataBackgroundCurrent:Vector.<IGraphicsData>;
    private var graphicsDataClaimedOverlay:Vector.<IGraphicsData>;
    public var day:CalendarDayModel;
    private var redDot:Bitmap;
    private var boxCuts:Array;

    public function CalendarDayBox(_arg1:CalendarDayModel, _arg2:int, _arg3:Boolean) {
        var _local6:ItemTileRenderer;
        var _local7:Bitmap;
        var _local8:BitmapData;
        var _local9:TextFieldDisplayConcrete;
        this.fill_ = new GraphicsSolidFill(0x363636, 1);
        this.fillCurrent_ = new GraphicsSolidFill(4889165, 1);
        this.fillBlack_ = new GraphicsSolidFill(0, 0.7);
        this.lineStyle_ = new GraphicsStroke(CalendarSettings.BOX_BORDER, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, new GraphicsSolidFill(0xFFFFFF));
        this.path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        this.graphicsDataBackground = new <IGraphicsData>[this.lineStyle_, this.fill_, this.path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        this.graphicsDataBackgroundCurrent = new <IGraphicsData>[this.lineStyle_, this.fillCurrent_, this.path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        this.graphicsDataClaimedOverlay = new <IGraphicsData>[this.lineStyle_, this.fillBlack_, this.path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE];
        super();
        this.day = _arg1;
        var _local4:int = Math.ceil((_arg1.dayNumber / CalendarSettings.NUMBER_OF_COLUMNS));
        var _local5:int = Math.ceil((_arg2 / CalendarSettings.NUMBER_OF_COLUMNS));
        if (_arg1.dayNumber == 1) {
            if (_local5 == 1) {
                this.boxCuts = [1, 0, 0, 1];
            }
            else {
                this.boxCuts = [1, 0, 0, 0];
            }
        }
        else {
            if (_arg1.dayNumber == _arg2) {
                if (_local5 == 1) {
                    this.boxCuts = [0, 1, 1, 0];
                }
                else {
                    this.boxCuts = [0, 0, 1, 0];
                }
            }
            else {
                if ((((_local4 == 1)) && (((_arg1.dayNumber % CalendarSettings.NUMBER_OF_COLUMNS) == 0)))) {
                    this.boxCuts = [0, 1, 0, 0];
                }
                else {
                    if ((((_local4 == _local5)) && ((((_arg1.dayNumber - 1) % CalendarSettings.NUMBER_OF_COLUMNS) == 0)))) {
                        this.boxCuts = [0, 0, 0, 1];
                    }
                    else {
                        this.boxCuts = [0, 0, 0, 0];
                    }
                }
            }
        }
        this.drawBackground(this.boxCuts, _arg3);
        if ((((_arg1.gold == 0)) && ((_arg1.itemID > 0)))) {
            _local6 = new ItemTileRenderer(_arg1.itemID);
            addChild(_local6);
            _local6.x = Math.round((CalendarSettings.BOX_WIDTH / 2));
            _local6.y = Math.round((CalendarSettings.BOX_HEIGHT / 2));
        }
        if (_arg1.gold > 0) {
            _local7 = new Bitmap();
            _local7.bitmapData = IconFactory.makeCoin(80);
            addChild(_local7);
            _local7.x = Math.round(((CalendarSettings.BOX_WIDTH / 2) - (_local7.width / 2)));
            _local7.y = Math.round(((CalendarSettings.BOX_HEIGHT / 2) - (_local7.height / 2)));
        }
        this.displayDayNumber(_arg1.dayNumber);
        if (_arg1.claimKey != "") {
            _local8 = AssetLibrary.getImageFromSet("lofiInterface", 52);
            _local8.colorTransform(new Rectangle(0, 0, _local8.width, _local8.height), CalendarSettings.GREEN_COLOR_TRANSFORM);
            _local8 = TextureRedrawer.redraw(_local8, 40, true, 0);
            this.redDot = new Bitmap(_local8);
            this.redDot.x = ((CalendarSettings.BOX_WIDTH - Math.round((this.redDot.width / 2))) - 10);
            this.redDot.y = (-(Math.round((this.redDot.width / 2))) + 10);
            addChild(this.redDot);
        }
        if ((((_arg1.quantity > 1)) || ((_arg1.gold > 0)))) {
            _local9 = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF).setTextWidth(CalendarSettings.BOX_WIDTH).setAutoSize(TextFieldAutoSize.RIGHT);
            _local9.setStringBuilder(new StaticStringBuilder(("x" + (((_arg1.gold > 0)) ? _arg1.gold.toString() : _arg1.quantity.toString()))));
            _local9.y = (CalendarSettings.BOX_HEIGHT - 18);
            _local9.x = -2;
            addChild(_local9);
        }
        if (_arg1.isClaimed) {
            this.markAsClaimed();
        }
    }

    public static function drawRectangleWithCuts(_arg1:Array, _arg2:int, _arg3:int, _arg4:uint, _arg5:Number, _arg6:Vector.<IGraphicsData>, _arg7:GraphicsPath):Sprite {
        var _local8:Shape = new Shape();
        var _local9:Shape = new Shape();
        var _local10:Sprite = new Sprite();
        _local10.addChild(_local8);
        _local10.addChild(_local9);
        GraphicsUtil.clearPath(_arg7);
        GraphicsUtil.drawCutEdgeRect(0, 0, _arg2, _arg3, 4, _arg1, _arg7);
        _local8.graphics.clear();
        _local8.graphics.drawGraphicsData(_arg6);
        var _local11:GraphicsSolidFill = new GraphicsSolidFill(_arg4, _arg5);
        GraphicsUtil.clearPath(_arg7);
        var _local12:Vector.<IGraphicsData> = new <IGraphicsData>[_local11, _arg7, GraphicsUtil.END_FILL];
        GraphicsUtil.drawCutEdgeRect(0, 0, _arg2, _arg3, 4, _arg1, _arg7);
        _local9.graphics.drawGraphicsData(_local12);
        _local9.cacheAsBitmap = true;
        _local9.visible = false;
        return (_local10);
    }


    public function getDay():CalendarDayModel {
        return (this.day);
    }

    public function markAsClaimed():void {
        if (((this.redDot) && (this.redDot.parent))) {
            removeChild(this.redDot);
        }
        var _local1:BitmapData = AssetLibrary.getImageFromSet("lofiInterfaceBig", 11);
        _local1 = TextureRedrawer.redraw(_local1, 60, true, 2997032);
        var _local2:Bitmap = new Bitmap(_local1);
        _local2.x = Math.round(((CalendarSettings.BOX_WIDTH - _local2.width) / 2));
        _local2.y = Math.round(((CalendarSettings.BOX_HEIGHT - _local2.height) / 2));
        var _local3:Sprite = drawRectangleWithCuts(this.boxCuts, CalendarSettings.BOX_WIDTH, CalendarSettings.BOX_HEIGHT, 0, 1, this.graphicsDataClaimedOverlay, this.path_);
        addChild(_local3);
        addChild(_local2);
    }

    private function displayDayNumber(_arg1:int):void {
        var _local2:TextFieldDisplayConcrete;
        _local2 = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(CalendarSettings.BOX_WIDTH);
        _local2.setBold(true);
        _local2.setStringBuilder(new StaticStringBuilder(_arg1.toString()));
        _local2.x = 4;
        _local2.y = 4;
        addChild(_local2);
    }

    public function drawBackground(_arg1:Array, _arg2:Boolean):void {
        addChild(drawRectangleWithCuts(_arg1, CalendarSettings.BOX_WIDTH, CalendarSettings.BOX_HEIGHT, 0x363636, 1, ((_arg2) ? this.graphicsDataBackgroundCurrent : this.graphicsDataBackground), this.path_));
    }


}
}
