package kabam.rotmg.account.securityQuestions.data {
public class SecurityQuestionsModel {

    private var _showSecurityQuestionsOnStartup:Boolean = false;
    private var _securityQuestionsList:Array;
    public var securityQuestionsAnswers:Array;

    public function SecurityQuestionsModel() {
        this._securityQuestionsList = [];
        this.securityQuestionsAnswers = [];
        super();
    }

    public function get showSecurityQuestionsOnStartup():Boolean {
        return (this._showSecurityQuestionsOnStartup);
    }

    public function set showSecurityQuestionsOnStartup(_arg1:Boolean):void {
        this._showSecurityQuestionsOnStartup = _arg1;
    }

    public function get securityQuestionsList():Array {
        return (this._securityQuestionsList);
    }

    public function clearQuestionsList() {
        this._securityQuestionsList = [];
    }

    public function addSecurityQuestion(_arg1:String):void {
        this._securityQuestionsList.push(_arg1);
    }


}
}
