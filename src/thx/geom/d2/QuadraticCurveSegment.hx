package thx.geom.d2;

class QuadraticCurveSegment extends LineSegment {
  public var c1(default, null) : Point;
  public function new(start : Point, c1 : Point, end : Point) {
    super(start, end);
    this.c1 = c1;
  }

  override public function toString()
    return 'QuadraticCurveSegment(${start.x},${start.y},${c1.x},${c1.y},${end.x},${end.y})';
}

/*
CubicCurveTo(c1x : Float, c1y : Float, c2x : Float, c2y : Float, dx : Float, dy : Float);
QuadraticCurveTo(c1x : Float, c1y : Float, dx : Float, dy : Float);
ArcTo(rx : Float, ry : Float, xAxisRotate : Float, largeArcFlag : Int, sweepFlag : Int, x : Float, y : Float);
*/
