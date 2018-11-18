package dxtk;
import dxtk.math.Vec2f;
import app.Texture2D;

/**
 * ...
 * @author Dmitry Hryppa	http://themozokteam.com/
 */

@:unreflective
@:include('SpriteBatch.h')
@:native('cpp::Pointer<DirectX::SpriteBatch>')
extern class SpriteBatch {
    @:native('ptr->Begin') public function begin (sortMode:SpriteSortMode, blendState:BlendState):Void;
    @:native('ptr->End') public function end ():Void;
    
    public inline function draw (texture:Texture2D, position:Vec2f):Void {
        untyped __cpp__('{0}->ptr->Draw({1}, {2})', this, texture.getView(), position);
    }
}