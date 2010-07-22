package serpiente;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;

import serpiente.SButton;

/**
 * ...
 * @author MrHant
 */

class Main 
{
	public static var wrapper: Dynamic;
	public static var mc : MovieClip = flash.Lib.current;

	
	
	static function main() 
	{

#if debug
		onAddedToStage();
#else
		Lib.current.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage ); 
#end

	}
	public static var but1 : serpiente.SButton;
	public static var but2 : serpiente.SButton;
	public static var but3 : serpiente.SButton;
	public static var but4 : serpiente.SButton;
	
	public function new() {
	}
	
	private static function onAddedToStage(?e:Event)
	{
    	Main.wrapper = Lib.current.parent.parent;
		
		
		var startPageBG = Lib.attach("firstScreen");
		startPageBG.x = -1;
		startPageBG.y = -1;
#if debug
		Main.mc.stage.addChild(startPageBG);
#else
		Main.wrapper.addChild(startPageBG);
#end
		but1 = new serpiente.SButton(200, 150, "Начать игру");
		//but2 = new serpiente.SButton(200, 150, "Справка");
		but3 = new serpiente.SButton(200, 200, "Пригласить друзей",25);
		but4 = new serpiente.SButton(200, 250, "Добавить на страницу",25);
		
		// Start Game
		but1.but.addEventListener(MouseEvent.CLICK, function(e: MouseEvent) {
#if debug
			Main.mc.stage.removeChild(startPageBG);
#else
			Main.wrapper.removeChild(startPageBG);
#end				
			but1.hide();
			//but2.hide();
			but3.hide();
			but4.hide();
			
			var game = new Game();
      	});
		
		but3.but.addEventListener(MouseEvent.CLICK, function(e: MouseEvent) {
      		Main.wrapper.external.showInviteBox();
      	});
		
		but4.but.addEventListener(MouseEvent.CLICK, function(e: MouseEvent) {
      		Main.wrapper.external.showInstallBox();
      	});
	}
	

}