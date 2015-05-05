package thx.geom.d2;

using thx.Arrays;

class Polyline {
  public var box(default, null) : Rect;

  var points : Array<Point>;
  public function new(points : Array<Point>) {
    this.points = points;
    this.box = Rect.fromPoints(this.points);
  }

  public function toString()
    return 'Polyline(${points.pluck(_.x+","+_.y).join(";")})';
}
