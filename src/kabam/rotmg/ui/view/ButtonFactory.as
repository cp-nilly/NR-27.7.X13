package kabam.rotmg.ui.view {
import com.company.assembleegameclient.constants.ScreenTypes;
import com.company.assembleegameclient.screens.TitleMenuOption;

import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class ButtonFactory {

    public static const BUTTON_SIZE_LARGE:uint = 36;
    public static const BUTTON_SIZE_SMALL:uint = 22;
    private static const LEFT:String = TextFieldAutoSize.LEFT;//"left"
    private static const CENTER:String = TextFieldAutoSize.CENTER;//"center"
    private static const RIGHT:String = TextFieldAutoSize.RIGHT;//"right"

    private static var playButton:TitleMenuOption;
    private static var serversButton:TitleMenuOption;
    private static var accountButton:TitleMenuOption;
    private static var legendsButton:TitleMenuOption;
    private static var languagesButton:TitleMenuOption;
    private static var supportButton:TitleMenuOption;
    private static var editorButton:TitleMenuOption;
    private static var quitButton:TitleMenuOption;
    private static var doneButton:TitleMenuOption;
    private static var mainButton:TitleMenuOption;
    private static var classesButton:TitleMenuOption;
    private static var transferAccountButton:TitleMenuOption;
    private static var textureEditorButton:TitleMenuOption;


    public static function getPlayButton():TitleMenuOption {
        return ((playButton = ((playButton) || (makeButton(ScreenTypes.PLAY, BUTTON_SIZE_LARGE, CENTER, true)))));
    }

    public static function getTextureEditorButton():TitleMenuOption {
        return ((textureEditorButton = ((textureEditorButton) || (makeButton(ScreenTypes.TEXTURE_EDITOR, BUTTON_SIZE_SMALL, LEFT)))));
    }

    public static function getClassesButton():TitleMenuOption {
        return ((classesButton = ((classesButton) || (makeButton(TextKey.SCREENS_CLASSES, BUTTON_SIZE_SMALL, LEFT)))));
    }

    public static function getMainButton():TitleMenuOption {
        return ((mainButton = ((mainButton) || (makeButton(TextKey.SCREENS_MAIN, BUTTON_SIZE_SMALL, RIGHT)))));
    }

    public static function getDoneButton():TitleMenuOption {
        return ((doneButton = ((doneButton) || (makeButton(TextKey.DONE_TEXT, BUTTON_SIZE_LARGE, CENTER)))));
    }

    public static function getAccountButton():TitleMenuOption {
        return ((accountButton = ((accountButton) || (makeButton(ScreenTypes.ACCOUNT, BUTTON_SIZE_SMALL, LEFT)))));
    }

    public static function getLegendsButton():TitleMenuOption {
        return ((legendsButton = ((legendsButton) || (makeButton(ScreenTypes.LEGENDS, BUTTON_SIZE_SMALL, LEFT)))));
    }

    public static function getServersButton():TitleMenuOption {
        return ((serversButton = ((serversButton) || (makeButton(ScreenTypes.SERVERS, BUTTON_SIZE_SMALL, RIGHT)))));
    }

    public static function getLanguagesButton():TitleMenuOption {
        return ((languagesButton = ((languagesButton) || (makeButton(ScreenTypes.LANGUAGES, BUTTON_SIZE_SMALL, RIGHT)))));
    }

    public static function getSupportButton():TitleMenuOption {
        return ((supportButton = ((supportButton) || (makeButton(ScreenTypes.SUPPORT, BUTTON_SIZE_SMALL, RIGHT)))));
    }

    public static function getEditorButton():TitleMenuOption {
        return ((editorButton = ((editorButton) || (makeButton(ScreenTypes.EDITOR, BUTTON_SIZE_SMALL, RIGHT)))));
    }

    public static function getQuitButton():TitleMenuOption {
        return ((quitButton = ((quitButton) || (makeButton(ScreenTypes.QUIT, BUTTON_SIZE_SMALL, LEFT)))));
    }

    public static function getTransferButton():TitleMenuOption {
        return ((transferAccountButton = ((transferAccountButton) || (makeButton(ScreenTypes.TRANSFER_ACCOUNT, BUTTON_SIZE_SMALL, RIGHT)))));
    }

    private static function makeButton(_arg1:String, _arg2:int, _arg3:String, _arg4:Boolean = false):TitleMenuOption {
        var _local5:TitleMenuOption = new TitleMenuOption(_arg1, _arg2, _arg4);
        _local5.setAutoSize(_arg3);
        _local5.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        return (_local5);
    }


}
}
