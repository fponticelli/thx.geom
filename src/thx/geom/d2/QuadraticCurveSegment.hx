package thx.geom.d2;

class QuadraticCurveSegment extends Segment<QuadraticCurveSegment> {
  public var c1(default, null) : Point;
  public function new(start : Point, c1 : Point, end : Point) {
    super(start, end, [start, c1, end]);
    this.c1 = c1;
  }

  override public function equals(other : QuadraticCurveSegment) : Bool
    return super.equals(other) && c1 == other.c1;

  override public function toString()
    return 'QuadraticCurveSegment(${start.x},${start.y},${c1.x},${c1.y},${end.x},${end.y})';
}
