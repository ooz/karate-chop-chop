package;

import flixel.util.FlxRandom;
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
    private var ui:UI;

    private var spawnThreshold:Float = 0.995;

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

        this.spawner = new StudentSpawner();
        spawner.screenCenter();
        add(this.spawner);

        this.player = new BlackBelt("80");
        this.player.screenCenter();
        this.player.y = 632 + 150;
        add(this.player);

        ui = new UI();
        add(ui);

        super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
        remove(this.map);
        remove(this.spawner);
        remove(this.player);
        remove(this.ui);
        this.map = null;
        this.spawner = null;
        this.player = null;
        this.ui = null;
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
        // Ending condition
        if (this.player.hasBowed) {
            this.player.hasBowed = false;

            var timer = new FlxTimer();
            FlxG.sound.play("assets/sounds/yame.wav");
            timer.start(2.5, endGame);
        }

        // Spawn students
        if (FlxRandom.floatRanged(0.0, 1.0) > this.spawnThreshold) {
            var colorRand:Int = FlxRandom.intRanged(1, 10);
            if (colorRand > 6) {
                this.spawner.spawn("yellow", this);
            } else if (colorRand > 4) {
                this.spawner.spawn("orange", this);
            } else if (colorRand > 3) {
                this.spawner.spawn("green", this);
            } else if (colorRand > 1) {
                this.spawner.spawn("blue", this);
            } else if (colorRand > 0) {
                this.spawner.spawn("brown", this);
            }
        }

        if (Reg.getScore() < 0) {
            Reg.setScore(0);
        } else if (Reg.getScore() > Reg.MAX_SCORE) {
            Reg.setScore(Reg.MAX_SCORE);
        }
        this.ui.updateUI();

        updateSpawnThreshold();

		super.update();
	}

    private function updateSpawnThreshold():Void
    {
        if (Reg.getScore() <= 100) {
            this.spawnThreshold = 0.995;
        } else if (Reg.getScore() <= 250) {
            this.spawnThreshold = 0.99;
        } else if (Reg.getScore() <= 500) {
            this.spawnThreshold = 0.98;
        } else if (Reg.getScore() <= 1000) {
            this.spawnThreshold = 0.96;
        } else if (Reg.getScore() >= 31337) {
            this.spawnThreshold = 0.75;
        } else {
            this.spawnThreshold = 0.94;
        }
    }

    private function endGame(t:FlxTimer):Void {
        if (Reg.getScore() >= 31337) {
            FlxG.switchState(new BonusState());
        } else {
            FlxG.switchState(new MenuState());
        }
    }
}