package dxtk;


/**
 * ...
 * @author Dmitry Hryppa	http://themozokteam.com/
 */

@:unreflective
@:include('CommonStates.h')
@:native('cpp::Pointer<DirectX::CommonStates>')
extern class CommonStates {
    // Blend states.
    @:native('ptr->Opaque') public function opaque():BlendState;
    @:native('ptr->AlphaBlend') public function alphaBlend():BlendState;
    @:native('ptr->Additive') public function additive():BlendState;
    @:native('ptr->NonPremultiplied') public function nonPremultiplied():BlendState;

    // Depth stencil states.
    @:native('ptr->DepthNone') public function depthNone():Void;
    @:native('ptr->DepthDefault') public function depthDefault():Void;
    @:native('ptr->DepthRead') public function depthRead():Void;
    
    // Rasterizer states.
    @:native('ptr->CullNone') public function cullNone():Void;
    @:native('ptr->CullClockwise') public function cullClockwise():Void;
    @:native('ptr->CullCounterClockwise') public function cullCounterClockwise():Void;
    @:native('ptr->Wireframe') public function wireframe():Void;

    // Sampler states.
    @:native('ptr->PointWrap') public function pointWrap():Void;
    @:native('ptr->PointClamp') public function pointClamp():Void;
    @:native('ptr->LinearWrap') public function linearWrap():Void;
    @:native('ptr->LinearClamp') public function linearClamp():Void;
    @:native('ptr->AnisotropicWrap') public function anisotropicWrap():Void;
    @:native('ptr->AnisotropicClamp') public function anisotropicClamp():Void;
}