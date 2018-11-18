package imgui;

@:unreflective
@:include('imgui.h')
@:native('ImGui')
extern class Imgui {
    @:native('ImGui::End') public static function end():Void;
    public static inline function begin(title:String):Void {
        untyped __cpp__('ImGui::Begin({0}.c_str())', title);
    }
    public static inline function text(value:String):Void {
        untyped __cpp__('ImGui::Text({0}.c_str())', value);
    }
    public static inline function showDemoWindow(value:Bool):Void {
        untyped __cpp__('static bool _v = {0}; ImGui::ShowDemoWindow(&_v)', value);
    }
}