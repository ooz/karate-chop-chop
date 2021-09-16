package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;


/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var background:MenuMap;
	private var player:BlackBelt;
	private var students:StudentManager;
    private var turnAround:Bool = false;
    private var isBackFacing:Bool = false;
    private var doneBowing:Bool = false;

    private var shouldBow:Bool = false;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
        FlxG.worldBounds.width = 576;
        FlxG.worldBounds.height = 1024;

		this.background = new MenuMap();
		this.background.screenCenter();
		add(this.background);

		this.player = new BlackBelt("160");
		this.player.setFrontFacing();
		this.player.screenCenter();
		this.player.y = 632 + 150;
        this.player.setBackFacing();
		add(this.player);

		this.students = new StudentManager();
		this.students.screenCenter();
        this.students.y = 632 - 70;
		add(this.students);

        FlxG.sound.volume = 1.0;

        FlxG.sound.play("assets/sounds/seiza.wav");
        var timer = new FlxTimer();
        timer.start(3.0, mokuso);

        super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
        remove(this.background);
        remove(this.player);
        remove(this.students);
        this.background = null;
        this.player = null;
        this.students = null;

		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
        if (this.shouldBow) {
            if (this.player.hasBowed) {
                this.students.studentsShouldBow = true;
                this.player.hasBowed = false;
                this.turnAround = true;
            }
            if (this.turnAround && !this.player.isBowing) {
                this.turnAround = false;
                if (this.player.isFrontFacing) {
                    this.player.setBackFacing();
                    var turntimer = new FlxTimer();
                    turntimer.start(1.5, sensei);
                } else {
                    var turntimer = new FlxTimer();
                    turntimer.start(1.5, kiritsu);
                }
            }
        }

		super.update();
	}

    private function sensei(t:FlxTimer):Void {
        FlxG.sound.play("assets/sounds/sensei.wav");
    }

    private function mokuso(t:FlxTimer):Void {
        FlxG.sound.play("assets/sounds/mokuso.wav");
        this.shouldBow = false;
        this.player.hasBowed = false;
        var timer = new FlxTimer();
        timer.start(3.0, mokusoYame);
    }
    private function mokusoYame(t:FlxTimer):Void {
        FlxG.sound.play("assets/sounds/mokuso_yame.wav");
        this.shouldBow = false;
        this.player.hasBowed = false;
        var timer = new FlxTimer();
        timer.start(3.0, shomen);
    }
    private function shomen(t:FlxTimer):Void {
        this.player.setFrontFacing();
        FlxG.sound.play("assets/sounds/shomen.wav");
        this.shouldBow = true;
    }
    private function kiritsu(t:FlxTimer):Void {
        FlxG.sound.play("assets/sounds/kiritsu.wav");
        this.shouldBow = false;
        this.player.hasBowed = false;
        var timer = new FlxTimer();
        timer.start(3.0, hajime);
    }
    private function hajime(t:FlxTimer):Void {
        FlxG.sound.play("assets/sounds/hajime.wav");
        this.shouldBow = false;
        this.player.hasBowed = false;
        var timer = new FlxTimer();
        timer.start(3.0, startGame);
    }
    private function startGame(t:FlxTimer):Void {
        FlxG.switchState(new PlayState());
    }
}