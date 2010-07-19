/**
 * ...
 * @author MrHant
 */


package serpiente;


import flash.display.SimpleButton;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class SButton 
{
    public var but : SimpleButton ;
	public var txt : TextField;

	public function new(x: Int, y:Int, str:String,size:Int=40) 
	{
		but = new SimpleButton(Lib.attach("SButtonBG"));
		but.overState = Lib.attach("SButtonAnimation");
		but.hitTestState = Lib.attach("SButtonPlaceholder");
		but.useHandCursor = true;
		but.x = x;
		but.y = y;
		
		txt = new TextField();
		txt.defaultTextFormat = new TextFormat("Monotype Corsiva",size,5983628);
		txt.text = str;
		txt.x = x + 150;
		txt.y = y+40-size;
		txt.width = 300;
		txt.selectable = false;
		
		Main.mc.stage.addChild(txt);
		Main.mc.stage.addChild(but);
	}
	
	public function hide() {
		Main.mc.stage.removeChild(txt);
		Main.mc.stage.removeChild(but);
		
	}
	
	
}