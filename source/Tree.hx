package ;

import flixel.util.FlxPoint;
import Std.int;
import flixel.FlxSprite;
import flixel.util.FlxRandom;
using flixel.util.FlxSpriteUtil;

class Tree extends FlxSprite
{
    private var initial_spawntime:Int;
    private var spawntime:Int;
    private var left:Bool;
    private var speedFactor:Float = 5.0;
    private var initialScale:Float = 0.2;

    public function new(initialSpawntime:Int)
    {
        super();
        loadGraphic("assets/images/tree0" + Std.string(FlxRandom.intRanged(0, 1)) + "_80.png");
        this.initial_spawntime = initialSpawntime;
        this.spawntime = this.initial_spawntime;
        this.left = FlxRandom.intRanged(0, 1) == 1;
    }

    public function initializePosition():Void
    {
        this.screenCenter();
        if (this.left) {
            this.x -= FlxRandom.intRanged(138 + Std.int(this.frameWidth / 2.0), Std.int(288 - (this.frameWidth / 2.0)));
        } else {
            this.x += FlxRandom.intRanged(138 + Std.int(this.frameWidth / 2.0), Std.int(288 - (this.frameWidth / 2.0)));
        }
        this.velocity.x = 0.0;
        this.velocity.y = 0.0;
        this.scale = new FlxPoint(this.initialScale, this.initialScale);
        this.y = 632 - this.frameHeight / 1.75;
    }

    override public function update():Void
    {
        if (this.spawntime <= 0) {
            this.spawntime = 0;
            this.velocity.y = 39.0 * this.speedFactor;
            if (this.left) {
                this.velocity.x = -13.0 * this.speedFactor;
            } else {
                this.velocity.x = 13.0 * this.speedFactor;
            }
        } else {
            this.spawntime -= 1;
            var scaleFactor:Float = this.initialScale + (1.0 - this.initialScale) * (this.initial_spawntime - this.spawntime) / this.initial_spawntime;
            this.y = 632 + 1 - this.height + this.height * (1.0 - scaleFactor) / 2.0;
            this.scale = new FlxPoint(scaleFactor, scaleFactor);
        }

        if (this.y > 1024 + this.frameHeight) {
            initializePosition();
            this.spawntime = this.initial_spawntime;
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
