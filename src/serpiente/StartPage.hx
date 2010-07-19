/**
 * ...
 * @author MrHant
 */

package serpiente;


import flash.display.Sprite;
import flash.display.BitmapData;
import serpiente.LibraryClasses;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.MouseEvent;
import flash.display.Graphics;
import flash.display.Shape;

class StartPage 
{
	static var tf :TextField = new TextField();
	public static var playBtn : TextField = new TextField();
	public static var playBtnSprite : Sprite = new Sprite();
	static var wasd : Sprite = new Sprite();
	static var ad : Sprite = new Sprite();
	static var field : Shape = new Shape();


	public function new() 
	{
		tf.defaultTextFormat = new TextFormat("Arial", 50, 0xFF00DD);
		tf.x = 130;
		tf.y = 20;
		tf.text = "Serpiente";
		tf.selectable = false;
		tf.width = 400;
		tf.height = 80;
		Main.mc.stage.addChild(tf);
		
		playBtn.defaultTextFormat = new TextFormat("Verdana", 25, 0x000000, 1, 1, 0);
		playBtn.text = "Выбери управление:";
		playBtn.selectable = false;
		playBtn.width = 320;
		playBtn.height = 40;
		playBtn.x = 95;
		playBtn.y = 120;
		playBtnSprite.addChild(playBtn);
/*		
		playBtnSprite.graphics.beginBitmapFill(bitmapData);
        playBtnSprite.graphics.drawRect(bitmapData.rect.x, bitmapData.rect.y, bitmapData.rect.width, bitmapData.rect.height);
        playBtnSprite.graphics.endFill();
*/

		
		
		var wasdImg:BitmapData = new WASD_png();
		var adImg:BitmapData = new AD_png();
		
		wasd.addChild(new flash.display.Bitmap( wasdImg, flash.display.PixelSnapping.AUTO, true ));
		ad.addChild(new flash.display.Bitmap( adImg, flash.display.PixelSnapping.AUTO, true ));
	   
		ad.x = 270;  ad.y = 170;
		wasd.x = 30; wasd.y = 170;
		ad.buttonMode = true; ad.useHandCursor = true;
		wasd.buttonMode = true; wasd.useHandCursor = true;

		wasd.addEventListener(MouseEvent.CLICK, Main.startGame);
		ad.addEventListener(MouseEvent.CLICK, Main.startGame);
		
		var fieldGraphics : Graphics = field.graphics;
		// # draws field border
		fieldGraphics.moveTo(0, 0);
		fieldGraphics.lineStyle(3, 0xFF0000, 0.7);
		fieldGraphics.lineTo(0, 499);
		fieldGraphics.lineTo(499, 499);
		fieldGraphics.lineTo(499, 0);
		fieldGraphics.lineTo(0, 0);
		Main.mc.stage.addChild(field);
		Main.mc.stage.addChild(Scores.scoreField);

	}
	
	public static function show() {
		flash.Lib.current.addChild(wasd);
		flash.Lib.current.addChild(ad);
		Main.mc.stage.addChild(playBtnSprite);
		Main.mc.stage.addChild(tf);
		Main.mc.stage.removeChild(field);
		Main.mc.stage.removeChild(Scores.scoreField);
		Scores.show();
	}
	
	public static function hide() {
		flash.Lib.current.removeChild(wasd);
		flash.Lib.current.removeChild(ad);
		Main.mc.stage.removeChild(playBtnSprite);
		Main.mc.stage.removeChild(tf);



		Main.mc.stage.addChild(field);
		Main.mc.stage.addChild(Scores.scoreField);
		Scores.hide();
		
		
		Main.mc.stage.focus = Main.stage;
	}
	
}