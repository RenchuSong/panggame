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
		
		private function interpolate(a:Number, b:Number, r:Number):Number
		{
			return (1 - r) * a + r * b;
		}
		
		public function reflectBall(ball:Ball, newX:int, newY:int):Boolean
		{
			var x1:Number = this.x - this._width / 2 - ball.radius / 2;
			var x2:Number = this.x + this._width / 2 + ball.radius / 2;
			var y1:Number = this.y - this._height / 2 - ball.radius / 2;
			var y2:Number = this.y + this._height / 2 + ball.radius / 2;
			
			// top
			var oldBottom:Number = ball.y;
			var newBottom:Number = newY;
			if (oldBottom <= y1 && newBottom >= y1) {
				var cross:Number = interpolate(ball.x, newX, (y1 - oldBottom) / (newBottom - oldBottom));
				if (cross >= x1 && cross <= x2) {
					ball.dy = -ball.dy;
					ball.x = newX;
					ball.y = y1 * 2 - newBottom;
					return true;
				}
			}
			
			// bottom
			var oldTop:Number = ball.y;
			var newTop:Number = newY;
			if (oldTop >= y2 && newTop <= y2) {
				cross = interpolate(ball.x, newX, (y2 - oldTop) / (newTop - oldTop));
				if (cross >= x1 && cross <= x2) {
					ball.dy = -ball.dy;
					ball.x = newX;
					ball.y = y2 * 2 - newTop;
					return true;
				}
			}
			
			// right
			var oldLeft:Number = ball.x;
			var newLeft:Number = newX;
			if (oldLeft >= x2 && newLeft <= x2) {
				cross = interpolate(ball.y, newY, (x2 - oldLeft) / (newLeft - oldLeft));
				if (cross >= y1 && cross <= y2) {
					ball.dx = -ball.dx;
					ball.y = newY;
					ball.x = x2 * 2 - newLeft;
					return true;
				}
			}
			
			// left
			var oldRight:Number = ball.x;
			var newRight:Number = newX;
			if (oldRight <= x1 && newRight >= x1) {
				cross = interpolate(ball.y, newY, (x1 - oldRight) / (newRight - oldRight));
				if (cross >= y1 && cross <= y2) {
					ball.dx = -ball.dx;
					ball.y = newY;
					ball.x = x1 * 2 - newRight;
					return true;
				}
			}
			
			return false;
		}
	}

}