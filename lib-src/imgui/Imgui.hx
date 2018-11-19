package imgui;
import cpp.Float32;
import cpp.Reference;

@:unreflective
@:include('imgui.h')
@:native('ImGui')
extern class Imgui {
    @:native('ImGui::End') public static function end ():Void;
    @:native('ImGui::SameLine') public static function sameLine ():Void;
    
    public static inline function begin (title:String):Void {
        untyped __cpp__('ImGui::Begin({0}.c_str())', title);
    }

    public static inline function text (label:String):Void {
        untyped __cpp__('ImGui::Text({0}.c_str())', label);
    }
    
    public static inline function checkbox (label:String, isEnabled:Bool):Void {
        untyped __cpp__('ImGui::Checkbox({0}.c_str(), &{1})', label, isEnabled);
    }

    public static inline function sliderFloat (label:String, value:Float, min:Float, max:Float):Void {
        untyped __cpp__('ImGui::SliderFloat({0}.c_str(), &((float){1}), (float){2}, (float){3})', label, value, min, max);
    }

    public static inline function showDemoWindow (value:Bool):Void {
        untyped __cpp__('ImGui::ShowDemoWindow(&{0})', value);
    }
}