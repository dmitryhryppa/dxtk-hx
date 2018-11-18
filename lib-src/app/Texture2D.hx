package app;
import d3d11.ID3D11ShaderResourceView;
import cpp.Star;

@:headerCode('
    #include <d3d11.h>
    #include <DDSTextureLoader.h>
    #include <WICTextureLoader.h>
')
@:headerClassCode('
    ID3D11ShaderResourceView *view;
')
@:allow(app.Content) 
class Texture2D {
    public function destroy ():Void {
        untyped __cpp__('delete view');
    }

    @:noPrivateAccess
    private function new () {}

    @:noPrivateAccess
    @:allow(dxtk.SpriteBatch)
    private function getView ():Star<ID3D11ShaderResourceView> {
        return untyped __cpp__('this->view');
    }
}