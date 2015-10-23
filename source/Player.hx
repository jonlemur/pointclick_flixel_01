package;

import flixel.FlxSprite;
import flixel.FlxObject;


class Player extends FlxSprite
{
	public var walking:Bool = false;
	public var facingRight:Bool = true;

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic("assets/images/char01_128x256.png", true, 128, 256);
		animation.add("walk", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 20, true);
		animation.add("idle", [23], false);
		
		animation.play("idle");
		
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
	}
	
	
	public function  setanim():Void
	{
		
		if (walking)
		{
		animation.play("walk");	
		
		if (facingRight)
		{facing = FlxObject.RIGHT; }
		else
		{facing = FlxObject.LEFT; }
		
		}
		else
		{
		animation.play("idle");
		}
		
		
	}
	
	
	
	
}