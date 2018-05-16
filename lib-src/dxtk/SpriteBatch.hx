package dxtk;

/**
 * ...
 * @author Dmitry Hryppa	http://themozokteam.com/
 */

@:unreflective
@:include('SpriteBatch.h')
@:native('cpp::Pointer<DirectX::SpriteBatch>')
extern class SpriteBatch {
    @:native('ptr->Begin') public function begin(?sortMode:SpriteSortMode, ?blendState:BlendState):Void;
    @:native('ptr->End') public function end():Void;
}