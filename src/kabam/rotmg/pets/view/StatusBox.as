package kabam.rotmg.pets.view {
import flash.display.Sprite;

import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

public class StatusBox extends Sprite {

    private const labelTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 16, true);
    private const valueTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 16, true);
    private const WIDTH:uint = 238;
    private const HEIGHT:uint = 30;
    private const PADDING:uint = 10;
    private const POS_Y:uint = 21;

    public function StatusBox() {
        this.createBackground();
        this.addChildren();
        this.updateTextfields("Text", "Text");
        this.waitForTextChanged();
    }

    public function updateTextfields(_arg1:String, _arg2:String):void {
        this.labelTextfield.setStringBuilder(new LineBuilder().setParams(_arg1));
        this.valueTextfield.setStringBuilder(new LineBuilder().setParams(_arg2));
    }

    private function addChildren():void {
        addChild(this.labelTextfield);
        addChild(this.valueTextfield);
    }

    private function createBackground():void {
        graphics.beginFill(0x999999);
        graphics.drawRect(0, 0, this.WIDTH, this.HEIGHT);
    }

    private function waitForTextChanged():void {
        var _local1:SignalWaiter = new SignalWaiter();
        _local1.push(this.labelTextfield.textChanged);
        _local1.push(this.valueTextfield.textChanged);
        _local1.complete.addOnce(this.positionTextField);
    }

    private function positionTextField():void {
        this.labelTextfield.x = this.PADDING;
        this.labelTextfield.y = this.POS_Y;
        this.valueTextfield.x = ((this.WIDTH - this.PADDING) - this.valueTextfield.width);
        this.valueTextfield.y = this.POS_Y;
    }


}
}
