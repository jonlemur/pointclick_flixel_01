package;

import flixel.FlxSprite;

/**
 * ...
 * @author lemur
 */
class Player extends FlxSprite
{


	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		loadGraphic("assets/images/player.png", false, 16, 16);
		//animation.add("walk", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 15, true);

		
	}
	
}