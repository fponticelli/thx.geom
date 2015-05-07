package thx.geom.d2;

using thx.Types;

class Segment<T : Segment<T>> {
  public var start(default, null) : Point;
  public var end(default, null) : Point;
  public var box(default, null) : Rect;
  public function new(start : Point, end : Point, cloud : Iterable<Point>) {
    this.start = start;
    this.end = end;
    this.box = Rect.fromPoints(cloud);
  }

  public function equals(other : T) : Bool
    return this.sameType(other) && start == other.start && end == other.end;

  public function nearEquals(other : T) : Bool
    return this.sameType(other) && start.nearEquals(other.start) && end.nearEquals(other.end);

  public function toVector()
    return Vector.linked(
      function( ) return end.x - start.x,
      function( ) return end.y - start.y,
      function(v) {
        end.x = start.x + v;
        return v;
      },
      function(v) {
        end.y = start.y + v;
        return v;
      }
    );

  public function toString() : String
    return throw 'Segment.toString() is abstract and must be overwritten';
}
