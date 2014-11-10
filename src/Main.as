package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class Main extends Sprite 
	{
		
		private var _Player1:Player;
		private var _Player2:Player;
		private var _ball:BallScript;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_Player1 = new Player(Player1,87,83);
			_Player2 = new Player(Player2,38,40);
			_ball = new BallScript();
			_ball.x = stage.stageWidth / 2;
			_ball.y = stage.stageHeight / 2;
			addChild(_Player1);
			addChild(_Player2);
			addChild(_ball);
			
			addEventListener(Event.ENTER_FRAME,gameLoop);
		}
		
		private function gameLoop(e:Event):void 
		{
			if (_ball.y > stage.stageHeight - _ball.height /2 || _ball.y < _ball.height / 2)
			{
				_ball.velocityY = -_ball.velocityY;
			}
			_ball.update();
			_Player1.update();
			_Player2.update();
			
			if (_Player1.hitTestObject(_ball) || _Player2.hitTestObject(_ball))
			{
				if (_Player1.hitTestObject(_ball))
				{
					var diff :int;
					diff = _ball.y - _Player1.y;
					_ball.velocityY = _ball.baseSpeed * (_ball.baseSpeed / (_Player1.height / 2) * diff);
				}
				if (_Player2.hitTestObject(_ball))
				{
					var diff :int;
					diff = _ball.y - _Player2.y;
					_ball.velocityY = _ball.baseSpeed * (_ball.baseSpeed / (_Player2.height / 2) * diff);
				}
				
				_ball.velocityX = -_ball.velocityX;
				while (_Player1.hitTestObject(_ball) || _Player2.hitTestObject(_ball))
				{
					_ball.update();
				}
			}
		}
		
	}
	
}