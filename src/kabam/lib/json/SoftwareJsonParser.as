package kabam.lib.json {
import com.adobe.serialization.json.JSON;

public class SoftwareJsonParser implements JsonParser {


    public function stringify(_arg1:Object):String {
        return (com.adobe.serialization.json.JSON.encode(_arg1));
    }

    public function parse(_arg1:String):Object {
        return (com.adobe.serialization.json.JSON.decode(_arg1));
    }


}
}
