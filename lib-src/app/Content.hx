package app;
import d3d11.ID3D11Device;
import cpp.Star;
import haxe.ds.StringMap;

@:headerCode('
    #include <string>
    #include <d3d11.h>
    #include <DDSTextureLoader.h>
    #include <WICTextureLoader.h>
')
@:allow(app.Dxtk) 
class Content {
    private var device:Star<ID3D11Device>;
    private var textures:StringMap<Texture2D>;

    public function getTexture2D (path:String):Texture2D {
        if (textures.exists(path)) {
            return textures.get(path);
        }
        
        var texture:Texture2D = new Texture2D();
        untyped __cpp__ ('
            wchar_t formatw[4096];
            MultiByteToWideChar(CP_UTF8, 0, path.c_str(), -1, formatw, 4096);
            DirectX::CreateWICTextureFromFile({0}, formatw, nullptr, &{1}->view)',
            device, texture
        );
        textures.set(path, texture);
        return texture;
    }

    @:noPrivateAccess
    private function new () {
        this.textures = new StringMap<Texture2D>();
    }
    
    private static function create (device:Star<ID3D11Device>) {
        var content:Content = new Content();
        content.device = device;
        return content;
    }
}