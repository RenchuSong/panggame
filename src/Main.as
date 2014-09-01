package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.IMEConversionMode;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author renchu
	 */
	[SWF(width="800", height="500", backgroundColor="0xeeeeff")]
	public class Main extends Sprite 
	{
		private var scoreA:ScoreBoard, scoreB:ScoreBoard;
		private var tipPanel:TipPanel;
		private var paddleA:Paddle, paddleB:Paddle;
		private var ball:Ball;
		
		private var driver:Timer;
		
		private var status:int;	// 0: hint  1: during game
		
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
			driver = new Timer(15);
			
			tipPanel.controllHint();
			controllHintGame();
		}
		
		private function dispatchElements(width:int, height:int):void 
		{
			scoreA = new ScoreBoard(width / 4, 20);
			scoreB = new ScoreBoard(width / 4 * 3, 20);
			this.addChild(scoreA);
			this.addChild(scoreB);
			
			paddleA = new Paddle(40, height / 2, 20, 80, height, 0xff0000);
			paddleB = new Paddle(width - 40, height / 2, 20, 80, height, 0x00ff00);
			this.addChild(paddleA);
			this.addChild(paddleB);
			
			ball = new Ball(width / 2, height / 2, 20, 0xff00ff);
			this.addChild(ball);
			
			tipPanel = new TipPanel(width / 2, height / 2);
			this.addChild(tipPanel);
			
		}
		
		private function controllHintGame():void
		{
			status = 0;
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPlayGame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHintGame);
		}
		
		private function startGame():void
		{
			status = 1;
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyHintGame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPlayGame);
			ball.emit();
		}
		
		private function keyHintGame(event:KeyboardEvent):void
		{
			if (event.keyCode == 13) {
				removeChild(tipPanel);
				startGame();
			}
		}
		
		private function keyPlayGame(event:KeyboardEvent):void
		{
			ball.emit();
			if (event.keyCode == 65) {
				paddleA.moveUp();
			}
			if (event.keyCode == 68) {
				paddleA.moveDown();
			}
			if (event.keyCode == 37) {
				paddleB.moveUp();
			}
			if (event.keyCode == 39) {
				paddleB.moveDown();
			}	
		}
	}
	
}