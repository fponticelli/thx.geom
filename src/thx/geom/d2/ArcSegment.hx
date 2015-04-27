package thx.geom.d2;

import thx.geom.core.Dim;

class ArcSegment extends LineSegment {
  public var radius(default, null) : Vector;
  public var largeArcFlag : Bool;
  public var sweepFlag : Bool;
  public var xAxisRotate(default, null) : Dim;
  public function new(start : Point, radius : Vector, largeArcFlag : Bool, sweepFlag : Bool, xAxisRotate : Dim, end : Point) {
    super(start, end);
    this.radius = radius;
    this.largeArcFlag = largeArcFlag;
    this.sweepFlag = sweepFlag;
    this.xAxisRotate = xAxisRotate;
  }

  override public function toString()
    return 'ArcSegment(sx:${start.x},sy:${start.y},xr:${xAxisRotate.coord},laf:${largeArcFlag},sf:${sweepFlag},ex:${end.x},ey:${end.y})';
}
