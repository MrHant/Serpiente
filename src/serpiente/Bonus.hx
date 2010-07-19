/**
 * ...
 * @author MrHant
 */

package serpiente;

import flash.utils.Timer;
import flash.display.Graphics;
import flash.display.Shape;
import serpiente.Main;
import flash.events.TimerEvent;
import serpiente.LibraryClasses;
import flash.geom.Matrix;
import flash.display.BitmapData;

class Bonus {

	var part : Shape;
	var _x:Float;
	var _y:Float;
	var time : Timer;
	var _points: Int;
	var _radius:Float;
	var _type: Int;
	
	static var bonusCount : Int = 0;
	static var maxBonuses : Int = 7; //7
	
	public function new(x:Float,y:Float,type:Int) {
		if (bonusCount >= maxBonuses)
			return;
		var bonusShape : Shape = new Shape();
		_x = x;
		_y = y;
		_type = type;

		var g : Graphics = bonusShape.graphics;
		
      // # Bitmap bonus
	    var matrix = new Matrix(); 
		var tmp:BitmapData;
		switch (type) {
			case 1,3,5,7,9:
				tmp = new STRAWBERRY_png();
				_points = 5;
				_radius = 30;
				matrix.tx = x - 30;
				matrix.ty = y - 30;
				g.beginBitmapFill(tmp,matrix);
				g.drawRect(x-tmp.width/2+4,y-tmp.height/2-4,tmp.width,tmp.height);
			default:
				tmp = new ORANGE_png();
				_points = 10;
				_radius = 40;
				matrix.tx = x - 40;
				matrix.ty = y - 40;
				g.beginBitmapFill(tmp,matrix);
				g.drawRect(x-tmp.width/2,y-tmp.height/2-5,tmp.width,tmp.height);
		}
		g.endFill();

		bonusShape.alpha = 0.9;
		Main.mc.stage.addChild(bonusShape);
		time = new Timer(50);
		time.addEventListener(TimerEvent.TIMER, pickBonus);
		time.start();
		
		this.part = bonusShape;
		bonusCount++;
	}
	
	public static function spawn(?e:TimerEvent) {
		new Bonus(Math.random() * 400 + 50, Math.random() * 400 + 50,Math.floor(Math.random()*10));	
	}
	
	function pickBonus(e:TimerEvent) {
		if (Math.sqrt(Math.pow((Main.snake.head.x-this._x),2)+Math.pow(Main.snake.head.y-this._y,2))<this._radius+23 || Main.gameOverFlag == true) {
			Main.mc.stage.removeChild(this.part);
			this.time.removeEventListener(TimerEvent.TIMER, pickBonus);
			Main.snake.bodySize += Math.ceil(_points);
			if (Main.gameOverFlag == false) 
				Scores.update(Math.ceil(Main.snake.bodySize));
			bonusCount--;
		}
	}
	
	
	
}