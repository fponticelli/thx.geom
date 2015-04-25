package thx.geom.d2;

using thx.Arrays;

class Polyline {
  var points : Array<Point>;
  public function new() {
    points = [];
  }

  public function toString()
    return 'Polyline(${points.pluck(_.x+","+_.y).join(";")})';
}
