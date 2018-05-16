package dxtk;

/**
 * ...
 * @author Dmitry Hryppa	http://themozokteam.com/
 */

@:enum extern abstract SpriteSortMode(Int) {
    @:native('DirectX::SpriteSortMode::SpriteSortMode_Deferred')    var Deferred;
    @:native('DirectX::SpriteSortMode::SpriteSortMode_Immediate')   var Immediate;
    @:native('DirectX::SpriteSortMode::SpriteSortMode_Texture')     var Texture;
    @:native('DirectX::SpriteSortMode::SpriteSortMode_BackToFront') var BackToFront;
    @:native('DirectX::SpriteSortMode::SpriteSortMode_FrontToBack') var FrontToBack;
}