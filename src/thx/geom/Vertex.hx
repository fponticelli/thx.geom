package thx.geom;

import thx.geom.d2.Point;
using thx.core.Floats;
using thx.math.Integrate;

class Vertex {
  inline public function new(position : Point, normal : Point) {
    this.position = position;
    this.normal = normal;
  }

  public static function linearVertex(position : Point)
    return new Vertex(position, Point.zero);

  @:isVar public var position(default, null) : Point;
  @:isVar public var normal(default, null) : Point;

  inline public function flip()
    return new Vertex(position, normal.negate());

  public function interpolate(other : Vertex, t : Float)
    return new Vertex(
      position.interpolate(other.position, t),
      normal.interpolate(other.normal, t)
    );

  public function getDistanceSquared(other : Vertex) {
    var v = [
      position.x, position.y,
      position.x + normal.x, position.y + normal.y,
      other.position.x + other.normal.x, other.position.y + other.normal.y,
      other.position.x, other.position.y
    ];
    if(Floats.nearZero(v[0] - v[2]) && Floats.nearZero(v[1] - v[3]) &&
       Floats.nearZero(v[6] - v[4]) && Floats.nearZero(v[7] - v[5]))
      return position.distanceToSquared(other.position);
    // TODO parameters should not be hard coded, particularly precision
    return getLengthSquaredIntegrand(v).integrate(0, 1, 16);
  }

  public function getDistance(other : Vertex)
    return Math.sqrt(getDistanceSquared(other));

  inline public function transform(matrix : Matrix4x4)
    return new Vertex(position.transform(matrix), normal.transform(matrix));

  public function equals(other : Vertex)
    return position.equals(other.position) && normal.equals(other.normal);

  public function toString()
    return 'Vertex($position,$normal)';

  static function getLengthSquaredIntegrand(v : Array<Float>) {
    // Calculate the coefficients of a Bezier derivative.
    var p1x = v[0], p1y = v[1],
        c1x = v[2], c1y = v[3],
        c2x = v[4], c2y = v[5],
        p2x = v[6], p2y = v[7],

        ax = 9 * (c1x - c2x) + 3 * (p2x - p1x),
        bx = 6 * (p1x + c2x) - 12 * c1x,
        cx = 3 * (c1x - p1x),

        ay = 9 * (c1y - c2y) + 3 * (p2y - p1y),
        by = 6 * (p1y + c2y) - 12 * c1y,
        cy = 3 * (c1y - p1y);

    return function(t : Float) {
      // Calculate quadratic equations of derivatives for x and y
      var dx = (ax * t + bx) * t + cx,
        dy = (ay * t + by) * t + cy;
      return dx * dx + dy * dy;
    };
  }
}