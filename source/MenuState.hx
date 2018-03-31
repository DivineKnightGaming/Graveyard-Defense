package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		Reg.init();
		add(Reg.tileMap);
		#if (cpp || neko)
		//Registry.tileMap.atlas = atlas;
		#end
		
		Reg.paladinAnim.x = 160;
		Reg.paladinAnim.y = 160;
		add(Reg.paladinAnim);
		Reg.paladinAnim.animation.play("idle");
		
		Reg.text = new FlxText(450,5,200,"Graveyard Defense");
		Reg.text.size = 40;
		add(Reg.text); 
		
		Reg.button = new FlxButton(450, 200, "Play Game", goToGame);
		Reg.button.loadGraphic(Reg.buttonImg,true,false,160,40);
		Reg.button.label = new FlxText(0,0,160,"Play Game");
		Reg.button.label.setFormat(null, 22, 0xffffff, "center");
		add(Reg.button);
		
		Reg.text = new FlxText(450,370,180,"Use Arrow keys to attack the monsters as they rise from the graves. Don't let them hit you or you lose life.");
		Reg.text.size = 16;
		add(Reg.text); 
		
	}
	
	private function goToGame():Void
	{
		FlxG.switchState(new PlayState());
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}
