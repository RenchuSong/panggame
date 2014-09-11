package 
{
	import flash.display.NativeMenu;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
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
		
		[Embed(source = "start.mp3")]
		private var startMusic:Class;
		
		[Embed(source = "hitwall.mp3")]
		private var hitWallMusic:Class;
		
		[Embed(source = "hitpaddle.mp3")]
		private var hitPaddleMusic:Class;
		
		[Embed(source = "score.mp3")]
		private var scoreMusic:Class;
		
		[Embed(source = "win.mp3")]
		private var winMusic:Class;
		
		private var startSound:Sound, hitWallSound:Sound, scoreSound:Sound, winSound:Sound, hitPaddleSound:Sound;
		
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
			
			stage.frameRate = 60;
			
			tipPanel.controllHint();
			controllHintGame();
			
			startSound = new startMusic() as Sound;
			hitWallSound = new hitWallMusic() as Sound;
			scoreSound = new scoreMusic() as Sound;
			winSound = new winMusic() as Sound;
			hitPaddleSound = new hitPaddleMusic() as Sound;
		}
		
		private function game(event:Event):void
		{
			// check score, judge win
			if (scoreA.win()) {
				tipPanel.playerAWins(scoreA.getScore(), scoreB.getScore());
				addChild(tipPanel);
				controllHintGame();
				winSound.play();
				return;
			}
			if (scoreB.win()) {
				tipPanel.playerBWins(scoreA.getScore(), scoreB.getScore());
				addChild(tipPanel);
				controllHintGame();
				winSound.play();
				return;
			}
			
			var newX:Number = ball.x + ball.dx;
			var newY:Number = ball.y + ball.dy;
			
			// handle paddle reflect
			if (paddleA.reflectBall(ball, newX, newY)) {
				hitPaddleSound.play();
				return;
			}
			if (paddleB.reflectBall(ball, newX, newY)) {
				hitPaddleSound.play();
				return;
			}
			
			// handle top & bottom wall reflect
			if (newY < ball.radius / 2) {
				hitWallSound.play();
				ball.dy = -ball.dy;
				ball.x = newX;
				ball.y = ball.radius - newY;
				return;
			}
			if (newY > 500 - ball.radius / 2) {
				hitWallSound.play();
				ball.dy = -ball.dy;
				ball.x = newX;
				ball.y = 1000 - ball.radius - newY;
				return;
			}
			
			// handle outside left or right
			if (newX < 0) {
				scoreSound.play();
				scoreB.addScore();
				ball.reLocate();
				ball.emit();
				return;
			}
			if (newX > 800) {
				scoreSound.play();
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
			scoreA = new ScoreBoard(width / 4 + 32, height / 2);
			scoreB = new ScoreBoard(width / 4 * 3 - 32, height / 2);
			this.addChild(scoreA);
			this.addChild(scoreB);
			
			paddleA = new Paddle(40, height / 2, 20, 80, height, 0x9999ff);
			paddleB = new Paddle(width - 40, height / 2, 20, 80, height, 0x666699);
			this.addChild(paddleA);
			this.addChild(paddleB);
			
			this.graphics.lineStyle(2, 0xbbbbff);
			for (var i:int = 20; i < height - 20; i += 20) {
				this.graphics.moveTo(width / 2, i);
				this.graphics.lineTo(width / 2, i + 10);
			}
			
			ball = new Ball(width / 2, height / 2, 20, 0x333399);
			this.addChild(ball);
			
			tipPanel = new TipPanel(width / 2, height / 2);
			this.addChild(tipPanel);
		}
		
		private function controllHintGame():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, game);
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPlayGame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHintGame);
		}
		
		private function startGame():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyHintGame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPlayGame);
			paddleA.reLocate();
			paddleB.reLocate();
			scoreA.initScore();
			scoreB.initScore();
			startSound.play();
			ball.emit();
			stage.addEventListener(Event.ENTER_FRAME, game);
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