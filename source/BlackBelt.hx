package ;

import Std.int;
import Math.floor;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.FlxG;
import flixel.util.FlxAngle;

class BlackBelt extends FlxSpriteGroup
{
    private var top:FlxSprite;
    private var bot:FlxSprite;
    private var mouseDown:Bool;
    private var size:String;
    private var bowSpeed:Int = 2;

    public var isFrontFacing:Bool = false;
    public var hasBowed:Bool = false;
    public var isBowing:Bool = false;

    public function new(size:String)
    {
        super();
        this.size = size;
        this.top = new FlxSprite();
        this.top.loadGraphic("assets/images/upper_body_" + this.size + ".png");
        add(this.top);
        this.bot = new FlxSprite();
        this.bot.loadGraphic("assets/images/black_back_" + this.size + ".png");
        this.bot.y = this.bot.frameHeight;
        add(this.bot);
    }

    public function setFrontFacing():Void
    {
        this.bot.loadGraphic("assets/images/black_front_" + this.size + ".png");
        this.isFrontFacing = true;
    }

    public function setBackFacing():Void
    {
        this.bot.loadGraphic("assets/images/black_back_" + this.size + ".png");
        this.isFrontFacing = false;
    }

    override public function update():Void
    {
        if (FlxG.mouse.justPressed)
        {
            if (FlxG.mouse.x >= this.x && (FlxG.mouse.x <= (this.x + this.width)) && FlxG.mouse.y >= this.y - 47 && (FlxG.mouse.y <= (this.y + this.height - 47))) {
                this.mouseDown = true;
            }
//            trace("Mouse: " + Std.string(FlxG.mouse.x) + " " + Std.string(FlxG.mouse.y));
//            trace("Thiss: " + Std.string(this.x) + " " + Std.string(this.y) + " " + Std.string(this.width) + " " + Std.string(this.height));
        }

        if (FlxG.mouse.justReleased)
        {
            if (FlxG.mouse.x >= this.x && (FlxG.mouse.x <= (this.x + this.width)) && FlxG.mouse.y >= this.y - 47 && (FlxG.mouse.y <= (this.y + this.height - 47))) {
                this.mouseDown = false;
            }
        }

        if (this.mouseDown && FlxG.mouse.pressed) {
            this.isBowing = true;
            if (this.top.y > FlxG.mouse.y) {
                this.top.y -= this.bowSpeed;
            } else if (this.top.y < FlxG.mouse.y) {
                this.top.y += this.bowSpeed;
            }
        } else {
            this.mouseDown = false;
            if (this.top.y > this.bot.y - this.top.frameHeight) {
                this.isBowing = true;
                this.top.y -= this.bowSpeed;
            }
        }

        if (this.top.y + this.top.frameHeight < this.bot.y) {
            this.top.y = this.bot.y - this.top.frameHeight;
            this.isBowing = false;
        }

        if (this.top.y + this.top.frameHeight > this.bot.y + this.bot.frameHeight) {
            this.top.y = this.bot.y + this.bot.frameHeight - this.top.frameHeight;
            this.hasBowed = true;
        }

        super.update();
    }

    override public function destroy():Void
    {
        this.top = null;
        this.bot = null;

        super.destroy();
    }

    override public function draw():Void
    {
        super.draw();
    }

}
