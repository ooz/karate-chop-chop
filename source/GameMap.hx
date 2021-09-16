package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class GameMap extends FlxSpriteGroup
{
    private var ground:Ground;
    private var streetMarker:StreetMarker;
    private var sky:Sky;
    public var trees:TreeManager;
    public var clouds:CloudManager;

    public function new()
    {
        super();

        this.ground = new Ground();
        add(this.ground);

        this.streetMarker = new StreetMarker();
        this.streetMarker.x = 278;
        this.streetMarker.y = 632 - 140;
        add(this.streetMarker);

        this.sky = new Sky();
        add(this.sky);

        this.trees = new TreeManager();
        this.trees.x = 0;
        this.trees.y = 0;
        add(this.trees);

        this.clouds = new CloudManager();
        add(this.clouds);
    }

    override public function destroy():Void
    {
        remove(this.ground);
        remove(this.streetMarker);
        remove(this.sky);
        remove(this.trees);
        this.ground = null;
        this.streetMarker = null;
        this.sky = null;
        this.trees = null;

        super.destroy();
    }

    override public function update():Void
    {
        super.update();
    }
}