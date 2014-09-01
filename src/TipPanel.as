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
			
			var pressTip:TextField = new TextField();
			pressTip.width = 400;
			pressTip.text = "Press 'Enter' to continue.";
			pressTip.x = -100;
			pressTip.y = 60;
			this.addChild(pressTip);
		}
		
		public function controllHint():void
		{
			text.text = "Player A: Press 'A' and 'D' to controll left paddle.\nPlayer B: Press 'Left' and 'Right' to controll right paddle.";
		}
		
		public function playerAWins():void
		{
			text.text = "Player A Wins!\nCongratulations!";
		}
		
		public function playerBWins():void
		{
			text.text = "Player B Wins!\nCongratulations!";
		}
		
	}

}