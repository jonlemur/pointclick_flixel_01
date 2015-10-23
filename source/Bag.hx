package;

import flixel.FlxState;
import flixel.FlxSprite;


class Bag extends FlxState
{
	var bagIMG:FlxSprite;
	
	public function new() 
	{
		super();
		
		bagIMG = new FlxSprite(840, 30);
		bagIMG.loadGraphic("assets/images/bag.png", false, 64, 64);
		add(bagIMG);
	}

}