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

	public function new(x: Int, y:Int, str:String,size:Int=40) 
	{
		but = new SimpleButton(Lib.attach("SButtonBG"));
		but.overState = Lib.attach("SButtonAnimation");
		but.hitTestState = Lib.attach("SButtonPlaceholder");
		but.useHandCursor = true;
		but.x = x;
		but.y = y;
		
		var txt : TextField = new TextField();
		txt.defaultTextFormat = new TextFormat("Monotype Corsiva",size,5983628);
		txt.text = str;
		txt.x = x + 150;
		txt.y = y+40-size;
		txt.width = 300;
		txt.selectable = false;
		
		Main.mc.stage.addChild(txt);
		
		Main.mc.stage.addChild(but);
	}
	
}