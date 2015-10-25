package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxPath;
import flixel.util.FlxPoint;
import openfl.Assets;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.plugin.MouseEventManager;

class PlayState extends FlxState
{
	//loading sprites and classes
	private var mapBG:FlxSprite;
	private var ping:FlxSprite;
	private var _mWalls:FlxTilemap;
	private var _bag:FlxSprite;
	private var _inventoryBG:FlxSprite;
	private var _player:FlxSprite;
	private var _playerIMG:Player;
	private var _bear:FlxSprite;
	private var dialog:Dialog01;
	
	//pathfinder stuff
	private var goal:FlxPoint;
	private var start:FlxPoint;
	private var path:FlxPath;
	
	// game condition vars
	var movingtothebear:Bool = false;
	var dialogToggle:Bool = false;
	var inventoryToggle:Bool = false;
	var inventoryItems:Array<String>;
	var inventorySprites:Array<FlxSprite>;

	
	override public function create():Void
	{
		super.create();
		
		FlxG.mouse.load("assets/images/cursor.png");
		
		mapBG = new FlxSprite();
		mapBG.loadGraphic("assets/images/map01.png");
		add(mapBG);
		MouseEventManager.add(mapBG, moveToGoal);
		
		ping = new FlxSprite();
		ping.loadGraphic("assets/images/ping.png", false, 64, 64);
		
		_mWalls = new FlxTilemap();
		_mWalls.loadMap(Assets.getText("assets/data/Maps/tiled01.txt"), "assets/images/tile2.png", 16, 16, 0, 1);
		add(_mWalls);
	
		
		_player = new FlxSprite(180, 300);
		_player.loadGraphic("assets/images/tile2.png", false, 16, 16);
		add(_player);
		
		_bear = new FlxSprite(680, 330);
		_bear.loadGraphic("assets/images/player.png", false, 32, 32);
		_bear.ID = 1;
		add(_bear);
		MouseEventManager.add(_bear, moveToBear);
		
		
		
		_playerIMG = new Player(180, 300);
		_playerIMG.scale.set(0.7, 0.7);
		add(_playerIMG);
		
		_bag = new FlxSprite(840, 30);
		_bag.loadGraphic("assets/images/bag.png");
		add(_bag);
		MouseEventManager.add(_bag, openInventory);
		_inventoryBG = new FlxSprite(_bag.x-200, _bag.y+2);
		_inventoryBG.makeGraphic(200, 60, FlxColor.BLACK);
		_inventoryBG.alpha = 0.5;
		_inventoryBG.origin.set(200, 30);
		_inventoryBG.scale.x = 0;
		add(_inventoryBG);
		
		
		path = new FlxPath();
		goal = new FlxPoint(0,0);
		start = new FlxPoint(_player.x, _player.y);
		
		inventoryItems = ["Rock", "Stick", "Bottle"];
		inventorySprites = new Array<FlxSprite>();
		
	}
	

	override public function destroy():Void
	{
		super.destroy();
	}


	override public function update():Void
	{
		super.update();
		
		//move player imager with the player object
		_playerIMG.x = _player.x-_playerIMG.width/2;
		_playerIMG.y = _player.y-_playerIMG.height*0.7;
		
		
		if (path.finished)
		{
			_playerIMG.walking = false;
			_playerIMG.setanim();
			
			if (movingtothebear)
			{
				beardialog();
				movingtothebear = false;
			}
			
		}
		
	}	

	
	private function moveToGoal(sprite:FlxSprite):Void
	{
		ping.x = FlxG.mouse.x - ping.width/2;
		ping.y = FlxG.mouse.y - ping.height/2;
		ping.scale.x = 0;
		ping.scale.y = 0;
		ping.alpha = 1;
		add(ping);
		FlxTween.tween(ping.scale, { x:0.7, y:0.7 }, 0.5, { type:FlxTween.ONESHOT, ease:FlxEase.quadInOut, complete: removePing});
		FlxTween.color(ping, 0.9, FlxColor.WHITE, FlxColor.WHITE, 1, 0, { type:FlxTween.ONESHOT, ease:FlxEase.quadInOut } );
		
		goal.set(FlxG.mouse.x, FlxG.mouse.y);
		start.set(_player.x, _player.y);
		
		//set player facing
		if (goal.x < start.x)
		{_playerIMG.facingRight = false;}
		else
		{_playerIMG.facingRight = true;}
		
		
		// Find path to goal from unit to goal
		var pathPoints:Array<FlxPoint> = _mWalls.findPath(FlxPoint.get(_player.x + _player.width/2, _player.y +_player.height/2), FlxPoint.get(goal.x,goal.y));
	
		
		//Tell unit to follow path
		if (pathPoints != null) 
		{
			path.start(_player, pathPoints);
			
			_playerIMG.walking = true;
			_playerIMG.setanim();
		}
		
			
	}
	
	
	private function moveToBear(sprite:FlxSprite):Void
	{
		movingtothebear = true;
		trace(sprite.ID);
		
		goal.set(sprite.x -50,sprite.y+20);
		start.set(_player.x, _player.y);
		
		//set player facing
		if (goal.x < start.x)
		{_playerIMG.facingRight = false;}
		else
		{_playerIMG.facingRight = true;}
		
		// Find path to goal from unit to goal
		var pathPoints:Array<FlxPoint> = _mWalls.findPath(FlxPoint.get(_player.x + _player.width/2, _player.y +_player.height/2), FlxPoint.get(goal.x,goal.y));
	
		
		//Tell unit to follow path
			path.start(_player, pathPoints);
			
			_playerIMG.walking = true;
			_playerIMG.setanim();
		
	}
	
	
	
	// removing the ping after clicking
	private function removePing(tween:FlxTween):Void
	{
    remove(ping);
	}
	
	
	//Opens dialogbox
	function beardialog():Void
	{	
		dialogToggle = !dialogToggle;
		
		if (dialogToggle)
		{
		dialog = new Dialog01();
		add(dialog);
		}
	}
	
	//all the inventory code
	function openInventory(sprite:FlxSprite):Void
	{
		inventoryToggle = !inventoryToggle;
		
		if (inventoryToggle)
		{
			FlxTween.tween(_inventoryBG.scale, { x:1, y:1 }, 0.3, { type:FlxTween.ONESHOT, ease:FlxEase.quadOut, complete: placeItems});
		}
		else
		{
				for (i in inventorySprites)
			{
				remove(i);
			}
			FlxTween.tween(_inventoryBG.scale, { x:0, y:1 }, 0.3, { type:FlxTween.ONESHOT, ease:FlxEase.quadOut});
		}
		
	}
		
		function placeItems(tween:FlxTween):Void
		{
			
			var placeX = _bag.x;
			var itemframe = 0;
			
			for (i in inventoryItems)
			{	
				placeX -= 64;
				itemframe++;
				var i = new FlxSprite(placeX, _bag.y - 2);
				i.loadGraphic("assets/images/items01.png", false, 64, 64);
				i.animation.frameIndex = itemframe;
				i.scale.set(0, 0);
				inventorySprites.push(i);
				add(i);
				FlxTween.tween(i.scale, { x:1, y:1 }, 0.1);
				
			}
		
		}
		
	
	
}