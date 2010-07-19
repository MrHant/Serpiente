package serpiente;


import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.Stage;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.events.KeyboardEvent;
import flash.events.TimerEvent;
import flash.display.Graphics;
import flash.trace.Trace;
import flash.utils.Timer;
import flash.xml.XML;

import serpiente.SButton;
import serpiente.Scores;
import serpiente.StartPage;

/**
 * ...
 * @author MrHant
 */

class Main 
{
	public static var wrapper: Dynamic;
	public static var mc : MovieClip = flash.Lib.current;
	public static var stage : Stage = mc.stage;

	public static var bonusSpawner : Timer;
	public static var snake : Snake;
	public static var scoreField:TextField;
	public static var gameOverFlag: Bool=false;

	
	
	static function main() 
	{

#if debug
		onAddedToStage();
#else
		Lib.current.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage	); 
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
			
			DataProvider.getViewerId();
			
			new Scores();
			new StartPage();
			StartPage.show(); 	
			
			
			bonusSpawner = new Timer(2000); // 2000
			bonusSpawner.addEventListener(TimerEvent.TIMER, Bonus.spawn);
			bonusSpawner.stop();
      	});
		
		// Add Friends
		but3.but.addEventListener(MouseEvent.CLICK, function(e: MouseEvent) {
      		Main.wrapper.external.showInviteBox();
      	});
		
		// Add to page
		but4.but.addEventListener(MouseEvent.CLICK, function(e: MouseEvent) {
      		Main.wrapper.external.showInstallBox();
      	});
	}
	public static function startGame(e:MouseEvent) {
		StartPage.hide();
		gameOverFlag = false;
		if (Scores.score > 0)
			Main.mc.stage.removeChild(Main.scoreField);

		switch (e.currentTarget.x) {
			case 30:
				Snake.controlType = Snake.directionControl;
			case 270:
				Snake.controlType = Snake.angleControl;
		}
		
		snake = new Snake();

		Scores.score = 0;
		Scores.update(0);
		//Scores.hide();
		
		bonusSpawner.start();
	}
	
	
	public static function gameOver() {
		gameOverFlag = true;
		var score: Int = Scores.score;
		
		scoreField = new TextField();
		scoreField.defaultTextFormat = new TextFormat("Arial", 30, 0x00AACC, 1, 1);
		scoreField.text = Std.string("Поздравляю! Ваш счет: "+score);
		scoreField.x = 50;
		scoreField.y = 80;
		scoreField.width = 500;
		if (score>0)
			Main.mc.stage.addChild(scoreField);		
		
		DataProvider.setUserScore(Scores.score);

		trace("Game Over");
		
		StartPage.show();
		//Scores.show();
		


		bonusSpawner.stop();
		snake.stop();

	}
	

}