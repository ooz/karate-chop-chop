package ;

import Std.int;
import Math.floor;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxAngle;

class Sky extends FlxSprite
{
    public function new()
    {
        super();
        loadGraphic("assets/images/sky.png");
        x = 0;
        y = 0;
    }

    override public function update():Void
    {
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
