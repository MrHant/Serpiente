/**
 * ...
 * @author MrHant
 */

package serpiente;

import flash.text.TextField;
import flash.text.TextFormat;

class Scores {
	public static var score : Int;
	public static var scoreField:TextField;
	public static var highScoresField:TextField = new TextField();
	
	public function new() {
		score = 0;
		scoreField = new TextField();
		scoreField.defaultTextFormat = new TextFormat("Arial", 30, 0x00AACC, 1, 1);
		scoreField.text = Std.string(score);
		scoreField.x = 10;
		scoreField.y = 510;
		
    	highScoresField.defaultTextFormat = new TextFormat("Arial", 14, 0xFF00DD, 1, 1, 0);
		highScoresField.x = 120;
		highScoresField.y = 300;
		highScoresField.selectable = false;
		highScoresField.width = 400;
		highScoresField.height = 500;

		//Main.stage.addChild(scoreField);
	}
	
	public static function update(d:Int) {
		score += d;
		scoreField.text = Std.string(score);
	}
	
	public static function show() {
    	highScoresField.text = "\t\tЛучшие результаты:\n";
		DataProvider.getHighScores();
		Main.mc.stage.addChild(highScoresField);
	}
	
	public static function hide() {
		Main.mc.stage.removeChild(highScoresField);
	}
}