package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.tile.FlxTilemap;
import openfl.Assets;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.util.FlxPath;
import flixel.group.FlxGroup;


class PlayState extends FlxState
{
	
	var mapBG:FlxSprite;
	private var _mWalls:FlxTilemap;
	
	private var _player:Player;
	
	var goal:FlxPoint;
	var start:FlxPoint;
	
	var mx:Float = 0;
	var my:Float = 0;
	
	private var path:FlxPath;

	override public function create():Void
	{
		super.create();
		
		mapBG = new FlxSprite();
		mapBG.loadGraphic("assets/images/map01.png");
		add(mapBG);
		
		_mWalls = new FlxTilemap();
		_mWalls.loadMap(Assets.getText("assets/data/Maps/tiled01.txt"), "assets/images/tile.png", 16, 16, 0, 1);
		add(_mWalls);
	
		
		_player = new Player(180, 300);
		add(_player);
		
		
		path = new FlxPath();
		goal = new FlxPoint(0,0);
		start = new FlxPoint(_player.x, _player.y);
		
	}
	

	override public function destroy():Void
	{
		super.destroy();
	}


	override public function update():Void
	{
		super.update();
		
		//FlxG.collide(_player, _mWalls);
		
		if (FlxG.mouse.justPressed)
		{
			goal.set(FlxG.mouse.x, FlxG.mouse.y);
			start.set(_player.x, _player.y);
			
			trace(_player.height);
			trace(goal);
			 moveToGoal();
		}
	}	

	private function moveToGoal():Void
	{
		
		// Find path to goal from unit to goal
		var pathPoints:Array<FlxPoint> = _mWalls.findPath(FlxPoint.get(_player.x + _player.width/2, _player.y +_player.height/2), FlxPoint.get(goal.x,goal.y));
	
		
		//Tell unit to follow path
		if (pathPoints != null) 
		{
			path.start(_player, pathPoints);

		}
			
	}
	
	
	
}