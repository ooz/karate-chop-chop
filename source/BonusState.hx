package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;


class BonusState extends FlxState
{
    private var background:MenuMap;
    private var player:BlackBelt;
    private var students:StudentManager;

    private var shouldBow:Bool = false;


    override public function create():Void
    {
        FlxG.worldBounds.width = 576;
        FlxG.worldBounds.height = 1024;

        this.background = new MenuMap("clean");
        this.background.screenCenter();
        add(this.background);

        this.player = new BlackBelt("160");
        this.player.setFrontFacing();
        this.player.screenCenter();
        this.player.y = 632 + 150;
        this.player.setFrontFacing();
        add(this.player);

        var myText = new FlxText(5, 5, 0, "", 30); // x, y, width
        myText.text = "31337 Respect!\n\nGlobal Game Jam 2016\nTheme: 'Ritual'\n\nKarate Chop Chop\nby Oliver Zeit\n\nSpecial Thanks\nToke Lichtenberg";
        myText.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.RED, 4.0);
        myText.alignment = "center";
        myText.screenCenter();
        myText.x -= 200;
        myText.y -= 400;
        add(myText);

//        this.students = new StudentManager();
//        this.students.screenCenter();
//        this.students.y = 632 - 70;
//        add(this.students);

        FlxG.sound.playMusic("assets/music/oss.wav");
        var timer = new FlxTimer();
        timer.start(3.0, function(t:FlxTimer):Void {
            shouldBow = true;
        });

        super.create();
    }

    override public function destroy():Void
    {
        remove(this.background);
        remove(this.player);
//        remove(this.students);
        this.background = null;
        this.player = null;
//        this.students = null;

        super.destroy();
    }

    override public function update():Void
    {
        if (this.shouldBow) {
            if (!this.player.isBowing) {
                if (this.player.hasBowed) {
                    this.player.hasBowed = false;
                }
                if (!this.player.isBowing) {
                    var turntimer = new FlxTimer();
                    turntimer.start(1.5, startGame);
                }
            }
        }

        super.update();
    }

    private function startGame(t:FlxTimer):Void {
        FlxG.sound.pause();
        FlxG.switchState(new MenuState());
    }
}
