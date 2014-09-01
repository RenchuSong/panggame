package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author renchu
	 */
	public class ScoreBoard extends Sprite
	{
		private var score:int;
		private var scoreText:TextField;
		
		public function ScoreBoard(x:int, y:int):void
		{
			scoreText = new TextField();
			scoreText.height = 200;
			var format:TextFormat = new TextFormat();
			format.size = 128;
			format.color = 0xbbbbff;
			scoreText.defaultTextFormat = format;
			this.addChild(scoreText);
			setPosition(x - 32, y - 64);
			initScore();
		}
		
		public function initScore():void
		{
			score = 0;
			freshScore();
		}
		
		public function addScore():void
		{
			score++;
			freshScore();
		}
		
		private function freshScore():void
		{
			scoreText.text = score.toString();
		}
		
		public function win():Boolean
		{
			return score >= 5;
		}
		
		public function setPosition(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function getScore():int
		{
			return score;
		}
	}

}