package thx.geom.d2;

using thx.Arrays;

class Polygon extends Polyline {
  override public function toString()
    return 'Polygon(${points.pluck(_.x+","+_.y).join(";")})';
}
