package kabam.rotmg.pets.view.dialogs {
import com.company.assembleegameclient.ui.dialogs.Dialog;

public class PetDialog extends Dialog {

    protected var petDialogStyler:PetDialogStyler;

    public function PetDialog(_arg1:String, _arg2:String, _arg3:String, _arg4:String, _arg5:String) {
        this.petDialogStyler = new PetDialogStyler(this);
        super(_arg1, _arg2, _arg3, _arg4, _arg5);
        this.petDialogStyler.stylizePetDialog();
    }

    override protected function drawAdditionalUI():void {
        this.petDialogStyler.positionText();
    }

    override protected function drawGraphicsTemplate():void {
        this.petDialogStyler.drawGraphics();
    }


}
}
