package kabam.rotmg.build.impl {
import kabam.rotmg.build.api.BuildEnvironment;

public final class BuildEnvironments {

    public static const LOCALHOST:String = "localhost";
    public static const PRIVATE:String = "private";
    public static const DEV:String = "dev";
    public static const TESTING:String = "testing";
    public static const TESTING2:String = "testing2";
    public static const PRODTEST:String = "prodtest";
    public static const PRODUCTION:String = "production";
    public static const NILLYSREALM:String = "nr";
    public static const NILLYSREALMTEST:String = "nrtest";
    private static const IP_MATCHER:RegExp = /[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/;


    public function getEnvironment(_arg1:String):BuildEnvironment {
        return (((this.isFixedIP(_arg1)) ? BuildEnvironment.FIXED_IP : this.getEnvironmentFromName(_arg1)));
    }

    private function isFixedIP(_arg1:String):Boolean {
        return (!((_arg1.match(IP_MATCHER) == null)));
    }

    private function getEnvironmentFromName(_arg1:String):BuildEnvironment {
        switch (_arg1) {
            case LOCALHOST:
                return (BuildEnvironment.LOCALHOST);
            case PRIVATE:
                return (BuildEnvironment.PRIVATE);
            case DEV:
                return (BuildEnvironment.DEV);
            case TESTING:
                return (BuildEnvironment.TESTING);
            case TESTING2:
                return (BuildEnvironment.TESTING2);
            case PRODTEST:
                return (BuildEnvironment.PRODTEST);
            case PRODUCTION:
                return (BuildEnvironment.PRODUCTION);
            case NILLYSREALM:
                return BuildEnvironment.NILLYSREALM;
            case NILLYSREALMTEST:
                return BuildEnvironment.NILLYSREALMTEST;
        }
        return (null);
    }


}
}
