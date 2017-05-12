package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.account.ui.CheckBoxField;
import com.company.assembleegameclient.account.ui.TextInputField;
import com.company.assembleegameclient.editor.CommandEvent;
import com.company.assembleegameclient.editor.CommandList;
import com.company.assembleegameclient.editor.CommandQueue;
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.RegionLibrary;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.ui.DeprecatedClickableText;
import com.company.assembleegameclient.ui.dropdown.DropDown;
import com.company.util.IntPoint;
import com.company.util.SpriteUtil;
import com.hurlant.util.Base64;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.text.TextFieldAutoSize;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import kabam.lib.json.JsonParser;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.ui.view.components.ScreenBase;

import net.hires.debug.Stats;

public class EditingScreen extends Sprite {

    private static const MAP_Y:int = ((600 - MEMap.SIZE) - 10);//78
    public static const stats_:Stats = new Stats();

    public var commandMenu_:MECommandMenu;
    private var commandQueue_:CommandQueue;
    public var meMap_:MEMap;
    public var infoPane_:InfoPane;
    public var chooserDropDown_:DropDown;
    public var mapSizeDropDown_:DropDown;
    public var choosers_:Dictionary;
    public var groundChooser_:GroundChooser;
    public var objChooser_:ObjectChooser;
    public var enemyChooser_:EnemyChooser;
    public var object3DChooser_:Object3DChooser;
    public var wallChooser_:WallChooser;
    public var allObjChooser_:AllObjectChooser;
    public var regionChooser_:RegionChooser;
    public var dungeonChooser_:DungeonChooser;
    public var search:TextInputField;
    public var filter:Filter;
    public var returnButton_:TitleMenuOption;
    public var chooser_:Chooser;
    public var filename_:String = null;
    public var checkBoxArray:Array;
    public var showAllBtn:DeprecatedClickableText;
    public var hideAllBtn:DeprecatedClickableText;
    private var json:JsonParser;
    private var pickObjHolder:Sprite;
    private var tilesBackup:Vector.<METile>;
    private var loadedFile_:FileReference = null;

    public function EditingScreen() {
        var _local3:int;
        super();
        addChild(new ScreenBase());
        this.json = StaticInjectorContext.getInjector().getInstance(JsonParser);
        this.commandMenu_ = new MECommandMenu();
        this.commandMenu_.x = 15;
        this.commandMenu_.y = (MAP_Y - 60);
        this.commandMenu_.addEventListener(CommandEvent.UNDO_COMMAND_EVENT, this.onUndo);
        this.commandMenu_.addEventListener(CommandEvent.REDO_COMMAND_EVENT, this.onRedo);
        this.commandMenu_.addEventListener(CommandEvent.CLEAR_COMMAND_EVENT, this.onClear);
        this.commandMenu_.addEventListener(CommandEvent.LOAD_COMMAND_EVENT, this.onLoad);
        this.commandMenu_.addEventListener(CommandEvent.SAVE_COMMAND_EVENT, this.onSave);
        this.commandMenu_.addEventListener(CommandEvent.SUBMIT_COMMAND_EVENT, this.onSubmit);
        this.commandMenu_.addEventListener(CommandEvent.TEST_COMMAND_EVENT, this.onTest);
        this.commandMenu_.addEventListener(CommandEvent.SELECT_COMMAND_EVENT, this.onMenuSelect);
        addChild(this.commandMenu_);
        this.commandQueue_ = new CommandQueue();
        this.meMap_ = new MEMap();
        this.meMap_.addEventListener(TilesEvent.TILES_EVENT, this.onTilesEvent);
        this.meMap_.x = ((800 / 2) - (MEMap.SIZE / 2));
        this.meMap_.y = MAP_Y;
        addChild(this.meMap_);
        this.infoPane_ = new InfoPane(this.meMap_);
        this.infoPane_.x = 4;
        this.infoPane_.y = ((600 - InfoPane.HEIGHT) - 10);
        addChild(this.infoPane_);
        this.chooserDropDown_ = new DropDown(GroupDivider.GROUP_LABELS, Chooser.WIDTH, 26);
        addChild(this.chooserDropDown_);
        this.chooserDropDown_.x = ((this.meMap_.x + MEMap.SIZE) + 4);
        this.chooserDropDown_.y = ((MAP_Y - this.chooserDropDown_.height) - 4);
        this.chooserDropDown_.addEventListener(Event.CHANGE, this.onDropDownChange);
        var _local1:Vector.<String> = new <String>[];
        var _local2:Number = MEMap.MAX_ALLOWED_SQUARES;
        while (_local2 >= 64) {
            _local1.push(((_local2 + "x") + _local2));
            _local2 = (_local2 / 2);
        }
        this.mapSizeDropDown_ = new DropDown(_local1, Chooser.WIDTH, 26);
        this.mapSizeDropDown_.setValue(((MEMap.NUM_SQUARES + "x") + MEMap.NUM_SQUARES));
        this.mapSizeDropDown_.x = ((this.chooserDropDown_.x - this.chooserDropDown_.width) - 4);
        this.mapSizeDropDown_.y = this.chooserDropDown_.y;
        this.mapSizeDropDown_.addEventListener(Event.CHANGE, this.onDropDownSizeChange);
        addChild(this.mapSizeDropDown_);
        this.createCheckboxes();
        this.filter = new Filter();
        this.filter.x = ((this.meMap_.x + MEMap.SIZE) + 4);
        this.filter.y = MAP_Y;
        addChild(this.filter);
        this.filter.addEventListener(Event.CHANGE, this.onFilterChange);
        this.filter.enableDropDownFilter(true);
        this.filter.enableValueFilter(false);
        this.returnButton_ = new TitleMenuOption("Screens.back", 18, false);
        this.returnButton_.setAutoSize(TextFieldAutoSize.RIGHT);
        this.returnButton_.x = ((this.chooserDropDown_.x + this.chooserDropDown_.width) - 7);
        this.returnButton_.y = 2;
        addChild(this.returnButton_);
        GroupDivider.divideObjects();
        this.choosers_ = new Dictionary(true);
        _local3 = ((MAP_Y + this.mapSizeDropDown_.height) + 50);
        this.groundChooser_ = new GroundChooser();
        this.groundChooser_.x = this.chooserDropDown_.x;
        this.groundChooser_.y = _local3;
        this.choosers_[GroupDivider.GROUP_LABELS[0]] = this.groundChooser_;
        this.objChooser_ = new ObjectChooser();
        this.objChooser_.x = this.chooserDropDown_.x;
        this.objChooser_.y = _local3;
        this.choosers_[GroupDivider.GROUP_LABELS[1]] = this.objChooser_;
        this.enemyChooser_ = new EnemyChooser();
        this.enemyChooser_.x = this.chooserDropDown_.x;
        this.enemyChooser_.y = _local3;
        this.choosers_[GroupDivider.GROUP_LABELS[2]] = this.enemyChooser_;
        this.wallChooser_ = new WallChooser();
        this.wallChooser_.x = this.chooserDropDown_.x;
        this.wallChooser_.y = _local3;
        this.choosers_[GroupDivider.GROUP_LABELS[3]] = this.wallChooser_;
        this.object3DChooser_ = new Object3DChooser();
        this.object3DChooser_.x = this.chooserDropDown_.x;
        this.object3DChooser_.y = _local3;
        this.choosers_[GroupDivider.GROUP_LABELS[4]] = this.object3DChooser_;
        this.allObjChooser_ = new AllObjectChooser();
        this.allObjChooser_.x = this.chooserDropDown_.x;
        this.allObjChooser_.y = _local3;
        this.choosers_[GroupDivider.GROUP_LABELS[5]] = this.allObjChooser_;
        this.regionChooser_ = new RegionChooser();
        this.regionChooser_.x = this.chooserDropDown_.x;
        this.regionChooser_.y = _local3;
        this.choosers_[GroupDivider.GROUP_LABELS[6]] = this.regionChooser_;
        this.dungeonChooser_ = new DungeonChooser();
        this.dungeonChooser_.x = this.chooserDropDown_.x;
        this.dungeonChooser_.y = _local3;
        this.choosers_[GroupDivider.GROUP_LABELS[7]] = this.dungeonChooser_;
        this.chooser_ = this.groundChooser_;
        addChild(this.groundChooser_);
        this.chooserDropDown_.setIndex(0);
    }

    private function createCheckboxes():void {
        var _local2:CheckBoxField;
        this.checkBoxArray = new Array();
        var _local1:* = new DeprecatedClickableText(14, true, "(Show All)");
        _local1.buttonMode = true;
        _local1.x = (this.mapSizeDropDown_.x - 380);
        _local1.y = (this.mapSizeDropDown_.y - 20);
        _local1.setAutoSize(TextFieldAutoSize.LEFT);
        _local1.addEventListener(MouseEvent.CLICK, this.onCheckBoxUpdated);
        addChild(_local1);
        _local2 = new CheckBoxField("Objects", true);
        _local2.x = (_local1.x + 80);
        _local2.y = (this.mapSizeDropDown_.y - 20);
        _local2.scaleX = (_local2.scaleY = 0.8);
        _local2.addEventListener(MouseEvent.CLICK, this.onCheckBoxUpdated);
        addChild(_local2);
        var _local3:* = new DeprecatedClickableText(14, true, "(Hide All)");
        _local3.buttonMode = true;
        _local3.x = (this.mapSizeDropDown_.x - 380);
        _local3.y = (this.mapSizeDropDown_.y + 8);
        _local3.setAutoSize(TextFieldAutoSize.LEFT);
        _local3.addEventListener(MouseEvent.CLICK, this.onCheckBoxUpdated);
        addChild(_local3);
        var _local4:CheckBoxField = new CheckBoxField("Regions", true);
        _local4.x = (_local1.x + 80);
        _local4.y = (this.mapSizeDropDown_.y + 8);
        _local4.scaleX = (_local4.scaleY = 0.8);
        _local4.addEventListener(MouseEvent.CLICK, this.onCheckBoxUpdated);
        addChild(_local4);
        this.checkBoxArray.push(_local1);
        this.checkBoxArray.push(_local2);
        this.checkBoxArray.push(_local4);
        this.checkBoxArray.push(_local3);
    }

    private function setSearch(_arg1:String):void {
        this.filter.removeEventListener(Event.CHANGE, this.onFilterChange);
        this.filter.setSearch(_arg1);
        this.filter.addEventListener(Event.CHANGE, this.onFilterChange);
    }

    private function onFilterChange(_arg1:Event):void {
        switch (this.chooser_) {
            case this.groundChooser_:
                this.groundChooser_.reloadObjects(this.filter.searchStr, this.filter.filterType);
                return;
            case this.objChooser_:
                this.objChooser_.reloadObjects(this.filter.searchStr);
                return;
            case this.enemyChooser_:
                this.enemyChooser_.reloadObjects(this.filter.searchStr, this.filter.filterType, this.filter.minValue, this.filter.maxValue);
                return;
            case this.wallChooser_:
                this.wallChooser_.reloadObjects(this.filter.searchStr);
                return;
            case this.object3DChooser_:
                this.object3DChooser_.reloadObjects(this.filter.searchStr);
                return;
            case this.allObjChooser_:
                this.allObjChooser_.reloadObjects(this.filter.searchStr);
                return;
            case this.regionChooser_:
                return;
            case this.dungeonChooser_:
                this.dungeonChooser_.reloadObjects(this.filter.dungeon, this.filter.searchStr);
                return;
        }
    }

    private function onCheckBoxUpdated(_arg1:MouseEvent):void {
        var _local2:CheckBoxField;
        switch (_arg1.currentTarget) {
            case this.checkBoxArray[0]:
                this.meMap_.ifShowGroundLayer = true;
                this.meMap_.ifShowObjectLayer = true;
                this.meMap_.ifShowRegionLayer = true;
                (this.checkBoxArray[Layer.OBJECT] as CheckBoxField).setChecked();
                (this.checkBoxArray[Layer.REGION] as CheckBoxField).setChecked();
                break;
            case this.checkBoxArray[Layer.OBJECT]:
                _local2 = (_arg1.currentTarget as CheckBoxField);
                this.meMap_.ifShowObjectLayer = _local2.isChecked();
                break;
            case this.checkBoxArray[Layer.REGION]:
                _local2 = (_arg1.currentTarget as CheckBoxField);
                this.meMap_.ifShowRegionLayer = _local2.isChecked();
                break;
            case this.checkBoxArray[3]:
                this.meMap_.ifShowGroundLayer = false;
                this.meMap_.ifShowObjectLayer = false;
                this.meMap_.ifShowRegionLayer = false;
                (this.checkBoxArray[Layer.OBJECT] as CheckBoxField).setUnchecked();
                (this.checkBoxArray[Layer.REGION] as CheckBoxField).setUnchecked();
                break;
        }
        this.meMap_.draw();
    }

    private function onTilesEvent(_arg1:TilesEvent):void {
        var _local2:IntPoint;
        var _local3:METile;
        var _local4:int;
        var _local5:String;
        var _local6:String;
        var _local7:EditTileProperties;
        var _local8:Vector.<METile>;
        var _local9:Bitmap;
        var _local10:uint;
        _local2 = _arg1.tiles_[0];
        switch (this.commandMenu_.getCommand()) {
            case MECommandMenu.DRAW_COMMAND:
                this.addModifyCommandList(_arg1.tiles_, this.chooser_.layer_, this.chooser_.selectedType());
                break;
            case MECommandMenu.ERASE_COMMAND:
                this.addModifyCommandList(_arg1.tiles_, this.chooser_.layer_, -1);
                break;
            case MECommandMenu.SAMPLE_COMMAND:
                _local4 = this.meMap_.getType(_local2.x_, _local2.y_, this.chooser_.layer_);
                if (_local4 == -1) {
                    return;
                }
                _local5 = GroupDivider.getCategoryByType(_local4, this.chooser_.layer_);
                if (_local5 == "") break;
                this.chooser_ = this.choosers_[_local5];
                this.chooserDropDown_.setValue(_local5);
                this.chooser_.setSelectedType(_local4);
                this.commandMenu_.setCommand(MECommandMenu.DRAW_COMMAND);
                break;
            case MECommandMenu.EDIT_COMMAND:
                _local6 = this.meMap_.getObjectName(_local2.x_, _local2.y_);
                _local7 = new EditTileProperties(_arg1.tiles_, _local6);
                _local7.addEventListener(Event.COMPLETE, this.onEditComplete);
                addChild(_local7);
                break;
            case MECommandMenu.CUT_COMMAND:
                this.tilesBackup = new Vector.<METile>();
                _local8 = new Vector.<METile>();
                for each (_local2 in _arg1.tiles_) {
                    _local3 = this.meMap_.getTile(_local2.x_, _local2.y_);
                    if (_local3 != null) {
                        _local3 = _local3.clone();
                    }
                    this.tilesBackup.push(_local3);
                    _local8.push(null);
                }
                this.addPasteCommandList(_arg1.tiles_, _local8);
                this.meMap_.freezeSelect();
                this.commandMenu_.setCommand(MECommandMenu.PASTE_COMMAND);
                break;
            case MECommandMenu.COPY_COMMAND:
                this.tilesBackup = new Vector.<METile>();
                for each (_local2 in _arg1.tiles_) {
                    _local3 = this.meMap_.getTile(_local2.x_, _local2.y_);
                    if (_local3 != null) {
                        _local3 = _local3.clone();
                    }
                    this.tilesBackup.push(_local3);
                }
                this.meMap_.freezeSelect();
                this.commandMenu_.setCommand(MECommandMenu.PASTE_COMMAND);
                break;
            case MECommandMenu.PASTE_COMMAND:
                this.addPasteCommandList(_arg1.tiles_, this.tilesBackup);
                break;
            case MECommandMenu.PICK_UP_COMMAND:
                _local3 = this.meMap_.getTile(_local2.x_, _local2.y_);
                if (((!((_local3 == null))) && (!((_local3.types_[Layer.OBJECT] == -1))))) {
                    _local9 = new Bitmap(ObjectLibrary.getTextureFromType(_local3.types_[Layer.OBJECT]));
                    this.pickObjHolder = new Sprite();
                    this.pickObjHolder.addChild(_local9);
                    this.pickObjHolder.startDrag();
                    this.pickObjHolder.name = String(_local3.types_[Layer.OBJECT]);
                    this.addModifyCommandList(_arg1.tiles_, Layer.OBJECT, -1);
                    this.commandMenu_.setCommand(MECommandMenu.DROP_COMMAND);
                }
                break;
            case MECommandMenu.DROP_COMMAND:
                if (this.pickObjHolder != null) {
                    _local10 = int(this.pickObjHolder.name);
                    this.addModifyCommandList(_arg1.tiles_, Layer.OBJECT, _local10);
                    this.pickObjHolder.stopDrag();
                    this.pickObjHolder.removeChildAt(0);
                    this.pickObjHolder = null;
                    this.commandMenu_.setCommand(MECommandMenu.PICK_UP_COMMAND);
                }
                break;
        }
        this.meMap_.draw();
    }

    private function onEditComplete(_arg1:Event):void {
        var _local2:EditTileProperties = (_arg1.currentTarget as EditTileProperties);
        this.addObjectNameCommandList(_local2.tiles_, _local2.getObjectName());
    }

    private function addModifyCommandList(_arg1:Vector.<IntPoint>, _arg2:int, _arg3:int):void {
        var _local5:IntPoint;
        var _local6:int;
        var _local4:CommandList = new CommandList();
        for each (_local5 in _arg1) {
            _local6 = this.meMap_.getType(_local5.x_, _local5.y_, _arg2);
            if (_local6 != _arg3) {
                _local4.addCommand(new MEModifyCommand(this.meMap_, _local5.x_, _local5.y_, _arg2, _local6, _arg3));
            }
        }
        if (_local4.empty()) {
            return;
        }
        this.commandQueue_.addCommandList(_local4);
    }

    private function addPasteCommandList(_arg1:Vector.<IntPoint>, _arg2:Vector.<METile>):void {
        var _local5:IntPoint;
        var _local6:METile;
        var _local3:CommandList = new CommandList();
        var _local4:int;
        for each (_local5 in _arg1) {
            if (_local4 >= _arg2.length) break;
            _local6 = this.meMap_.getTile(_local5.x_, _local5.y_);
            _local3.addCommand(new MEReplaceCommand(this.meMap_, _local5.x_, _local5.y_, _local6, _arg2[_local4]));
            _local4++;
        }
        if (_local3.empty()) {
            return;
        }
        this.commandQueue_.addCommandList(_local3);
    }

    private function addObjectNameCommandList(_arg1:Vector.<IntPoint>, _arg2:String):void {
        var _local4:IntPoint;
        var _local5:String;
        var _local3:CommandList = new CommandList();
        for each (_local4 in _arg1) {
            _local5 = this.meMap_.getObjectName(_local4.x_, _local4.y_);
            if (_local5 != _arg2) {
                _local3.addCommand(new MEObjectNameCommand(this.meMap_, _local4.x_, _local4.y_, _local5, _arg2));
            }
        }
        if (_local3.empty()) {
            return;
        }
        this.commandQueue_.addCommandList(_local3);
    }

    private function safeRemoveCategoryChildren() {
        SpriteUtil.safeRemoveChild(this, this.groundChooser_);
        SpriteUtil.safeRemoveChild(this, this.objChooser_);
        SpriteUtil.safeRemoveChild(this, this.enemyChooser_);
        SpriteUtil.safeRemoveChild(this, this.regionChooser_);
        SpriteUtil.safeRemoveChild(this, this.wallChooser_);
        SpriteUtil.safeRemoveChild(this, this.object3DChooser_);
        SpriteUtil.safeRemoveChild(this, this.allObjChooser_);
        SpriteUtil.safeRemoveChild(this, this.dungeonChooser_);
    }

    private function onDropDownChange(_arg1:Event = null):void {
        switch (this.chooserDropDown_.getValue()) {
            case GroundLibrary.GROUND_CATEGORY:
                this.setSearch(this.groundChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.groundChooser_);
                this.chooser_ = this.groundChooser_;
                this.filter.setFilterType(ObjectLibrary.TILE_FILTER_LIST);
                this.filter.enableDropDownFilter(true);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(false);
                return;
            case "Basic Objects":
                this.setSearch(this.objChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.objChooser_);
                this.chooser_ = this.objChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(false);
                return;
            case "Enemies":
                this.setSearch(this.enemyChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.enemyChooser_);
                this.chooser_ = this.enemyChooser_;
                this.filter.setFilterType(ObjectLibrary.ENEMY_FILTER_LIST);
                this.filter.enableDropDownFilter(true);
                this.filter.enableValueFilter(true);
                this.filter.enableDungeonFilter(false);
                return;
            case "Regions":
                this.setSearch("");
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.regionChooser_);
                this.chooser_ = this.regionChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(false);
                return;
            case "Walls":
                this.setSearch(this.wallChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.wallChooser_);
                this.chooser_ = this.wallChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(false);
                return;
            case "3D Objects":
                this.setSearch(this.object3DChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.object3DChooser_);
                this.chooser_ = this.object3DChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(false);
                return;
            case "All Objects":
                this.setSearch(this.allObjChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.allObjChooser_);
                this.chooser_ = this.allObjChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                return;
            case "Dungeons":
                this.setSearch(this.dungeonChooser_.getLastSearch());
                this.safeRemoveCategoryChildren();
                SpriteUtil.safeAddChild(this, this.dungeonChooser_);
                this.chooser_ = this.dungeonChooser_;
                this.filter.enableDropDownFilter(false);
                this.filter.enableValueFilter(false);
                this.filter.enableDungeonFilter(true);
                return;
        }
    }

    private function onDropDownSizeChange(_arg1:Event):void {
        var _local2:Number;
        switch (this.mapSizeDropDown_.getValue()) {
            case "64x64":
                _local2 = 64;
                break;
            case "128x128":
                _local2 = 128;
                break;
            case "256x256":
                _local2 = 0x0100;
                break;
            case "512x512":
                _local2 = 0x0200;
                break;
            case "1024x1024":
                _local2 = 0x0400;
                break;
        }
        this.meMap_.resize(_local2);
        this.meMap_.draw();
    }

    private function onUndo(_arg1:CommandEvent):void {
        this.commandQueue_.undo();
        this.meMap_.draw();
    }

    private function onRedo(_arg1:CommandEvent):void {
        this.commandQueue_.redo();
        this.meMap_.draw();
    }

    private function onClear(_arg1:CommandEvent):void {
        var _local4:IntPoint;
        var _local5:METile;
        var _local2:Vector.<IntPoint> = this.meMap_.getAllTiles();
        var _local3:CommandList = new CommandList();
        for each (_local4 in _local2) {
            _local5 = this.meMap_.getTile(_local4.x_, _local4.y_);
            if (_local5 != null) {
                _local3.addCommand(new MEClearCommand(this.meMap_, _local4.x_, _local4.y_, _local5));
            }
        }
        if (_local3.empty()) {
            return;
        }
        this.commandQueue_.addCommandList(_local3);
        this.meMap_.draw();
        this.filename_ = null;
    }

    private function createMapJSON():String {
        var _local7:int;
        var _local8:METile;
        var _local9:Object;
        var _local10:String;
        var _local11:int;
        var _local1:Rectangle = this.meMap_.getTileBounds();
        if (_local1 == null) {
            return (null);
        }
        var _local2:Object = {};
        _local2["width"] = int(_local1.width);
        _local2["height"] = int(_local1.height);
        var _local3:Object = {};
        var _local4:Array = [];
        var _local5:ByteArray = new ByteArray();
        var _local6:int = _local1.y;
        while (_local6 < _local1.bottom) {
            _local7 = _local1.x;
            while (_local7 < _local1.right) {
                _local8 = this.meMap_.getTile(_local7, _local6);
                _local9 = this.getEntry(_local8);
                _local10 = this.json.stringify(_local9);
                if (!_local3.hasOwnProperty(_local10)) {
                    _local11 = _local4.length;
                    _local3[_local10] = _local11;
                    _local4.push(_local9);
                }
                else {
                    _local11 = _local3[_local10];
                }
                _local5.writeShort(_local11);
                _local7++;
            }
            _local6++;
        }
        _local2["dict"] = _local4;
        _local5.compress();
        _local2["data"] = Base64.encodeByteArray(_local5);
        return (this.json.stringify(_local2));
    }

    private function onSave(_arg1:CommandEvent):void {
        var _local2:String = this.createMapJSON();
        if (_local2 == null) {
            return;
        }
        new FileReference().save(_local2, (((this.filename_ == null)) ? "map.jm" : this.filename_));
    }

    private function onSubmit(_arg1:CommandEvent):void {
        var _local2:String = this.createMapJSON();
        if (_local2 == null) {
            return;
        }
        this.meMap_.setMinZoom();
        this.meMap_.draw();
        dispatchEvent(new SubmitJMEvent(_local2, this.meMap_.getMapStatistics()));
    }

    private function getEntry(_arg1:METile):Object {
        var _local3:Vector.<int>;
        var _local4:String;
        var _local5:Object;
        var _local2:Object = {};
        if (_arg1 != null) {
            _local3 = _arg1.types_;
            if (_local3[Layer.GROUND] != -1) {
                _local4 = GroundLibrary.getIdFromType(_local3[Layer.GROUND]);
                _local2["ground"] = _local4;
            }
            if (_local3[Layer.OBJECT] != -1) {
                _local4 = ObjectLibrary.getIdFromType(_local3[Layer.OBJECT]);
                _local5 = {"id": _local4};
                if (_arg1.objName_ != null) {
                    _local5["name"] = _arg1.objName_;
                }
                _local2["objs"] = [_local5];
            }
            if (_local3[Layer.REGION] != -1) {
                _local4 = RegionLibrary.getIdFromType(_local3[Layer.REGION]);
                _local2["regions"] = [{"id": _local4}];
            }
        }
        return (_local2);
    }

    private function onLoad(_arg1:CommandEvent):void {
        this.loadedFile_ = new FileReference();
        this.loadedFile_.addEventListener(Event.SELECT, this.onFileBrowseSelect);
        this.loadedFile_.browse([new FileFilter("JSON Map (*.jm)", "*.jm")]);
    }

    private function onFileBrowseSelect(event:Event):void {
        var loadedFile:FileReference = (event.target as FileReference);
        loadedFile.addEventListener(Event.COMPLETE, this.onFileLoadComplete);
        loadedFile.addEventListener(IOErrorEvent.IO_ERROR, this.onFileLoadIOError);
        try {
            loadedFile.load();
        }
        catch (e:Error) {
        }
    }

    private function onFileLoadComplete(_arg1:Event):void {
        var _local7:String;
        var _local11:int;
        var _local13:int;
        var _local14:Object;
        var _local15:Array;
        var _local16:Array;
        var _local17:Object;
        var _local18:Object;
        var _local2:FileReference = (_arg1.target as FileReference);
        this.filename_ = _local2.name;
        var _local3:Object = this.json.parse(_local2.data.toString());
        var _local4:int = _local3["width"];
        var _local5:int = _local3["height"];
        var _local6:Number = 64;
        while ((((_local6 < _local3["width"])) || ((_local6 < _local3["height"])))) {
            _local6 = (_local6 * 2);
        }
        if (MEMap.NUM_SQUARES != _local6) {
            _local7 = ((_local6 + "x") + _local6);
            if (!this.mapSizeDropDown_.setValue(_local7)) {
                this.mapSizeDropDown_.setValue("512x512");
            }
        }
        var _local8:Rectangle = new Rectangle(int(((MEMap.NUM_SQUARES / 2) - (_local4 / 2))), int(((MEMap.NUM_SQUARES / 2) - (_local5 / 2))), _local4, _local5);
        this.meMap_.clear();
        this.commandQueue_.clear();
        var _local9:Array = _local3["dict"];
        var _local10:ByteArray = Base64.decodeToByteArray(_local3["data"]);
        _local10.uncompress();
        var _local12:int = _local8.y;
        while (_local12 < _local8.bottom) {
            _local13 = _local8.x;
            while (_local13 < _local8.right) {
                _local14 = _local9[_local10.readShort()];
                if (_local14.hasOwnProperty("ground")) {
                    _local11 = GroundLibrary.idToType_[_local14["ground"]];
                    this.meMap_.modifyTile(_local13, _local12, Layer.GROUND, _local11);
                }
                _local15 = _local14["objs"];
                if (_local15 != null) {
                    for each (_local17 in _local15) {
                        if (ObjectLibrary.idToType_.hasOwnProperty(_local17["id"])) {
                            _local11 = ObjectLibrary.idToType_[_local17["id"]];
                            this.meMap_.modifyTile(_local13, _local12, Layer.OBJECT, _local11);
                            if (_local17.hasOwnProperty("name")) {
                                this.meMap_.modifyObjectName(_local13, _local12, _local17["name"]);
                            }
                        }
                    }
                }
                _local16 = _local14["regions"];
                if (_local16 != null) {
                    for each (_local18 in _local16) {
                        _local11 = RegionLibrary.idToType_[_local18["id"]];
                        this.meMap_.modifyTile(_local13, _local12, Layer.REGION, _local11);
                    }
                }
                _local13++;
            }
            _local12++;
        }
        this.meMap_.draw();
    }

    public function disableInput():void {
        removeChild(this.commandMenu_);
    }

    public function enableInput():void {
        addChild(this.commandMenu_);
    }

    private function onFileLoadIOError(_arg1:Event):void {
    }

    private function onTest(_arg1:Event):void {
        dispatchEvent(new MapTestEvent(this.createMapJSON()));
    }

    private function onMenuSelect(_arg1:Event):void {
        if (this.meMap_ != null) {
            this.meMap_.clearSelect();
        }
    }


}
}
