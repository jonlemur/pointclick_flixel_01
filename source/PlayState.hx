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
	
	private var _player:PathOBJ;
	private var _playerIMG:Player;
	
	var goal:FlxPoint;
	var start:FlxPoint;
	
	var mx:Float = 0;
	var my:Float = 0;
	
	private var path:FlxPath;

	override public function create():Void
	{
		super.create();
		
		FlxG.mouse.load("assets/images/cursor.png");
		
		mapBG = new FlxSprite();
		mapBG.loadGraphic("assets/images/map01.png");
		add(mapBG);
		
		_mWalls = new FlxTilemap();
		_mWalls.loadMap(Assets.getText("assets/data/Maps/tiled01.txt"), "assets/images/tile2.png", 16, 16, 0, 1);
		add(_mWalls);
	
		
		_player = new PathOBJ(180, 300);
		add(_player);
		
		_playerIMG = new Player(180, 300);
		_playerIMG.scale.set(0.7, 0.7);
		add(_playerIMG);
		
		
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
		_playerIMG.x = _player.x-_playerIMG.width/2;
		_playerIMG.y = _player.y-_playerIMG.height*0.7;
		
		if (FlxG.mouse.justPressed)
		{
			goal.set(FlxG.mouse.x, FlxG.mouse.y);
			start.set(_player.x, _player.y);
			
			if (goal.x < start.x)
			{
				_playerIMG.facingRight = false;
				trace("left");
			}
			else
			{
				_playerIMG.facingRight = true;
				trace("right");
			}
			
			trace(_player.height);
			trace(goal);
			 moveToGoal();
		}
		
		if (path.finished)
		{
			_playerIMG.walking = false;
			_playerIMG.setanim();
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
			
			_playerIMG.walking = true;
			_playerIMG.setanim();
		}
		
		
	}
	
	
	
}