package;

import flixel.util.FlxSave;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	private static var score:Int = 100;
	private static var highScore:Int = score;

	public static function getScore() {
		return score;
	}
	public static function getHighScore() {
		return highScore;
	}

	public static function setScore(s:Int) {
		score = s;
		if (score > highScore) {
			highScore = score;
		}
	}
	public static function addScore(amount:Int) {
		setScore(getScore() + amount);
	}
	public static function removeScore(amount:Int) {
		setScore(getScore() - amount);
	}

	public static var MAX_SCORE:Int = 2147431337;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];


}