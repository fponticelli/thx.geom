package thx.geom.d2;

using thx.Arrays;
using thx.Functions;

class Polygon extends Polyline {
  override public function toString()
    return 'Polygon(${points.map.fn(_.x+","+_.y).join(";")})';
}
