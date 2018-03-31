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
class GameOverState extends FlxState
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
		
		/*Reg.paladinAnim.x = 160;
		Reg.paladinAnim.y = 160;
		add(Reg.paladinAnim);
		Reg.paladinAnim.animation.play("idle");*/
		
		Reg.deadSprite = new FlxSprite(192,192,Reg.skeleton);
		add(Reg.deadSprite);
		
		Reg.text = new FlxText(450,5,210,"Game Over");
		Reg.text.size = 40;
		add(Reg.text); 
		
		Reg.healthText = new FlxText(450,120,200,"Health: 0");
		Reg.healthText.size = 30;
		add(Reg.healthText); 
		
		Reg.scoreText = new FlxText(450,170,200,"Score: "+Reg.score);
		Reg.scoreText.size = 30;
		add(Reg.scoreText); 
		
		if(Reg.score > Reg.highScore)
		{
			Reg.highScore = Reg.score;
		}
		
		Reg.scoreText = new FlxText(450,200,200,"High Score: "+Reg.highScore);
		Reg.scoreText.size = 30;
		add(Reg.scoreText); 
		
		Reg.button = new FlxButton(450, 260, "Play Again", goToGame);
		Reg.button.loadGraphic(Reg.buttonImg,true,false,160,40);
		Reg.button.label = new FlxText(0,0,160,"Play Game");
		Reg.button.label.setFormat(null, 22, 0xffffff, "center");
		add(Reg.button);
		
		Reg.text = new FlxText(450,330,180,"Credits");
		Reg.text.size = 24;
		add(Reg.text); 
		
		Reg.text = new FlxText(450,360,180,"Game Design, Programming, Some Art: Zachary Knight");
		Reg.text.size = 16;
		add(Reg.text); 
		
		Reg.text = new FlxText(450,430,180,"Game Art: Willis Knight");
		Reg.text.size = 16;
		add(Reg.text); 
		
		FlxG.sound.play("assets/sounds/player_dies.wav");
		
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
