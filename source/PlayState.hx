package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;


/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

    private var map:GameMap;
    private var player:BlackBelt;
    private var spawner:StudentSpawner;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
        FlxG.worldBounds.width = 576;
        FlxG.worldBounds.height = 1024;

        this.map = new GameMap();
        this.map.screenCenter();
        for (tree in this.map.trees.group.members) {
            tree.initializePosition();
        }
        add(this.map);

        this.player = new BlackBelt("80");
        this.player.screenCenter();
        this.player.y = 632 + 150;
        add(this.player);

        this.spawner = new StudentSpawner();

        super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
        if (this.player.hasBowed) {
            this.player.hasBowed = false;
            FlxG.sound.play("assets/sounds/yame.wav");
            var timer = new FlxTimer();
            timer.start(3.0, endGame);
        }

		super.update();
	}
    private function endGame(t:FlxTimer):Void {
        FlxG.switchState(new MenuState());
    }
}