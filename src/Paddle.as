package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author renchu
	 */
	public class Paddle extends Sprite
	{
		private var centerX:int, centerY:int;
		private var _width:int, _height:int;
		private var paddle:Shape;
		private var stageHeight:int;
		private var moveSlice:int;
		
		public function Paddle(centerX:int, centerY:int, width:int, height:int, stageHeight:int, color:uint) 
		{
			this.centerX = centerX;
			this.centerY = centerY;
			reLocate();
			this._width = width;
			this._height = height;
			paddle = new Shape();
			paddle.graphics.beginFill(color);
			paddle.graphics.drawRect( -width / 2, -height / 2, width, height);
			paddle.graphics.endFill();
			this.addChild(paddle);
			this.stageHeight = stageHeight;
			moveSlice = height * 2 / 3;
		}
		
		public function moveUp():void
		{
			if (y - moveSlice >= height / 2) y -= moveSlice; else y = height / 2;
		}
		
		public function moveDown():void
		{
			if (y + moveSlice <= stageHeight - height / 2) y += moveSlice; else y = stageHeight - height / 2;
		}
		
		public function reLocate():void
		{
			this.x = centerX;
			this.y = centerY;
		}
	}

}