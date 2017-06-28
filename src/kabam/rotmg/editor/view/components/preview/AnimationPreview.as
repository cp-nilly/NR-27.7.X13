package kabam.rotmg.editor.view.components.preview {
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.ImageSet;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.ColorMatrixFilter;
import flash.utils.getTimer;

public class AnimationPreview extends Preview {

    private static var animationpreviewiconsEmbed_:Class = AnimationPreview_animationpreviewiconsEmbed_;
    private static var icons_:ImageSet = function ():ImageSet {
        var _local_1:* = new ImageSet();
        _local_1.addFromBitmapData(new animationpreviewiconsEmbed_().bitmapData, 16, 16);
        return (_local_1);
    }();

    private var animatedChar_:AnimatedChar = null;
    private var action_:int = 0;
    private var stand_:Sprite;
    private var walk_:Sprite;
    private var attack_:Sprite;

    public function AnimationPreview(w:int, h:int) {
        var walkBitmap:Bitmap;
        super(w, h);
        walkBitmap = new Bitmap(icons_.images_[1]);
        walkBitmap.scaleX = (walkBitmap.scaleY = 2);
        this.walk_ = createIcon(walkBitmap, function ():void {
            action_ = AnimatedChar.WALK;
        });
        this.walk_.x = ((w_ / 2) - (this.walk_.width / 2));
        this.walk_.y = ((h_ - this.walk_.height) - 5);
        var standBitmap:Bitmap = new Bitmap(icons_.images_[0]);
        standBitmap.scaleX = (standBitmap.scaleY = 2);
        this.stand_ = createIcon(standBitmap, function ():void {
            action_ = AnimatedChar.STAND;
        });
        this.stand_.x = ((this.walk_.x - this.stand_.width) - 5);
        this.stand_.y = ((h_ - this.stand_.height) - 5);
        var attackBitmap:Bitmap = new Bitmap(icons_.images_[2]);
        attackBitmap.scaleX = (attackBitmap.scaleY = 2);
        this.attack_ = createIcon(attackBitmap, function ():void {
            action_ = AnimatedChar.ATTACK;
        });
        this.attack_.x = ((this.walk_.x + this.walk_.width) + 5);
        this.attack_.y = ((h_ - this.attack_.height) - 5);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onAddedToStage(_arg_1:Event):void {
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onEnterFrame(_arg_1:Event):void {
        this.render();
    }

    override public function redraw():void {
        super.redraw();
        this.stand_.filters = (((this.action_) == AnimatedChar.STAND) ? [new ColorMatrixFilter(GREY_MATRIX)] : []);
        this.walk_.filters = (((this.action_) == AnimatedChar.WALK) ? [new ColorMatrixFilter(GREY_MATRIX)] : []);
        this.attack_.filters = (((this.action_) == AnimatedChar.ATTACK) ? [new ColorMatrixFilter(GREY_MATRIX)] : []);
        if ((((origBitmapData_ == null)) || ((origBitmapData_.width <= 16)))) {
            return;
        }
        this.animatedChar_ = new AnimatedChar(new MaskedImage(origBitmapData_, null), (origBitmapData_.width / 7), origBitmapData_.height, AnimatedChar.RIGHT);
        this.render();
    }

    protected function render():void {
        if (this.animatedChar_ == null) {
            return;
        }
        var _local_1:Number = ((getTimer() % 400) / 400);
        var _local_2:MaskedImage = this.animatedChar_.imageFromDir(AnimatedChar.RIGHT, this.action_, _local_1);
        var _local_3:BitmapData = TextureRedrawer.redraw(_local_2.image_, size_, true, 0, false);
        bitmap_.bitmapData = _local_3;
        position();
    }


}
}
