package;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
using flixel.util.FlxSpriteUtil;

class UI extends FlxTypedGroup<FlxSprite>
{
    private var _score:FlxText;

    public function new()
    {
        super();

        _score = new FlxText(5, 5, 0, "0", 30);
        _score.setBorderStyle(FlxText.BORDER_OUTLINE, 0xFF000000, 4.0);
        _score.alignment = "right";
        
        add(_score);
        
        forEach(function(spr:FlxSprite) {
            spr.scrollFactor.set();
        });
    }

    override public function destroy():Void
    {
        remove(this._score);
        this._score = null;
    }

    public function updateUI():Void
    {
        _score.text = Std.string(Reg.getScore()) + " / " + Std.string(Reg.getHighScore());
        _score.screenCenter();
        _score.y = 5;
    }
}
