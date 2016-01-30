package;

import flixel.FlxSprite;
import flixel.group.FlxTypedSpriteGroup;
import flixel.util.FlxRandom;
import flixel.FlxG;

class TreeManager extends FlxTypedSpriteGroup<Tree>
{
    private var numTrees = 15;
    private var spawntimes:Array<Int>;
    public function new()
    {
        super();

        this.spawntimes = new Array<Int>();
        for (i in 0...numTrees) {
            this.spawntimes.push(FlxRandom.intRanged(120, 2000));
        }

        this.spawntimes.sort(function(a,b) return b-a);
        for (st in this.spawntimes) {
            add(new Tree(st));
        }
    }

    override public function destroy():Void
    {
        this.spawntimes = null;
        for (tree in this.group.members) {
            remove(tree);
        }
        super.destroy();
    }

    override public function update():Void
    {
        super.update();
    }
}