package ;

import Std.int;
import Math.floor;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxAngle;

class StreetMarker extends FlxSpriteGroup
{
//    private var _top:FlxSprite;
    private var _bottom:FlxSprite;

    public var speed:Int = 7;

    public function new()
    {
        super();

//        _top = new FlxSprite();
        _bottom = new FlxSprite();

//        _top.loadGraphic("assets/images/street_marker.png");
        _bottom.loadGraphic("assets/images/street_marker.png");

//        add(_top);
        add(_bottom);

//        _top.y = -392;
    }

    override public function update():Void
    {
        y = y + this.speed;
        if (y > FlxG.height) {
            y = 0;
        }

        super.update();
    }

    override public function destroy():Void
    {
        remove(this._bottom);
        this._bottom = null;
        super.destroy();
    }

}
