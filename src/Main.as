package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.IMEConversionMode;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
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
			driver = new Timer(10);
			
			tipPanel.controllHint();
			controllHintGame();
		}
		
		private function game(event:TimerEvent):void
		{
			// check score, judge win
			if (scoreA.win()) {
				tipPanel.playerAWins();
				addChild(tipPanel);
				controllHintGame();
				return;
			}
			if (scoreB.win()) {
				tipPanel.playerBWins();
				addChild(tipPanel);
				controllHintGame();
				return;
			}
			
			var newX:Number = ball.x + ball.dx;
			var newY:Number = ball.y + ball.dy;
			
			// TODO: handle paddle reflect
			if (paddleA.reflectBall(ball, newX, newY)) return;
			if (paddleB.reflectBall(ball, newX, newY)) return;
			
			// handle top & bottom wall reflect
			if (newY < ball.radius / 2) {
				// TODO: hit sound
				ball.dy = -ball.dy;
				ball.x = newX;
				ball.y = ball.radius - newY;
				return;
			}
			if (newY > 500 - ball.radius / 2) {
				// TODO: hit sound
				ball.dy = -ball.dy;
				ball.x = newX;
				ball.y = 1000 - ball.radius - newY;
				return;
			}
			
			// handle outside left or right
			if (newX < 0) {
				// TODO: score sound
				scoreB.addScore();
				ball.reLocate();
				ball.emit();
				return;
			}
			if (newX > 800) {
				// TODO: score sound
				scoreA.addScore();
				ball.reLocate();
				ball.emit();
				return;
			}
			
			// safely move
			ball.x = newX; ball.y = newY;
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
			driver.stop();
			driver.removeEventListener(TimerEvent.TIMER, game);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPlayGame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHintGame);
		}
		
		private function startGame():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyHintGame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPlayGame);
			driver.addEventListener(TimerEvent.TIMER, game);
			paddleA.reLocate();
			paddleB.reLocate();
			scoreA.initScore();
			scoreB.initScore();
			ball.emit();
			driver.start();
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