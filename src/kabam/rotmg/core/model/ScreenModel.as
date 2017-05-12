package kabam.rotmg.core.model {
import com.company.assembleegameclient.screens.AccountLoadingScreen;

public class ScreenModel {

    private var currentType:Class;


    public function setCurrentScreenType(_arg1:Class):void {
        if (_arg1 != AccountLoadingScreen) {
            this.currentType = _arg1;
        }
    }

    public function getCurrentScreenType():Class {
        return (this.currentType);
    }


}
}
