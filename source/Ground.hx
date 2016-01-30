package ;

import Std.int;
import Math.floor;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxAngle;

class Ground extends FlxSprite
{
    public function new()
    {
        super();
        loadGraphic("assets/images/ground.png");
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
