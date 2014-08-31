package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author renchu
	 */
	[SWF(width="800", height="500")]
	public class Main extends Sprite 
	{
		private var scoreA:ScoreBoard, scoreB:ScoreBoard;
		private var tipPanel:TipPanel;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			dispatchElements(800, 500);
		}
		
		private function dispatchElements(width:int, height:int):void 
		{
			scoreA = new ScoreBoard(width / 4, 20);
			scoreB = new ScoreBoard(width / 4 * 3, 20);
			this.addChild(scoreA);
			this.addChild(scoreB);
			
			tipPanel = new TipPanel(width / 2, height / 2);
			this.addChild(tipPanel);
			tipPanel.playerAWins();
		}
	}
	
}