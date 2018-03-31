package;

import flixel.util.FlxSave;
import flixel.tile.FlxTilemap;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	static public var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	static public var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	static public var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	static public var score:Int = 0;
	static public var highScore:Int = 0;
	/**
	 * Generic bucket for storing different <code>FlxSaves</code>.
	 * Especially useful for setting up multiple save slots.
	 */
	static public var saves:Array<FlxSave> = [];
	
	public static var dkLogo="assets/images/DKGTitleLogo.png";
	public static var dkLogoSp:FlxSprite;
	
	public static var buttonImg = "assets/data/buttondk.png";
	public static var button:FlxButton;
	
	public static var paladinAnimation="assets/images/paladin.png";
	public static var paladinAnim:FlxSprite;
	public static var powImg = "assets/images/pow.png";
	public static var powSprite:FlxSprite;
	
	public static var MapTiles="assets/images/tiles.png";
	public static var map:Array<Int>;
	public static var tileMap:FlxTilemap;
	
	//level 1 monsters
	public static var zombie = "assets/images/zombie.png";
	public static var zombieGirl = "assets/images/zombie_girl.png";
	public static var batSkel = "assets/images/bat_skeleton.png";
	public static var skeleton = "assets/images/skeleton.png";
	public static var ghost = "assets/images/ghost.png";
	//level 2 monsters
	public static var zombieSorceress = "assets/images/zombie_sorceress.png";
	public static var zombieWarrior = "assets/images/zombie_warrior.png";
	public static var skeletonKnight = "assets/images/skeleton_knight.png";
	public static var skeletonMage = "assets/images/skeleton_mage.png";
	public static var ghostArmor = "assets/images/ghost_armor.png";
	public static var ghostMage = "assets/images/ghost_mage.png";
	//level 3 monsters
	public static var deathKnight = "assets/images/death_knight.png";
	public static var deathKnightGirl = "assets/images/death_knight_girl.png";
	public static var mummy = "assets/images/mummy.png";
	public static var mummyGirl = "assets/images/mummy_girl.png";
	public static var demonSkeleton = "assets/images/demon_skeleton.png";
	//level 4 monsters
	public static var death = "assets/images/death.png";
	public static var deathVampira = "assets/images/death_vampira.png";
	public static var deathVampire = "assets/images/death_vampire.png";
	public static var ghostDragon = "assets/images/ghost_dragon.png";
	public static var boneDragon = "assets/images/bone_dragon.png";
	
	public static var monsterSprites:Array<FlxSprite>;
	public static var deadSprite:FlxSprite;
	
	public static var text:FlxText;
	public static var scoreText:FlxText;
	public static var healthText:FlxText;
	
	public static function init()
	{
		map = [
				6 ,1 ,1 ,1 ,1 ,1 ,5 ,
				4 ,10,10,11,10,10,3 ,
				4 ,10,10,9 ,10,10,3 ,
				4 ,11,9 ,10,9 ,11,3 ,
				4 ,10,10,9 ,10,10,3 ,
				4 ,10,10,11,10,10,3 ,
				8 ,2 ,2 ,2 ,2 ,2 ,7 
				];
		
		tileMap = new FlxTilemap();
		tileMap.widthInTiles = 7;
		tileMap.heightInTiles = 7;
		tileMap.loadMap(
			map, 
			MapTiles, 
			64, 
			64, 0,0,0,
			0
		);
		
		paladinAnim = new FlxSprite( 0, 0);
		paladinAnim.loadGraphic(paladinAnimation, true, false, 128, 128);
		paladinAnim.animation.add("idle", [0], 16, true);
		paladinAnim.animation.add("attack_up", [1], 16, true);
		paladinAnim.animation.add("attack_down", [2], 16, true);
		paladinAnim.animation.add("attack_left", [3], 16, true);
		paladinAnim.animation.add("attack_right", [4], 16, true);
		
		monsterSprites = [null,null,null,null];
	}
}
