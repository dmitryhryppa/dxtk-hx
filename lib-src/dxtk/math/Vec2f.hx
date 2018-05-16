package dxtk.math;
import cpp.Float32;

/**
 * ...
 * @author Dmitry Hryppa	http://themozokteam.com/
 */

@:unreflective
@:include('SimpleMath_pch.h')
@:native('DirectX::SimpleMath::Vector2')
extern class Vec2f {
    @:native('DirectX::SimpleMath::Vector2') public static function make(x:Float32, y:Float32):Vector2f;
}