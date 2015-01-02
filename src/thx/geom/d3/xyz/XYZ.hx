package thx.geom.d3.xyz;

import thx.geom.d2.xy.XY;

interface XYZ extends XY extends ITransformable44<XYZ> {
  public var z(get, set) : Float;
}