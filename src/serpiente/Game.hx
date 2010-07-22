/**
 * ...
 * @author MrHant
 */

package serpiente;

import flash.display.MovieClip;
import flash.Lib;

class Game 
{

	public function new() 
	{
		var counter: MovieClip = Lib.attach("counter");
		counter.x = 300;
		counter.y = 275;
#if debug
		Main.mc.stage.addChild(counter);
#else
		Main.wrapper.addChild(counter);
#end	
	}
	
}