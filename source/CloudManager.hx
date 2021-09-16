package;

import flixel.FlxSprite;
import flixel.group.FlxTypedSpriteGroup;
import flixel.util.FlxRandom;

class CloudManager extends FlxTypedSpriteGroup<Cloud>
{
    private var numClouds:Int;
    private var left2right:Bool;

    public function new()
    {
        super();

        this.numClouds = FlxRandom.intRanged(0, 10);
        this.left2right = FlxRandom.intRanged(0, 1) == 1;

        for (i in 0...numClouds) {
            add(new Cloud(this.left2right));
        }
    }

    override public function destroy():Void
    {
        for (cloud in this.group.members) {
            remove(cloud);
        }
        super.destroy();
    }

    override public function update():Void
    {
        super.update();
    }
}