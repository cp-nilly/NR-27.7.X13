package com.company.assembleegameclient.objects {
public class TextureDataFactory {


    public function create(_arg1:XML):TextureData {
        return (new TextureDataConcrete(_arg1));
    }


}
}
