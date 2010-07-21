/**
 * ...
 * @author MrHant
 */

package serpiente;


import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Shape;
import flash.geom.Transform;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.KeyboardEvent;
import serpiente.BodyPart;
import serpiente.LibraryClasses;
import flash.geom.Matrix;



class Snake {
	public var head : Shape;
	public var direction : Float;
	public var progressTimer : Timer;
	var turn: Int;
	static var noTurn = 0;
	static var turnLeft = 1;
	static var turnRight = 2;
	public static var controlType : Int;
	public static var angleControl = 1;
	public static var directionControl = 2;
	
	var prevTime : Int;

	public var body : Array<BodyPart>;
	public var bodySize : Int;
	public var step : Int;
	
	public function new() {
		head = new Shape();
		var g : Graphics = head.graphics;
/*	
		// #Triangle head
		g.beginFill(0xEE00DD);
	    g.moveTo(0, -25);
		g.lineTo(35, 0);
		g.lineTo(0, 25);
		g.lineTo(0, -25);
*/
	    var matrix = new Matrix(); 
		var tmp : BitmapData = new HEAD_png();
		matrix.ty = -20;
		matrix.tx = -13;
		g.beginBitmapFill(tmp,matrix);
		g.drawRect(-13, -20, tmp.width, tmp.height);
		
		g.endFill();
		head.x = 30;
		head.y = 30;
		head.rotation = 45;
		direction = head.rotation * Math.PI / 180;
		Main.mc.stage.addChild(head);
		
		Main.mc.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown, false, 1);
		Main.mc.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp, false, 1);
		
		progressTimer = new Timer(50);
		progressTimer.addEventListener(TimerEvent.TIMER,updateProgress);
		progressTimer.start();
		prevTime = flash.Lib.getTimer();
		
		body = new Array();
		bodySize = 20;
		step = 0;
		
		//controlType = angleControl;
		
	}
	
	
	
	public function updateProgress(e:TimerEvent) {
		if ((head.x < 25)||(head.x>575)||(head.y < 25)||(head.y >525)) {
			Main.gameOver();
			return;
		}
			
		var turnQual : Float = 0.3;
		switch (controlType) {
			case angleControl:
				if (turn==turnLeft) 
					direction -= turnQual;
					else if (turn==turnRight)
						direction += turnQual;
		}

		step++;

	//	if (step==0) 
			body.unshift(new BodyPart(head.x, head.y));

		
		var time : Int;
		time =  flash.Lib.getTimer();
		time -= prevTime;
		var speedReducer = 7;
		head.x += Math.cos(direction)* time/ speedReducer;
		head.y += Math.sin(direction) * time/ speedReducer;
		head.rotation = direction * 180 / Math.PI;
		prevTime = flash.Lib.getTimer();
		
		
		var tmp : BodyPart;
		while (body.length > bodySize) {
			tmp = body.pop();
			Main.mc.stage.removeChild(tmp.part);
		}
		
		var reducer:Float;
		
		for (i in 1...(this.body.length)) {
			reducer = (15 - 13*(i / this.body.length))+5;
			this.body[i].shrink(reducer);
		}
		
		var i : Int;
		for (i in 10...(this.body.length)) 
			if (this.body[i] != null)
				this.body[i].areWeTouched();
		//var pmat : Matrix = new Matrix();
		//pmat.scale(0.5, 0.5);
		//pmat.tx = 150;
		//pmat.ty = 150;
		//var tmpTransform = new Transform();
		//tmpTransform.matrix = pmat;
		//this.body[10].part.transform.matrix = pmat;
			//
		/*
		if (Scores.score>=800) 
			Scores.update(Math.floor((bodySize/10)));
		*/
	}
	
	public function keyDown(e:KeyboardEvent) {
		//trace(e.keyCode);
		
		switch (controlType) {
			case angleControl:
				if (e.keyCode == 37 || e.keyCode == 65)
					turn = turnLeft;
					else if(e.keyCode == 39 || e.keyCode == 68)
						turn = turnRight;
			case directionControl:
				switch (e.keyCode) {
					case 37, 65:
						if (direction == 0)
							Main.gameOver();
						direction = 3.14;
					case 40, 83:
						if (direction == 1.5 * 3.14)
							Main.gameOver();
						direction = 0.5 * 3.14;
					case 39, 68:
						if (direction == 3.14)
							Main.gameOver();
						direction = 0;
					case 38, 87:
						if (direction == 0.5 * 3.14)
							Main.gameOver();
						direction = 1.5 * 3.14;
				}
			
		}

	}
	
	public function keyUp(e:KeyboardEvent) {
		switch (controlType) {
			case angleControl:
				if (e.keyCode == 37 || e.keyCode == 65)
					if (turn == turnLeft) 
						turn = noTurn;
				if(e.keyCode == 39 || e.keyCode == 68)
					if (turn == turnRight)
						turn = noTurn;
			
		}
		
	}

	public function stop() {
		var tmp : BodyPart;
	
		while (this.body.length>0) {
			tmp = this.body.shift();
			Main.mc.stage.removeChild(tmp.part);	
		}

		this.progressTimer.removeEventListener(TimerEvent.TIMER,this.updateProgress);
		
		Main.mc.stage.removeChild(this.head);
		
		Main.mc.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.keyDown);
		Main.mc.stage.removeEventListener(KeyboardEvent.KEY_UP, this.keyUp);
	}
	
}