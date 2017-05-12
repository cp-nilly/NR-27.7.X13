package kabam.rotmg.classes.view {
import com.company.assembleegameclient.util.FameUtil;

import flash.events.TimerEvent;
import flash.utils.Timer;

import kabam.rotmg.assets.model.Animation;
import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.classes.control.FocusCharacterSkinSignal;
import kabam.rotmg.classes.model.CharacterClass;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.classes.model.ClassesModel;
import kabam.rotmg.core.model.PlayerModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ClassDetailMediator extends Mediator {

    private const skins:Object = new Object();
    private const nextSkinTimer:Timer = new Timer(250, 1);

    [Inject]
    public var view:ClassDetailView;
    [Inject]
    public var classesModel:ClassesModel;
    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var focusSet:FocusCharacterSkinSignal;
    [Inject]
    public var factory:CharacterFactory;
    private var character:CharacterClass;
    private var nextSkin:CharacterSkin;


    override public function initialize():void {
        this.character = this.classesModel.getSelected();
        this.nextSkinTimer.addEventListener(TimerEvent.TIMER, this.delayedFocusSet);
        this.focusSet.add(this.onFocusSet);
        this.setCharacterData();
        this.onFocusSet();
    }

    override public function destroy():void {
        this.focusSet.remove(this.onFocusSet);
        this.nextSkinTimer.removeEventListener(TimerEvent.TIMER, this.delayedFocusSet);
        this.view.setWalkingAnimation(null);
        this.disposeAnimations();
    }

    private function setCharacterData():void {
        var _local1:int = this.playerModel.charList.bestFame(this.character.id);
        var _local2:int = FameUtil.numStars(_local1);
        this.view.setData(this.character.name, this.character.description, _local2, this.playerModel.charList.bestLevel(this.character.id), _local1);
        var _local3:int = FameUtil.nextStarFame(_local1, 0);
        this.view.setNextGoal(this.character.name, _local3);
    }

    private function onFocusSet(_arg1:CharacterSkin = null):void {
        _arg1 = ((_arg1) || (this.character.skins.getSelectedSkin()));
        this.nextSkin = _arg1;
        this.nextSkinTimer.start();
    }

    private function delayedFocusSet(_arg1:TimerEvent):void {
        var _local2:Animation = (this.skins[this.nextSkin.id] = ((this.skins[this.nextSkin.id]) || (this.factory.makeWalkingIcon(this.nextSkin.template, ((this.nextSkin.is16x16) ? 100 : 200)))));
        this.view.setWalkingAnimation(_local2);
    }

    private function disposeAnimations():void {
        var _local1:String;
        var _local2:Animation;
        for (_local1 in this.skins) {
            _local2 = this.skins[_local1];
            _local2.dispose();
            delete this.skins[_local1];
        }
    }


}
}
