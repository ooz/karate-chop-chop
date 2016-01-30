package ;

import Std.int;
import Math.floor;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.FlxG;
import flixel.util.FlxAngle;

class Student extends FlxSpriteGroup
{
    private var top:FlxSprite;
    private var bot:FlxSprite;
    private var mouseDown:Bool;
    private var beltcolor:String;
    private var bowSpeed:Int = 2;
    private var isBowing:Bool = false;

    public function new(beltcolor:String)
    {
        super();
        this.beltcolor = beltcolor;
        this.top = new FlxSprite();
        this.top.loadGraphic("assets/images/upper_body_80.png");
        add(this.top);
        this.bot = new FlxSprite();
        this.bot.loadGraphic("assets/images/" + this.beltcolor + "_front_80.png");
        this.bot.y = this.bot.frameHeight;
        add(this.bot);

        MouseEventManager.add(this, onDown, onUp, null, null);
    }

    private function onDown(Sprite:FlxSprite)
    {
        this.mouseDown = true;
    }

    private function onUp(Sprite:FlxSprite)
    {
        this.mouseDown = false;
    }

    public function bow():Void
    {
        this.isBowing = true;
    }

    override public function update():Void
    {
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
