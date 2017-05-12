package kabam.rotmg.messaging.impl.incoming {
import kabam.rotmg.messaging.impl.EvolvePetInfo;
import kabam.rotmg.pets.controller.EvolvePetSignal;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;

import org.swiftsuspenders.Injector;

public class EvolvedMessageHandler {

    [Inject]
    public var injector:Injector;
    private var evolvePetInfo:EvolvePetInfo;
    private var message:EvolvedPetMessage;
    private var finalPet:PetVO;
    private var initialPet:PetVO;


    public function handleMessage(_arg1:EvolvedPetMessage):void {
        this.message = _arg1;
        this.evolvePetInfo = new EvolvePetInfo();
        this.addFinalPet();
        this.addInitialPet(_arg1);
        this.dispatchEvolvePetSignal();
    }

    private function addFinalPet():void {
        var _local1:PetsModel = this.injector.getInstance(PetsModel);
        this.finalPet = _local1.getPet(this.message.petID);
        this.finalPet.setSkin(this.message.finalSkin);
        this.evolvePetInfo.finalPet = this.finalPet;
    }

    private function addInitialPet(_arg1:EvolvedPetMessage):void {
        this.initialPet = PetVO.clone(this.finalPet);
        this.initialPet.setSkin(_arg1.initialSkin);
        this.evolvePetInfo.initialPet = this.initialPet;
    }

    private function dispatchEvolvePetSignal():void {
        var _local1:EvolvePetSignal = this.injector.getInstance(EvolvePetSignal);
        _local1.dispatch(this.evolvePetInfo);
    }


}
}
