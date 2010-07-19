/**
 * ...
 * @author MrHant
 */

package serpiente;

import flash.Lib;
import flash.utils.Timer;
import flash.display.Shape;
import flash.display.Graphics;
import flash.events.TimerEvent;

class BodyPart {
	
	static var circleColor = 0xB0A0CC;
	public var part : Shape;
	var _x : Float;
	var _y : Float;
	var _r : Float;
	

	function drawPart():Shape {
		var circle : Shape = new Shape();
		var g : Graphics = circle.graphics;
		
		g = circle.graphics;
		g.beginFill(circleColor);
		g.drawCircle(_x, _y, _r);
		circle.alpha = 0.3;
		
		return circle;
	}
	
	public function new(x:Float, y:Float ) {
		_x = x;
		_y = y;
		_r = 20;
		
		this.part = drawPart();
		Main.mc.stage.addChild(this.part);
	}
		
	public function shrink(d: Float) {
		var circle : Shape = new Shape();
		_r = d;
		Main.mc.stage.removeChild(this.part);
		
		this.part = drawPart();
		Main.mc.stage.addChild(this.part);		
	
	}
	
	public function areWeTouched() {
		if (Math.sqrt(Math.pow((Main.snake.head.x-this._x),2)+Math.pow(Main.snake.head.y-this._y,2))<this._r*2) { // 30
			Main.gameOver();
		}
	}
	
	
	
	
	
	
}