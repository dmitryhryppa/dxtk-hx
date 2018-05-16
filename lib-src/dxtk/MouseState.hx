package dxtk;

/**
 * ...
 * @author Dmitry Hryppa	http://themozokteam.com/
 */
 
@:unreflective
@:include('Mouse.h')
@:native('DirectX::Mouse::State')
@:structAccess
extern class MouseState {
    @:native('leftButton') public var leftButton:Bool;
    @:native('middleButton') public var middleButton:Bool;
    @:native('xButton1') public var xButton1:Bool;
    @:native('xButton2') public var xButton2:Bool;
    @:native('x') public var x:Int;
    @:native('y') public var y:Int;
    @:native('scrollWheelValue') public var scrollWheelValue:Int;
}