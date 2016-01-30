package;

import flixel.FlxSprite;
import flixel.group.FlxTypedSpriteGroup;
import flixel.util.FlxRandom;
import flixel.FlxG;

class StudentManager extends FlxTypedSpriteGroup<Student>
{
    public var studentsShouldBow:Bool = false;

    public function new()
    {
        super();
        x = 0;
        y = 0;

        var stud:Student = new Student("brown");
        add(stud);
        stud = new Student("blue");
        stud.x = 90;
        add(stud);
        stud = new Student("green");
        stud.x = 180;
        add(stud);
        stud = new Student("orange");
        stud.x = 270;
        add(stud);
        stud = new Student("yellow");
        stud.x = 360;
        add(stud);
    }

    override public function destroy():Void
    {
        for (stud in this.group.members) {
            remove(stud);
        }
        super.destroy();
    }

    override public function update():Void
    {
        if (this.studentsShouldBow) {
            for (student in this.group.members) {
                student.bow();
            }
            this.studentsShouldBow = false;
        }
        super.update();
    }
}