package kabam.lib.resizing {
import robotlegs.bender.extensions.mediatorMap.MediatorMapExtension;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;

public class ResizeExtension implements IExtension {


    public function extend(_arg1:IContext):void {
        _arg1.extend(MediatorMapExtension);
        _arg1.configure(ResizeConfig);
    }


}
}
