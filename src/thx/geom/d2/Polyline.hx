package thx.geom.d2;

using thx.Arrays;
using thx.Functions;

class Polyline {
  public var box(default, null) : Rect;

  var points : Array<Point>;
  public function new(points : Array<Point>) {
    this.points = points;
    this.box = Rect.fromPoints(this.points);
  }

  public function toString()
    return 'Polyline(${points.map.fn(_.x+","+_.y).join(";")})';
}
