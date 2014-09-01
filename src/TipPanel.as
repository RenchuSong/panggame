package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
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
			pressTip.x = -110;
			pressTip.y = 60;
			this.addChild(pressTip);
			
			var format:TextFormat = new TextFormat();
			format.size = 16;
			format.color = 0x333366;
			
			var format2:TextFormat = new TextFormat();
			format2.size = 20;
			format2.color = 0x000066;
			
			text.defaultTextFormat = format;
			pressTip.defaultTextFormat = format2;
		}
		
		public function controllHint():void
		{
			text.text = "Player A: Press 'A' and 'D' to controll left paddle.\n\nPlayer B: Press 'Left' and 'Right' to controll right paddle.";
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