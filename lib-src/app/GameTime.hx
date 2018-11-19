package app;

import cpp.Float32;

@:allow(app.Dxtk)
class GameTime {
    public var fps(default, null):Int = 0;
    public var stamp(get, null):Float;
    public var elapsedTime(default, null):Float = 0.0;
    public var deltaTime(default, null):Float = 0.0;

    private var totalFrames:Int = 0;
    private var previousTime:Float = 0.0;
    private var currentTime:Float = 0.0;

    private function new () {}

    private function begin ():Void {
        currentTime = haxe.Timer.stamp();
        deltaTime = (currentTime - previousTime);
        
        elapsedTime += deltaTime;
        if (elapsedTime >= 1.0) {
            fps = totalFrames;
            totalFrames = 0;
            elapsedTime = 0;
        }
        totalFrames++;
    }

    private function end ():Void {
        previousTime = currentTime;
    }

    private inline function get_stamp ():Float {
        return haxe.Timer.stamp();
    }
}