package kabam.rotmg.application.impl {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.application.api.ApplicationSetup;

public class NillysRealmTestSetup implements ApplicationSetup {
    
    private const SERVER:String = "core.nillysrealm.com";
    private const UNENCRYPTED:String = "http://" + SERVER;
    private const ENCRYPTED:String = "https://" + SERVER;
    private const ANALYTICS:String = "UA-99999999-1";
    private const BUILD_LABEL:String = "Nilly's Realm <font color='#FFEE00'>TESTING</font> #{VERSION}.{MINOR}";
    
    
    public function getAppEngineUrl(_arg1:Boolean = false):String {
        return this.ENCRYPTED;
    }
    
    public function getAnalyticsCode():String {
        return this.ANALYTICS;
    }
    
    public function getBuildLabel():String {
        return this.BUILD_LABEL.replace("{VERSION}", Parameters.BUILD_VERSION).replace("{MINOR}", Parameters.MINOR_VERSION);
    }
    
    public function useLocalTextures():Boolean {
        return true;
    }
    
    public function isToolingEnabled():Boolean {
        return true;
    }
    
    public function isGameLoopMonitored():Boolean {
        return true;
    }
    
    public function useProductionDialogs():Boolean {
        return false;
    }
    
    public function areErrorsReported():Boolean {
        return false;
    }
    
    public function areDeveloperHotkeysEnabled():Boolean {
        return true;
    }
    
    public function isDebug():Boolean {
        return true;
    }
    
    
}
}
