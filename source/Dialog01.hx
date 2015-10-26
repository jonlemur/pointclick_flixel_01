package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.plugin.MouseEventManager;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;


class Dialog01 extends FlxState
{
	var bg:FlxSprite;
	
	public function new() 
	{
		super();
		
		bg = new FlxSprite(0, 50);
		bg.makeGraphic(550, 150, FlxColor.BLACK);
		bg.alpha = 0.6;
		bg.x = FlxG.width / 2 - bg.width / 2;
		bg.scale.x = 0;
		add(bg);
		FlxTween.tween(bg.scale, { x:1, y:1 }, 0.7, { type:FlxTween.ONESHOT, ease:FlxEase.bounceOut, complete:inittext});
		
	}
	
	
	
	function inittext (tween:FlxTween):Void
	{
	
		var myText:FlxText = new FlxText(bg.x + 50, bg.y + 20, 480, "Bear: Hello there!. Are you lost or something?", 14);
		myText.setFormat("assets/data/ShortStack-Regular.otf", 16);
		add(myText);
		
		var reply01:FlxText = new FlxText(bg.x + 80, bg.y + 70, 200, "- What do you want?", 14);
		reply01.setFormat("assets/data/ShortStack-Regular.otf", 16);
		add(reply01);
		
		var reply02:FlxText = new FlxText(bg.x + 80, bg.y + 100, 200, "- Nice to meet you.", 14);
		reply02.setFormat("assets/data/ShortStack-Regular.otf", 16);
		add(reply02);
		
		MouseEventManager.add(reply01, clicktxt, null, null, null, false, true, false);
		MouseEventManager.add(reply02,clicktxt, null, null, null,false,true,false);
		
	}
	
	function clicktxt (sprite:FlxSprite)
	{trace("click click");	}
	
	
	
}