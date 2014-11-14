package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class Main extends Sprite 
	{
		
		private var _Player1:Player;
		private var _Player2:Player;
		private var _ball:BallScript;
		private var _background:BackgroundClip;
		private var _globalSpeed:Number = 1;
		private var _scorePlayer1:Number = 0;
		private var _scorePlayer2:Number = 0;
		private var _scoreUIPlayer1:ScoreUI = new ScoreUI(1);
		private var _scoreUIPlayer2:ScoreUI = new ScoreUI(2);
		private var _menu:Menu;
		private var _startTimer:Timer;
		private var _gameBool:Boolean = false;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event = null):void 
		{
			
			_background = new BackgroundClip();
			addChild(_background);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_Player1 = new Player(Player1,87,83);
			_Player2 = new Player(Player2, 38, 40);
			_startTimer = new Timer(1000,1);
			_menu = new Menu();
			_ball = new BallScript();
			_ball.x = stage.stageWidth / 2;
			_ball.y = stage.stageHeight / 2;
			_scoreUIPlayer1.x = stage.stageWidth - _scoreUIPlayer1.board.width - 100;
			_scoreUIPlayer2.x = 100;
			addChild(_Player1);
			addChild(_Player2);
			addChild(_scoreUIPlayer1);
			addChild(_scoreUIPlayer2);
			addChild(_ball);
			addChild(_menu);
			_menu.startScreen();
			addEventListener("start", startTimer);
			addEventListener(Event.ENTER_FRAME, gameLoop);
			_startTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startGame);
		}
		
		private function startTimer(e:Event):void 
		{
			_startTimer.start();
			stage.focus = stage;
		}
		
		private function startGame(e:Event):void 
		{
			_gameBool = true;
		}
		
		private function gameLoop(e:Event):void 
		{
			if (_gameBool == true)
			{
				if (_ball.y > stage.stageHeight - _ball.height /2 || _ball.y < _ball.height / 2)
				{
					_ball.velocityY = -_ball.velocityY;
				}
				if (_ball.x < _ball.width / 2)
				{
					//resetSpeeds + 1 point for player1
					_scorePlayer1++;
					_scoreUIPlayer1.changeNum(_scorePlayer1);
					resetSpeeds();
					if (_scorePlayer1 > 9)
					{
						loose();
					}
				}
				else if (_ball.x > stage.stageWidth - _ball.width /2)
				{
					//resetSpeeds + 1 point for player2
					_scorePlayer2++;
					_scoreUIPlayer2.changeNum(_scorePlayer2);
					resetSpeeds();
					if (_scorePlayer2 > 9)
					{
						loose();
					}
				}
				
				_ball.update();
				_Player1.update();
				_Player2.update();
				
				
				
				if (_Player1.hitTestObject(_ball) || _Player2.hitTestObject(_ball))
				{
					_globalSpeed += 0.1;
					if (_Player1.hitTestObject(_ball))
					{
						var diff :int;
						diff = _ball.y - _Player1.y;
						_ball.velocityY = _ball.baseSpeed * (_ball.baseSpeed / (_Player1.height / 2) * diff) * _globalSpeed;
						_Player1.velocity = _Player1.baseSpeed * _globalSpeed;
						_Player2.velocity = _Player2.baseSpeed * _globalSpeed;
						_Player1.asset.play();
					}
					if (_Player2.hitTestObject(_ball))
					{
						var diff :int;
						diff = _ball.y - _Player2.y;
						_ball.velocityY = _ball.baseSpeed * (_ball.baseSpeed / (_Player2.height / 2) * diff) * _globalSpeed;
						_Player1.velocity = _Player1.baseSpeed * _globalSpeed;
						_Player2.velocity = _Player2.baseSpeed * _globalSpeed;
						_Player2.asset.play();
					}
					if (_ball.velocityX > 0) 
					{
						_ball.velocityX = -_ball.baseSpeed * _globalSpeed;
					}
					else
					{
						_ball.velocityX = _ball.baseSpeed * _globalSpeed;
					}
					trace(_globalSpeed);
					trace(_ball.velocityX);
					
					while (_Player1.hitTestObject(_ball) || _Player2.hitTestObject(_ball))
					{
						_ball.update();
					}
					_ball.scaleX *= -1;
				}
			}
		}
		private function resetSpeeds()
		{
			_globalSpeed = 1;
			_Player1.velocity = 5;
			_Player2.velocity = 5;
			//_Player1.y = stage.stageHeight / 2;
			//_Player2.y = stage.stageHeight / 2;
			_ball.x = stage.stageWidth / 2;
			_ball.y = stage.stageHeight / 2;
			
			var temp = Math.floor(Math.random() * 5)
			if (temp == 0)
			{
				_ball.velocityX = _ball.baseSpeed;
				_ball.velocityY = _ball.baseSpeed;
			}
			else if(temp == 1)
			{
				_ball.velocityX = _ball.baseSpeed;
				_ball.velocityY = -_ball.baseSpeed;
			}
			else if(temp == 2)
			{
				_ball.velocityX = -_ball.baseSpeed;
				_ball.velocityY = _ball.baseSpeed;
			}
			else
			{
				_ball.velocityX = -_ball.baseSpeed;
				_ball.velocityY = -_ball.baseSpeed;
			}
			
		}
		
		private function loose()
		{
			//the  < is mirrored because of an error i made in my code
			if (_scorePlayer1 < _scorePlayer2)
			{
				trace("player 1 wins");
				_gameBool = false;
				_menu.restartScreen(1);
				resetGame();
			}
			else
			{
				trace("player 2 wins");
				_gameBool = false;
				_menu.restartScreen(2);
				resetGame();
			}
			
		}
		
		private function resetGame()
		{
			resetSpeeds();
			_Player1.y = stage.stageHeight / 2;
			_Player2.y = _Player1.y;
			_scoreUIPlayer1.changeNum(-1);
			_scoreUIPlayer2.changeNum( -1);
			_scorePlayer1 = 0;
			_scorePlayer2 = 0;
		}
	}
	
}