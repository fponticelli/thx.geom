package thx.geom.d2;

class LineSegment implements ISegment {
  public var start(default, null) : Point;
  public var end(default, null) : Point;
  public function new(start : Point, end : Point) {
    this.start = start;
    this.end = end;
  }

  public function toString()
    return 'LineSegment(${start.x},${start.y},${end.x},${end.y})';
}
