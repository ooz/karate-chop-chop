package ;

import flixel.util.FlxPoint;
import Std.int;
import flixel.FlxSprite;
import flixel.util.FlxRandom;
import flixel.FlxG;
using flixel.util.FlxSpriteUtil;

class Cloud extends FlxSprite
{
    private var left2right:Bool;
    private var initialX:Int;
    private var initialY:Int;
    private var speed:Int;

    public function new(left2right:Bool = true)
    {
        super();
        this.left2right = left2right;
        loadGraphic("assets/images/cloud0" + Std.string(FlxRandom.intRanged(0, 2)) + ".png");
        initializePosition();
    }

    public function initializePosition():Void
    {
        this.screenCenter();
        if (this.left2right) {
            this.initialX = FlxRandom.intRanged(-240, -120);
            this.x = this.initialX;
        } else {
            this.initialX = FlxRandom.intRanged(576 + 120, 576 + 240);
            this.x = this.initialX;
        }

        this.y = 40 + FlxRandom.intRanged(0, 300);
        this.speed = FlxRandom.intRanged(5, 10);
    }

    override public function update():Void
    {
        if (this.left2right) {
            this.velocity.x = this.speed;
        } else {
            this.velocity.x = -this.speed;
        }

        if (this.left2right) {
            if (this.x > 576 + 130) {
                initializePosition();
            }
        } else {
            if (this.x < -130) {
                initializePosition();
            }
        }

        super.update();
    }

    override public function destroy():Void
    {
        super.destroy();
    }

    override public function draw():Void
    {
        super.draw();
    }

}
