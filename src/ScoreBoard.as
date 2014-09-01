package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
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
			//scoreText.textHeight = 30;
			//scoreText.textWidth = 20;
			this.addChild(scoreText);
			setPosition(x, y);
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