import flash.display.Sprite;
import flash.display.MovieClip;

class CircleSprite extends MovieClip {
        
        public function new() {
                super();                               
                var circle1:Sprite = new Sprite();
                circle1.graphics.beginFill(0x0000FF);
                circle1.graphics.drawCircle(10, 10, 10);
                addChild(circle1);
        }
	
        static function main() {   
                var circle1:BlueCircle = new BlueCircle();
                flash.Lib.current.addChild(circle1);
        }
}
