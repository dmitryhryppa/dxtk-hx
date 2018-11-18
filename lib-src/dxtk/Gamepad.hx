package dxtk;

/**
 * ...
 * @author Dmitry Hryppa	http://themozokteam.com/
 */

@:unreflective
@:include('GamePad.h')
@:native('cpp::Pointer<DirectX::GamePad>')
extern class Gamepad {
    @:native('ptr->GetState') public function getState(player:Int):GamepadState;
    @:native('ptr->SetVibration') public function setVibration(player:Int, leftMotor:Float, rightMotor:Float, ?leftTrigger:Float, ?rightTrigger:Float):Void;
    @:native('destroy') public function destroy():Void;
}

@:unreflective
@:include('GamePad.h')
@:native('DirectX::GamePad::State')
@:structAccess
extern class GamepadState {
    @:native('IsConnected') public function isConnected():Bool;
    
    @:native('IsAPressed') public function isAPressed():Bool;
    @:native('IsBPressed') public function isBPressed():Bool;
    @:native('IsXPressed') public function isXPressed():Bool;
    @:native('IsYPressed') public function isYPressed():Bool;
    
    @:native('IsLeftStickPressed') public function isLeftStickPressed():Bool;
    @:native('IsRightStickPressed') public function isRightStickPressed():Bool;
    
    @:native('IsLeftShoulderPressed') public function isLeftShoulderPressed():Bool;
    @:native('IsRightShoulderPressed') public function isRightShoulderPressed():Bool;
    
    @:native('IsBackPressed') public function isBackPressed():Bool;
    @:native('IsViewPressed') public function isViewPressed():Bool;
    @:native('IsStartPressed') public function isStartPressed():Bool;
    @:native('IsMenuPressed') public function isMenuPressed():Bool;
    
    @:native('IsDPadDownPressed') public function isDPadDownPressed():Bool;
    @:native('IsDPadUpPressed') public function isDPadUpPressed():Bool;
    @:native('IsDPadLeftPressed') public function isDPadLeftPressed():Bool;
    @:native('IsDPadRightPressed') public function isDPadRightPressed():Bool;
    
    @:native('IsLeftThumbStickUp') public function isLeftThumbStickUp():Bool;
    @:native('IsLeftThumbStickDown') public function isLeftThumbStickDown():Bool;
    @:native('IsLeftThumbStickLeft') public function isLeftThumbStickLeft():Bool;
    @:native('IsLeftThumbStickRight') public function isLeftThumbStickRight():Bool;
    
    @:native('IsRightThumbStickUp') public function isRightThumbStickUp():Bool;
    @:native('IsRightThumbStickDown') public function isRightThumbStickDown():Bool;
    @:native('IsRightThumbStickLeft') public function isRightThumbStickLeft():Bool;
    @:native('IsRightThumbStickRight') public function isRightThumbStickRight():Bool;
    
    @:native('IsLeftTriggerPressed') public function isLeftTriggerPressed():Bool;
    @:native('IsRightTriggerPressed') public function isRightTriggerPressed():Bool;
}
