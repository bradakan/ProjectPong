package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class ScoreUI extends MovieClip 
	{
		private var _board:MovieClip;
		private var _numbers:MovieClip;
		public function ScoreUI(player:Number) 
		{
			super();
			_numbers = new Cijfers();
			if (player == 1)
			{
				_board = new Hud1();
			}
			else { _board = new Hud2(); }
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(_board);
			_numbers.x = _board.width / 2;
			_numbers.y = _board.height / 2;
			addChild(_numbers);
			changeNum(0);
		}
		
		public function changeNum(frame:Number)
		{
			_numbers.gotoAndStop(frame + 1);
		}
		
		public function get board():MovieClip 
		{
			return _board;
		}
	}

}