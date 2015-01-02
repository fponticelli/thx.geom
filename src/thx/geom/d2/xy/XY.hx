package thx.geom.d2.xy;

import thx.geom.ITransformable44;

interface XY extends ITransformable44<XY> {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
}