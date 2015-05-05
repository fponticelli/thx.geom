package thx.geom.d2;

class CubicCurveSegment extends Segment {
  public var c1(default, null) : Point;
  public var c2(default, null) : Point;
  public function new(start : Point, c1 : Point, c2 : Point, end : Point) {
    super(start, end);
    this.c1 = c1;
    this.c2 = c2;
  }

  override public function toString()
    return 'CubicCurveSegment(${start.x},${start.y},${c1.x},${c1.y},${c2.x},${c2.y},${end.x},${end.y})';
}
