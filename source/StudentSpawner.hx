package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxTypedSpriteGroup;
import flixel.util.FlxRandom;
import flixel.FlxG;
using flixel.util.FlxSpriteUtil;

class StudentSpawner extends FlxTypedSpriteGroup<Student>
{
    public function new()
    {
        super();
        x = 0;
        y = 0;
    }

    public function spawn(beltcolor:String, state:FlxState):Void
    {
        var newStud = new Student(beltcolor, FlxRandom.intRanged(0, 30), this, state);
        add(newStud);
        newStud.initializePosition();
    }

    override public function destroy():Void
    {
        super.destroy();
    }

    override public function update():Void
    {
        super.update();
    }
}