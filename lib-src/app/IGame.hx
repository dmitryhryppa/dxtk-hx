package app;
import cpp.Pointer;
import cpp.Star;
import dxtk.CommonStates;
import dxtk.Gamepad;
import dxtk.SpriteBatch;
import dxtk.SpriteSortMode;
import dxtk.MouseState;

/**
 * ...
 * @author Dmitry Hryppa	http://themozokteam.com/
 */

interface IGame {
    //public function loadContent (content:Content):Void;
    public function onGamepadInput (gamepad:Gamepad):Void;
    public function onMouseInput (state:MouseState):Void;
    public function onUpdate (deltaTime:Float):Void;
    public function onDraw (spriteBatch:SpriteBatch, commonStates:CommonStates):Void;
    public function onDebugGUI ():Void;
}