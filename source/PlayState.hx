package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	public var attacking:Bool;
	public var health:Int;
	public var attackTimer:Array<Float>;
	private var _attackInterval:Array<Float>;
	public var enemies:Array<Int>;
	
	private var _spawnTimer:Float;
	private var _spawnInterval:Float = 2.5;
	
	override public function create():Void
	{
		//super.create();
		Reg.init();
		add(Reg.tileMap);
		#if (cpp || neko)
		//Registry.tileMap.atlas = atlas;
		#end
		
		Reg.paladinAnim.x = 160;
		Reg.paladinAnim.y = 160;
		add(Reg.paladinAnim);
		Reg.paladinAnim.animation.play("idle");
		attacking = false;
		
		Reg.score = 0;
		health = 5;
		enemies = [0,0,0,0];
		
		Reg.text = new FlxText(450,5,200,"Graveyard Defense");
		Reg.text.size = 40;
		add(Reg.text); 
		
		Reg.healthText = new FlxText(450,120,200,"Health: "+health);
		Reg.healthText.size = 30;
		add(Reg.healthText); 
		
		Reg.scoreText = new FlxText(450,170,200,"Score: "+Reg.score);
		Reg.scoreText.size = 30;
		add(Reg.scoreText); 
		
		Reg.text = new FlxText(450,370,180,"Use Arrow keys to attack the monsters as they rise from the graves. Don't let them hit you or you lose life.");
		Reg.text.size = 16;
		add(Reg.text); 
		
		this.resetSpawnTimer();
		_attackInterval = [1.0,1.0,1.0,1.0];
		attackTimer = [0,0,0,0];
		this.resetAttackTimer(0);
		this.resetAttackTimer(1);
		this.resetAttackTimer(2);
		this.resetAttackTimer(3);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}
	
	private function endAttacking():Void
	{
		attacking = false;
	}
	
	private function endPow():Void
	{
		Reg.powSprite.kill();
	}
	
	private function pickMonster(x:Int,y:Int,idx:Int):Void
	{
		if(Reg.score < 20)
		{
			switch(FlxRandom.intRanged(0, 4))
			{
				case 0:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.batSkel);
					add(Reg.monsterSprites[idx]);
				case 1:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.skeleton);
					add(Reg.monsterSprites[idx]);
				case 2:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.ghost);
					add(Reg.monsterSprites[idx]);
				case 3:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.zombie);
					add(Reg.monsterSprites[idx]);
				case 4:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.zombieGirl);
					add(Reg.monsterSprites[idx]);
			}
		}
		else if (Reg.score < 40)
		{
			switch(FlxRandom.intRanged(0, 5))
			{
				case 0:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.ghostArmor);
					add(Reg.monsterSprites[idx]);
				case 1:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.ghostMage);
					add(Reg.monsterSprites[idx]);
				case 2:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.skeletonKnight);
					add(Reg.monsterSprites[idx]);
				case 3:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.skeletonMage);
					add(Reg.monsterSprites[idx]);
				case 4:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.zombieSorceress);
					add(Reg.monsterSprites[idx]);
				case 5:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.zombieWarrior);
					add(Reg.monsterSprites[idx]);
			}
		}
		else if (Reg.score < 60)
		{
			switch(FlxRandom.intRanged(0, 4))
			{
				case 0:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.mummy);
					add(Reg.monsterSprites[idx]);
				case 1:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.mummyGirl);
					add(Reg.monsterSprites[idx]);
				case 2:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.deathKnight);
					add(Reg.monsterSprites[idx]);
				case 3:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.deathKnightGirl);
					add(Reg.monsterSprites[idx]);
				case 4:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.demonSkeleton);
					add(Reg.monsterSprites[idx]);
			}
		}
		else
		{
			switch(FlxRandom.intRanged(0, 4))
			{
				case 0:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.ghostDragon);
					add(Reg.monsterSprites[idx]);
				case 1:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.deathVampire);
					add(Reg.monsterSprites[idx]);
				case 2:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.deathVampira);
					add(Reg.monsterSprites[idx]);
				case 3:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.boneDragon);
					add(Reg.monsterSprites[idx]);
				case 4:
					//
					Reg.monsterSprites[idx] = new FlxSprite(x,y,Reg.death);
					add(Reg.monsterSprites[idx]);
			}
		}
	}
	
	private function spawnMonster():Void
	{
		switch(FlxRandom.intRanged(0, 3))
		{
			case 0://top
				if(enemies[0] == 0)
				{
					FlxG.sound.play("assets/sounds/enemy_rise.wav");
					pickMonster(192,128,0);
					enemies[0] = 1;
					resetAttackTimer(0);
					//haxe.Timer.delay(dealDamage, attackTimer);
				}
			case 1://right
				if(enemies[1] == 0)
				{
					FlxG.sound.play("assets/sounds/enemy_rise.wav");
					pickMonster(256,192,1);
					enemies[1] = 1;
					resetAttackTimer(1);
					//haxe.Timer.delay(dealDamage, attackTimer);
				}
				
			case 2://bottom
				if(enemies[2] == 0)
				{
					FlxG.sound.play("assets/sounds/enemy_rise.wav");
					pickMonster(192,256,2);
					enemies[2] = 1;
					resetAttackTimer(2);
					//haxe.Timer.delay(dealDamage, attackTimer);
				}
				
			case 3://left
				if(enemies[3] == 0)
				{
					FlxG.sound.play("assets/sounds/enemy_rise.wav");
					pickMonster(128,192,3);
					enemies[3] = 1;
					resetAttackTimer(3);
					//haxe.Timer.delay(dealDamage, attackTimer);
				}
				
		}
	}
	
	private function dealDamage():Void
	{
		if(enemies[0] == 1 || enemies[1] == 1 || enemies[2] == 1 || enemies[3] == 1)
		{
			health = health - 1;
		}
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		if(FlxG.keys.justPressed.LEFT)
		{
			Reg.paladinAnim.animation.play("attack_left");
			attacking = true;
			haxe.Timer.delay(endAttacking, 500);
			if(enemies[3] == 1)
			{
				FlxG.sound.play("assets/sounds/enemy_hit.wav");
				Reg.monsterSprites[3].kill();
				Reg.score = Reg.score + 1;
				enemies[3] = 0;
			}
			else
			{
				FlxG.sound.play("assets/sounds/player_swing.wav");
			}
		}
		if(FlxG.keys.justPressed.RIGHT)	
		{
			Reg.paladinAnim.animation.play("attack_right");
			attacking = true;
			haxe.Timer.delay(endAttacking, 500);
			if(enemies[1] == 1)
			{
				FlxG.sound.play("assets/sounds/enemy_hit.wav");
				Reg.monsterSprites[1].kill();
				Reg.score = Reg.score + 1;
				enemies[1] = 0;
			}
			else
			{
				FlxG.sound.play("assets/sounds/player_swing.wav");
			}
		}
		if(FlxG.keys.justPressed.UP)
		{
			Reg.paladinAnim.animation.play("attack_up");
			attacking = true;
			haxe.Timer.delay(endAttacking, 500);
			if(enemies[0] == 1)
			{
				FlxG.sound.play("assets/sounds/enemy_hit.wav");
				Reg.monsterSprites[0].kill();
				Reg.score = Reg.score + 1;
				enemies[0] = 0;
			}
			else
			{
				FlxG.sound.play("assets/sounds/player_swing.wav");
			}
		}
		if(FlxG.keys.justPressed.DOWN)	
		{
			Reg.paladinAnim.animation.play("attack_down");
			attacking = true;
			haxe.Timer.delay(endAttacking, 500);
			if(enemies[2] == 1)
			{
				FlxG.sound.play("assets/sounds/enemy_hit.wav");
				Reg.monsterSprites[2].kill();
				Reg.score = Reg.score + 1;
				enemies[2] = 0;
			}
			else
			{
				FlxG.sound.play("assets/sounds/player_swing.wav");
			}
		}
		if(attacking == false)
		{
			Reg.paladinAnim.animation.play("idle");
		}
		if(enemies[0] == 1)
		{
			attackTimer[0] -= FlxG.elapsed;
			if (attackTimer[0] < 0) 
			{			
				FlxG.sound.play("assets/sounds/player_hit.wav");
				Reg.powSprite = new FlxSprite(192,192,Reg.powImg);
				add(Reg.powSprite);
				haxe.Timer.delay(endPow, 500);
				dealDamage();
				resetAttackTimer(0);
			}
		}
		if(enemies[1] == 1)
		{
			attackTimer[1] -= FlxG.elapsed;
			if (attackTimer[1] < 0) 
			{			
				FlxG.sound.play("assets/sounds/player_hit.wav");
				Reg.powSprite = new FlxSprite(192,192,Reg.powImg);
				add(Reg.powSprite);
				haxe.Timer.delay(endPow, 500);
				dealDamage();
				resetAttackTimer(1);
			}
		}
		if(enemies[2] == 1)
		{
			attackTimer[2] -= FlxG.elapsed;
			if (attackTimer[2] < 0) 
			{			
				FlxG.sound.play("assets/sounds/player_hit.wav");
				Reg.powSprite = new FlxSprite(192,192,Reg.powImg);
				add(Reg.powSprite);
				haxe.Timer.delay(endPow, 500);
				dealDamage();
				resetAttackTimer(2);
			}
		}
		if(enemies[3] == 1)
		{
			attackTimer[3] -= FlxG.elapsed;
			if (attackTimer[3] < 0) 
			{			
				FlxG.sound.play("assets/sounds/player_hit.wav");
				Reg.powSprite = new FlxSprite(192,192,Reg.powImg);
				add(Reg.powSprite);
				haxe.Timer.delay(endPow, 500);
				dealDamage();
				resetAttackTimer(3);
			}
		}
		_spawnTimer -= FlxG.elapsed;
		
		if (_spawnTimer < 0) 
		{			
			this.spawnMonster();
			this.resetSpawnTimer();
		}
		Reg.scoreText.text = "Score: " + Reg.score;
		Reg.healthText.text = "Health: " + health;
		
		if(health <= 0)
		{
			haxe.Timer.delay(goToGameOver, 100);
		}
	}	
	
	private function goToGameOver():Void
	{
		FlxG.switchState(new GameOverState());
	}
	
	private function resetAttackTimer(idx:Int):Void 
	{
		attackTimer[idx] = _attackInterval[idx];
		_attackInterval[idx] *= 0.98;
		if (_attackInterval[idx] < 0.1) 
		{
			_attackInterval[idx] = 0.1;
		}
	}
	
	private function resetSpawnTimer():Void 
	{
		_spawnTimer = _spawnInterval;
		_spawnInterval *= 0.98;
		if (_spawnInterval < 0.1) 
		{
			_spawnInterval = 0.1;
		}
	}
}
