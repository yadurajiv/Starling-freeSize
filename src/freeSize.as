package  
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	[SWF(frameRate="60", backgroundColor="0x000000")]
	public class freeSize extends Sprite
	{
		private var _starling:Starling;
		
		public function freeSize() 
		{
			// Setup the stage
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// Setup starling
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = true;
			
			// Set base dimensions
			var targetStageWidth:int = 960;
			var targetStageHeight:int = 540;
			
			// Get the stage dimensions
			var stageWidth:int = stage.stageWidth;
			var stageHeight:int = stage.stageHeight;
			
			// Check if mobile and set screen dimensions
			if ((Capabilities.version.substr(0, 3) == "IOS") || (Capabilities.version.substr(0, 3) == "AND"))
			{
				stageWidth = stage.fullScreenWidth;
				stageHeight = stage.fullScreenHeight;
			}
			
			// target/base screen size
			var targetRect:Rectangle = new Rectangle(0, 0, targetStageWidth, targetStageHeight);
			
			// current screen size
			var stageRect:Rectangle = new Rectangle(0, 0, stageWidth, stageHeight);
			
			// scale and fit target/base screen in current screen - with letterboxing
			var viewport:Rectangle = RectangleUtil.fit(targetRect, stageRect, ScaleMode.SHOW_ALL, false);

			// move view port to (0,0) after fit
			viewport.x = viewport.y = 0;
			
			// calculate scale value to scale the difference in height/width (the letterbox size) 
			var scale:Number = Math.max(targetStageWidth/stageWidth,targetStageHeight/stageHeight);
			
			// debug
			trace("target size: " + targetRect);
			trace("screen size: " + stageRect);
			trace("target fit into screen with letterbox: " + viewport);
			trace("(stageRect.width - viewport.width): " + (stageRect.width - viewport.width));
			trace("(stageRect.height - viewport.height): " + (stageRect.height - viewport.height));
			trace("scale: " + scale);
			
			// Create instance, we are using stageRect and not viewport because we will 
			// add the scaled difference (stageRect - viewport) to our stageWidth/stageHeight 
			// so stageRect is full device screen width/height!!
			_starling = new Starling(game, stage, stageRect);

			_starling.simulateMultitouch = false;
			_starling.antiAliasing = 16;
			
			// usually the difference in width will be 0 since fit() fits it in width first
			_starling.stage.stageWidth  = targetStageWidth + Math.round((stageRect.width - viewport.width) * scale);
			// extra height is added to the bottom of the rect.
			_starling.stage.stageHeight = targetStageHeight + Math.round((stageRect.height - viewport.height) * scale);
			
			// Start starling
			_starling.start();
			
			// Listen for application activate
			NativeApplication.nativeApplication.addEventListener(
				Event.ACTIVATE, function (e:*):void { _starling.start(); });
			
			// Listen for application deactivate
			NativeApplication.nativeApplication.addEventListener(
				Event.DEACTIVATE, function (e:*):void { _starling.stop(true); });
		}
		
	}
	
}