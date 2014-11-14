package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class Menu extends MovieClip 
	{
		private var _startBackground:IntroBackground;
		private var _endBackground:EndScreen;
		private var _startButton:StartButton;
		private var _restartButton:RestartButton;
		private var _title:Title;
		private var _player1Won:Player1Won;
		private var _player2Won:Player2Won;
		private var _whoWonToRemove:Number = 0;
		public function Menu() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_startBackground = new IntroBackground();
			_title = new Title();
			_endBackground = new EndScreen();
			_startButton = new StartButton();
			_restartButton = new RestartButton();
			_player1Won = new Player1Won();
			_player2Won = new Player2Won();
			
			_startButton.x = stage.stageWidth / 2;
			_startButton.y = stage.stageHeight / 2 + _startButton.height;
			_title.x = _startButton.x;
			_title.y = _startButton.y - _title.height;
			_player1Won.x = _title.x;
			_player1Won.y = _title.y;
			_player2Won.x = _title.x;
			_player2Won.y = _title.y;
			_restartButton.x = _startButton.x;
			_restartButton.y = _startButton.y;
			addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (e.target == _startButton)
			{
				trace("GOGOGOGO");
				dispatchEvent(new Event("start" , true));
				removeChild(_startBackground);
				removeChild(_startButton);
				removeChild(_title);
			}
			else if (e.target == _restartButton)
			{
				trace(" also GOGOGOGO");
				dispatchEvent(new Event("start" , true));
				removeChild(_endBackground);
				trace("whotoremove" + _whoWonToRemove);
				if (_whoWonToRemove == 1)
				{
					removeChild(_player1Won);
					trace("player1won");
				}
				if (_whoWonToRemove == 2)
				{
					removeChild(_player2Won);
					trace("player2won");
				}
				
				removeChild(_restartButton);
			}
		}
		
		public function startScreen()
		{
			addChild(_startBackground);
			addChild(_startButton);			
			addChild(_title);			
		}
		
		public function restartScreen(whoWon:Number)
		{
			
			addChild(_endBackground);
			addChild(_restartButton);
			if (whoWon == 1)
			{
				addChild(_player1Won);
				_whoWonToRemove = 1;
			}
			else
			{
				addChild(_player2Won);
				_whoWonToRemove = 2;
			}
		}
		
		
	}

}