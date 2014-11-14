package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class BallScript extends MovieClip 
	{
		private var _baseSpeed:Number = 5;
		private var _velocityX:Number = 5;
		private var _velocityY:Number = 5;
		private var _oldX:Number;
		private var _oldY:Number;
		private var _asset:Ball = new Ball();
		
		public function BallScript() 
		{
			super();
			addChild(_asset);
		}
		
		public function update()
		{
			this.x += _velocityX;
			this.y += _velocityY;
		}
		
		public function get velocityX():int 
		{
			return _velocityX;
		}
		
		public function set velocityX(value:int):void 
		{
			_velocityX = value;
		}
		
		public function get velocityY():int 
		{
			return _velocityY;
		}
		
		public function set velocityY(value:int):void 
		{
			_velocityY = value;
		}
		
		public function get baseSpeed():int 
		{
			return _baseSpeed;
		}
		
		public function set baseSpeed(value:int):void 
		{
			_baseSpeed = value;
		}
		
	}

}