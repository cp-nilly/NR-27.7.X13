package kabam.rotmg.application.api {
public interface ApplicationSetup extends DebugSetup {

    function getBuildLabel():String;

    function getAppEngineUrl(_arg1:Boolean = false):String;

    function useLocalTextures():Boolean;

    function isToolingEnabled():Boolean;

    function areDeveloperHotkeysEnabled():Boolean;

    function isGameLoopMonitored():Boolean;

    function useProductionDialogs():Boolean;

    function areErrorsReported():Boolean;

}
}
