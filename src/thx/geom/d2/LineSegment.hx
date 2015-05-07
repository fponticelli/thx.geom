package thx.geom.d2;

class LineSegment extends Segment<LineSegment> {
  public function new(start : Point, end : Point)
    super(start, end, [start, end]);

  override public function toString()
    return 'LineSegment(${start.x},${start.y},${end.x},${end.y})';
}
