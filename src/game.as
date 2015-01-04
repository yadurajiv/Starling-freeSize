package
{

	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite3D;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class game extends Sprite3D
	{
		// our 0.25x, 0.5x, 1x, 1.5x and 2x asset samples
		[Embed(source="../assets/box_025x.png")] public static const box025x:Class;
		[Embed(source="../assets/box_05x.png")] public static const box05x:Class;
		[Embed(source="../assets/box_1x.png")] public static const box1x:Class;
		[Embed(source="../assets/box_15x.png")] public static const box15x:Class;
		[Embed(source="../assets/box_2x.png")] public static const box2x:Class;

		
		public function game()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			// set bg color to red!
			starling.core.Starling.current.stage.color = 0xff0000;
		}
		
		private function onAdded(e:Event):void {
			
			// debug
			trace("Starling contentScaleFactor: " + Starling.current.contentScaleFactor);
			
			// 200x200 quad at 0,200
			var q:Quad = new Quad(200, 200);
			q.setVertexColor(0, 0x000000);
			q.setVertexColor(1, 0xAA0000);
			q.setVertexColor(2, 0x00FF00);
			q.setVertexColor(3, 0x0000FF);
			addChild ( q );
			q.x = 200;
			
			// texture holder
			var tex:Texture;
			
			// track scale factor
			var scaleFactor:Number = 1;
			
			// decide what texture set to use
			if(Starling.current.contentScaleFactor >= 1.5) { // 2x
				tex = Texture.fromBitmap(new box2x(),true, false, 2);
				scaleFactor = 2;
			} else if(Starling.current.contentScaleFactor >= 1.2) { // 1x
				tex = Texture.fromBitmap(new box15x(), true, false, 1.5);
				scaleFactor = 1.5;
			} else if(Starling.current.contentScaleFactor >= 0.7) { // 1x
				tex = Texture.fromBitmap(new box1x(), true, false, 1);
				scaleFactor = 1;
			} else  if(Starling.current.contentScaleFactor >= 0.4) { // 0.5x
				tex = Texture.fromBitmap(new box05x(), true, false, 0.5);
				scaleFactor = 0.5;
			} else  if(Starling.current.contentScaleFactor < 0.4) { // 0.25x
				tex = Texture.fromBitmap(new box025x(), true, false, 0.25);
				scaleFactor = 0.25;
			}
			
			// image placed at 0,0 - top left corner
			var i:Image = new Image(tex);
			addChild(i);
			
			// image placed at 960 - 200 - right corner - width of tex
			var j:Image = new Image(tex);
			addChild(j);
			j.x = (960-200);
			
			// image placed at bottom left - 540 - 200 - safe height - height of tex - for non 16:9 ratios stageHeight will be > 540
			var k:Image = new Image(tex);
			addChild(k);
			k.y = (540-200);
			
			// image placed at bottom right
			var l:Image = new Image(tex);
			addChild(l);
			l.x = (960-200);
			l.y = (540-200);
			
			// debug
			trace("Stage size is  " + Starling.current.stage.stageWidth + " x " + Starling.current.stage.stageHeight);
			
			// a 200x200 starling text field placed after  400, 0
			var t:TextField = new TextField(200,200,"Hello Starling!\nStage size is\n" + Starling.current.stage.stageWidth + " x " + Starling.current.stage.stageHeight + "\n@" + Capabilities.screenDPI + " DPI" ,"Helvetica", 20, 0xffffff);
			addChild(t);
			t.x = 400;

		}
	
	}
}