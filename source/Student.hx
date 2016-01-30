package ;

import Std.int;
import flixel.util.FlxPoint;
import Math.floor;
import flixel.FlxObject;
import flixel.util.FlxRandom;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.FlxG;
import flixel.util.FlxAngle;
using flixel.util.FlxSpriteUtil;
import flixel.effects.particles.FlxEmitter;
import flixel.FlxState;
import flixel.util.FlxTimer;


class Student extends FlxSpriteGroup
{
    private var top:FlxSprite;
    private var bot:FlxSprite;
    private var mouseDown:Bool;
    private var beltcolor:String;
    private var bowSpeed:Int = 2;
    private var isBowing:Bool = false;

    // Spawn related stuff
    private var initialSpawntime:Int;
    private var spawnTime:Int;
    private var left:Bool = true;
    private var speedFactor:Float = 5.0;
//    private var initialScale:Float = 0.2;
    private var spawner:StudentSpawner = null;
    private var numHits:Int = 0;

    // Dragging
    private var dX:Float = 0.0;
    private var dY:Float = 0.0;

    // Death animation
    private var flyingAni:FlxEmitter;
    private var state:FlxState;

    public function new(beltcolor:String, spawnTime:Int=-2, spawner:StudentSpawner=null, state:FlxState=null)
    {
        super();
        this.spawner = spawner;
        this.beltcolor = beltcolor;
        this.top = new FlxSprite();
        this.top.loadGraphic("assets/images/upper_body_80.png");
        add(this.top);
        this.bot = new FlxSprite();
        this.bot.loadGraphic("assets/images/" + this.beltcolor + "_front_80.png");
        this.bot.y = this.bot.frameHeight;
        add(this.bot);

        this.initialSpawntime = spawnTime;
        this.spawnTime = spawnTime;

        if (spawnTime > -2) {
            this.left = FlxRandom.intRanged(0, 1) == 1;
        }

        this.state = state;
        if (this.state != null) {
            flyingAni = new FlxEmitter();
            flyingAni.setXSpeed( -1200, 1200);
            flyingAni.setYSpeed( -1200, 0);
            flyingAni.setRotation( -720, -720);
            flyingAni.gravity = 800;
            flyingAni.bounce = 0.35;
            flyingAni.makeParticles("assets/images/" + this.beltcolor + "_whole_front_80.png", 1, 16, false, 0.0);
            this.state.add(this.flyingAni);
        }
    }

    public function initializePosition():Void
    {
        this.screenCenter();
        if (this.left) {
            this.x -= FlxRandom.intRanged(0 + Std.int(this.frameWidth / 2.0), Std.int(130 - this.top.frameWidth));
        } else {
            this.x += FlxRandom.intRanged(0 + Std.int(this.frameWidth / 2.0), Std.int(130 - this.top.frameWidth));
        }
        this.velocity.x = 0.0;
        this.velocity.y = 0.0;
        this.dX = 0.0;
        this.dY = 0.0;
//        this.scale.set(this.initialScale, this.initialScale);
        this.y = 632 + 1 - this.height; // + this.height * (1.0 - scaleFactor) / 2.0;
    }

    public function bow():Void
    {
        this.isBowing = true;
    }

    override public function update():Void
    {
        if (FlxG.mouse.justPressed)
        {
            if (FlxG.mouse.x >= this.x && (FlxG.mouse.x <= (this.x + this.width)) && FlxG.mouse.y >= this.y - 23 && (FlxG.mouse.y <= (this.y + this.height - 23))) {
//                if (this.beltcolor == "yellow"
//                    || this.beltcolor == "orange"
//                    || this.beltcolor == "green") {
                    this.mouseDown = true;
//                }
            }
//            trace("SMouse: " + Std.string(FlxG.mouse.x) + " " + Std.string(FlxG.mouse.y));
//            trace("SThiss: " + Std.string(this.x) + " " + Std.string(this.y) + " " + Std.string(this.width) + " " + Std.string(this.height));
        }

        if (FlxG.mouse.justReleased)
        {
            if (FlxG.mouse.x >= this.x && (FlxG.mouse.x <= (this.x + this.width)) && FlxG.mouse.y >= this.y - 23 && (FlxG.mouse.y <= (this.y + this.height - 23))) {
                this.mouseDown = false;
                this.numHits += 1;
                FlxG.sound.play("assets/sounds/slap0" + Std.string(FlxRandom.intRanged(1, 3)) + ".wav");
            }
        }

        if (this.isBowing) {
            this.top.y += this.bowSpeed;
        } else {
            if (this.top.y > this.bot.y - this.top.frameHeight) {
                this.top.y -= this.bowSpeed;
            }
        }

        if (this.top.y + this.top.frameHeight < this.bot.y) {
            this.top.y = this.bot.y - this.top.frameHeight;
        }

        if (this.top.y + this.top.frameHeight > this.bot.y + this.bot.frameHeight) {
            this.top.y = this.bot.y + this.bot.frameHeight - this.top.frameHeight;
            this.isBowing = false;
        }

        if (this.initialSpawntime > -2) {
            if (this.spawnTime <= 0) {
                this.spawnTime = 0;
                this.velocity.y = 30.0 * this.speedFactor;
                if (this.left) {
                    this.velocity.x = -13.0 * this.speedFactor;
                } else {
                    this.velocity.x = 13.0 * this.speedFactor;
                }
            } else {
                this.spawnTime -= 1;
//                var scaleFactor:Float = this.initialScale + (1.0 - this.initialScale) * (this.initialSpawntime - this.spawnTime) / this.initialSpawntime;
                this.y = 632 + 1 - this.top.frameHeight; // + this.height * (1.0 - scaleFactor) / 2.0;
//                this.scale.set(scaleFactor, scaleFactor);
            }

            if (this.mouseDown && FlxG.mouse.pressed) {
                this.velocity.x = 0.0;
                this.velocity.y = 0.0;
                moveTo(FlxG.mouse.x, FlxG.mouse.y);
            }
            if (this.spawner != null) {
                if (this.y > 1024 + this.frameHeight) {
                    Reg.removeScore(10);
                    kill();
                }
                if ((this.beltcolor == "yellow" && this.numHits >= 1)
                    || (this.beltcolor == "orange" && this.numHits >= 2)
                    || (this.beltcolor == "green" && this.numHits >= 2)
                    || (this.beltcolor == "blue" && this.numHits >= 3)
                    || (this.beltcolor == "brown" && this.numHits >= 4)) {
                    FlxG.sound.play("assets/sounds/kiai0" + Std.string(FlxRandom.intRanged(1, 8, [4])) + ".wav");
                    switch (this.beltcolor) {
                        case "yellow": Reg.addScore(2);
                        case "orange": Reg.addScore(5);
                        case "green": Reg.addScore(10);
                        case "blue": Reg.addScore(20);
                        case "brown": Reg.addScore(50);
                        default:
                    }

                    if (this.flyingAni != null) {
                        this.flyingAni.at(this);
                        this.flyingAni.start(true, 5);
                    }

                    kill();
                }
            }
        }

        super.update();
    }

    public function moveTo(tarX : Float, tarY : Float) : Void {
        this.dX = this.x + this.width / 2.0 - tarX;
        this.dY = this.y + this.height / 2.0 - tarY;
        var dist = Math.sqrt(dX * dX + dY * dY);

        if (dist >= this.speedFactor * 10) {
            this.x -= dX / dist * this.speedFactor * (dist / this.speedFactor * 0.1);
            this.y -= dY / dist * this.speedFactor * (dist / this.speedFactor * 0.1);
        } else if (dist >= this.speedFactor) {
            this.x -= dX / dist * this.speedFactor;
            this.y -= dY / dist * this.speedFactor;
        } else if (dist > 0.0) {
            this.x -= dX / dist;
            this.y -= dY / dist;
        }

        // Be instant vulnerable if thrown in the air.
        if (this.y < 460) {
            this.numHits = 99;
        }
    }

    override public function kill():Void
    {
        this.alive = false;

//        var timer = new FlxTimer();
//        timer.start(5.0, function(t:FlxTimer):Void {
//            if (this.state != null) {
//                this.state.remove(this.flyingAni);
//                this.flyingAni = null;
//                this.state = null;
//            }
//            if (this.spawner != null) {
//                this.spawner.remove(this);
//                this.spawner = null;
//            }
//        });

        super.kill();
    }

    override public function destroy():Void
    {
        if (this.state != null) {
            this.state.remove(this.flyingAni);
            this.flyingAni = null;
            this.state = null;
        }
        if (this.spawner != null) {
            this.spawner.remove(this);
            this.spawner = null;
        }
        this.top = null;
        this.bot = null;
        super.destroy();
    }

    override public function draw():Void
    {
        super.draw();
    }

}
