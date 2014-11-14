package  
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class Player extends MovieClip 
	{
		private var _moveUp:Number;
		private var _moveDown:Number;
		private var _asset:MovieClip;
		private var _moveDirection:String;
		private var _velocity:Number = 5;
		private var _baseSpeed:Number = 5;
		private var _stopAnim:Boolean = false;
		public function Player(asset,moveUp,moveDown) 
		{
			super();
			
			_asset = new asset;
			_moveUp = moveUp;
			_moveDown = moveDown;
			addChild(_asset);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			_asset.gotoAndStop(1);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			this.y = stage.stageHeight / 2;
			if(_asset is Player1)
			{
				x = width * 2;
			}
			else
			{
				x = stage.stageWidth - width * 2;
			}
		}
		
		private function keyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == _moveUp || e.keyCode == _moveDown)
			{
				_moveDirection = "";
			}
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == _moveUp)
			{
				_moveDirection = "up";
			}
			if (e.keyCode == _moveDown)
			{
				_moveDirection = "down";
			}			
		}
		
		public function update()
		{
			if (_moveDirection == "up")
			{
				this.y -= _velocity;
			}
			if (_moveDirection == "down")
			{
				this.y += _velocity;
			}
			
			if (_asset.currentFrame == _asset.framesLoaded)
			{
				if (_stopAnim == true)
				{
					_asset.gotoAndStop(1);
					_stopAnim = false;
				}
				else
				{
					_stopAnim = true;
				}
			}
		}
		
		public function get velocity():Number 
		{
			return _velocity;
		}
		
		public function set velocity(value:Number):void 
		{
			_velocity = value;
		}
		
		public function get asset():MovieClip 
		{
			return _asset;
		}
		
		public function set asset(value:MovieClip):void 
		{
			_asset = value;
		}
		
		public function get baseSpeed():Number 
		{
			return _baseSpeed;
		}
		
		
	}

}