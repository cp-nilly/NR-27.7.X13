package kabam.rotmg.editor {
import flash.display.DisplayObjectContainer;

import kabam.lib.json.JsonParser;
import kabam.lib.json.SoftwareJsonParser;
import kabam.lib.tasks.TaskMonitor;
import kabam.rotmg.core.commands.SetupDomainSecurityCommand;
import kabam.rotmg.core.signals.GotoPreviousScreenSignal;
import kabam.rotmg.core.signals.LaunchGameSignal;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.core.signals.SetupDomainSecuritySignal;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.core.view.ScreensMediator;
import kabam.rotmg.core.view.ScreensView;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.dialogs.view.DialogsMediator;
import kabam.rotmg.dialogs.view.DialogsView;
import kabam.rotmg.editor.commands.SaveTextureCommand;
import kabam.rotmg.editor.model.SearchModel;
import kabam.rotmg.editor.signals.SaveTextureSignal;
import kabam.rotmg.editor.signals.SetTextureSignal;
import kabam.rotmg.editor.view.LoadTextureDialog;
import kabam.rotmg.editor.view.LoadTextureMediator;
import kabam.rotmg.editor.view.SaveTextureDialog;
import kabam.rotmg.editor.view.SaveTextureMediator;
import kabam.rotmg.editor.view.TermsMediator;
import kabam.rotmg.editor.view.TermsView;
import kabam.rotmg.editor.view.TextureMediator;
import kabam.rotmg.editor.view.TextureView;
import kabam.rotmg.editor.view.components.loaddialog.ResultsBox;
import kabam.rotmg.editor.view.components.loaddialog.ResultsBoxMediator;
import kabam.rotmg.startup.control.StartupSequence;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

public class EditorConfig implements IConfig {

    [Inject]
    public var context:IContext;
    [Inject]
    public var contextView:DisplayObjectContainer;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var startupSequence:StartupSequence;
    private var layers:Layers;


    public function configure():void {
        this.configureServices();
        this.configureSignals();
        this.configureCommands();
        this.configureViews();
        this.injector.map(SearchModel).asSingleton();
        this.startupSequence.addSignal(SetupDomainSecuritySignal);
        //this.startupSequence.addSignal(SetupEditorSignal);
        //this.context.lifecycle.afterInitializing(this.init);
    }

    private function configureServices():void {
        this.injector.map(JsonParser).toSingleton(SoftwareJsonParser);
        this.injector.map(TaskMonitor).asSingleton();
    }

    private function configureSignals():void {
        this.injector.map(SetScreenSignal).asSingleton();
        this.injector.map(GotoPreviousScreenSignal).asSingleton();
        this.injector.map(LaunchGameSignal).asSingleton();
        this.injector.map(SetTextureSignal).asSingleton();
        this.injector.map(OpenDialogSignal).asSingleton();
        this.injector.map(CloseDialogsSignal).asSingleton();
    }

    private function configureCommands():void {
        this.commandMap.map(SetupDomainSecuritySignal).toCommand(SetupDomainSecurityCommand);
        //this.commandMap.map(SetupEditorSignal).toCommand(SetupEditorCommand);
        this.commandMap.map(SaveTextureSignal).toCommand(SaveTextureCommand);
    }

    private function configureViews():void {
        this.mediatorMap.map(ScreensView).toMediator(ScreensMediator);
        this.mediatorMap.map(DialogsView).toMediator(DialogsMediator);
        this.mediatorMap.map(ResultsBox).toMediator(ResultsBoxMediator);
        this.mediatorMap.map(TermsView).toMediator(TermsMediator);
        this.mediatorMap.map(TextureView).toMediator(TextureMediator);
        this.mediatorMap.map(SaveTextureDialog).toMediator(SaveTextureMediator);
        this.mediatorMap.map(LoadTextureDialog).toMediator(LoadTextureMediator);
    }

    private function init():void {
        this.mediatorMap.mediate(this.contextView);
        this.layers = new Layers();
        this.injector.map(Layers).toValue(this.layers);
        this.contextView.addChild(this.layers);
    }


}
}
