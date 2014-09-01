package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author renchu
	 */
	public class TipPanel extends Sprite
	{
		private var text:TextField;
		private var pressTip:TextField;
		
		public function TipPanel(x:int, y:int)
		{
			this.x = x; this.y = y;
			this.graphics.beginFill(0xccccff);
			this.graphics.drawRect(-200, -100, 400, 200);
			this.graphics.endFill();
			text = new TextField();
			text.wordWrap = true;
			text.width = 360;
			text.height = 100;
			text.x = -180;
			text.y = -80;
			this.addChild(text);
			
			pressTip = new TextField();
			pressTip.width = 400;
			pressTip.x = -100;
			pressTip.y = 60;
			this.addChild(pressTip);
		}
		
		public function controllHint():void
		{
			text.text = "Player A: Press 'A' and 'D' to controll left paddle.\nPlayer B: Press 'Left' and 'Right' to controll right paddle.";
			pressTip.text = "Press 'Enter' to start game.";
		}
		
		public function playerAWins(scoreA:int, scoreB:int):void
		{
			text.text = "Player A Wins!\nThe final score is " + scoreA +":"+ scoreB;
			pressTip.text = "Press 'Enter' to restart game.";
		}
		
		public function playerBWins(scoreA:int, scoreB:int):void
		{
			text.text = "Player B Wins!\nThe final score is " + scoreA +":"+ scoreB;
			pressTip.text = "Press 'Enter' to restart game.";
		}
		
	}

}