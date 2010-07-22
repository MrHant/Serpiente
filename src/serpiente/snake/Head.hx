/**
 * ...
 * @author MrHant
 */

package serpiente.snake;

import flash.display.Graphics;
import flash.display.Shape;
import serpiente.Main;


class Head 
{
	var shape: Shape;
	var g: Graphics;
	
	public function new() 
	{
		// init
		shape = new Shape();
		g = shape.graphics;
		
		
		// #Triangle head
		g.beginFill(0xEE00DD);
	    g.moveTo(0, -25);
		g.lineTo(35, 0);
		g.lineTo(0, 25);
		g.lineTo(0, -25);
		
		g.endFill();
		
		shape.x = 100;
		shape.y = 100;
		
		Main.addChild(shape);
	}
	
}