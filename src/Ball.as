package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author renchu
	 */
	public class Ball extends Sprite
	{
		private var centerX:int, centerY:int;
		public var radius:int;
		private var ball:Shape;
		public var dx:Number, dy:Number;
		
		public function Ball(x:int, y:int, radius:int, color:uint) 
		{
			this.centerX = x;
			this.centerY = y;
			reLocate();
			this.radius = radius;
			ball = new Shape();
			ball.graphics.beginFill(color);
			ball.graphics.drawRect(-radius / 2, - radius / 2, radius, radius);
			ball.graphics.endFill();
			addChild(ball);
		}
		
		public function reLocate():void
		{
			this.x = centerX; 
			this.y = centerY;
		}
		
		public function emit():void
		{
			var angle:Number = Math.random() * Math.PI * 2 / 6;
			var step:Number = Math.random()*3 + 3;
			dx = Math.cos(angle) * step;
			dy = Math.sin(angle) * step;
			trace(angle + ": " + dx + " " + dy);
			if (Math.random() > 0.5) dx *= -1;
			if (Math.random() > 0.5) dy *= -1;
		}
	}

}