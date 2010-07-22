/**
 * ...
 * @author MrHant
 */

package serpiente;

import flash.display.MovieClip;
import flash.Lib;
import flash.events.Event;

class Game 
{
	var counter: MovieClip;
	public function new() 
	{
		counter = Lib.attach("counter");
		counter.x = 300;
		counter.y = 275;
#if debug	
		Main.mc.stage.addChild(counter);
#else
		Main.wrapper.addChild(counter);
#end	
		
		counter.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	
	function onEnterFrame(evt:Event) {
		if (evt.target.currentFrame == evt.target.totalFrames) {
#if debug
			Main.mc.stage.removeChild(counter);
#else
			Main.wrapper.removeChild(counter);
#end				
			counter.stop();
			counter.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}