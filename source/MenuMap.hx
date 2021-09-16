package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class MenuMap extends FlxSpriteGroup
{
    private var ground:FlxSprite;
    private var wall:FlxSprite;

    public function new(wall:String="logo")
    {
        super();

        this.ground = new FlxSprite();
        this.ground.loadGraphic("assets/images/floor.png");
        this.ground.y = 632;
        add(this.ground);

        this.wall = new FlxSprite();
        this.wall.loadGraphic("assets/images/" + wall + ".png");
        add(this.wall);
    }

    override public function destroy():Void
    {
        remove(this.ground);
        remove(this.wall);
        this.ground = null;
        this.wall = null;

        super.destroy();
    }

    override public function update():Void
    {
        super.update();
    }
}