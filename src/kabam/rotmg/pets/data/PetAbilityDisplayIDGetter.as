package kabam.rotmg.pets.data {
import com.company.assembleegameclient.objects.ObjectLibrary;

public class PetAbilityDisplayIDGetter {


    public function getID(_arg1:int):String {
        return (ObjectLibrary.getPetDataXMLByType(_arg1).DisplayId);
    }


}
}
