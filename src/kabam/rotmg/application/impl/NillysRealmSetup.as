package kabam.rotmg.application.impl {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.application.api.ApplicationSetup;

public class NillysRealmSetup implements ApplicationSetup {
    
    private const SERVER:String = "core.nillysrealm.com";
    private const UNENCRYPTED:String = "http://" + SERVER;
    private const ENCRYPTED:String = "https://" + SERVER;
    private const BUILD_LABEL:String = "Nilly's Realm #{VERSION}.{MINOR}";
    
    
    public function getAppEngineUrl(_arg1:Boolean = true):String {
        return this.ENCRYPTED;
    }
    
    public function getBuildLabel():String {
        return this.BUILD_LABEL.replace("{VERSION}", Parameters.BUILD_VERSION).replace("{MINOR}", Parameters.MINOR_VERSION);
    }
    
    public function useLocalTextures():Boolean {
        return false;
    }
    
    public function isToolingEnabled():Boolean {
        return false;
    }
    
    public function isGameLoopMonitored():Boolean {
        return false;
    }
    
    public function useProductionDialogs():Boolean {
        return true;
    }
    
    public function areErrorsReported():Boolean {
        return false;
    }
    
    public function areDeveloperHotkeysEnabled():Boolean {
        return false;
    }
    
    public function isDebug():Boolean {
        return false;
    }
    
    
}
}
