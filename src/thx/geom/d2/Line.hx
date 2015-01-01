package thx.geom.d2;

//import thx.geom.Matrix4x4;

class Line {
  public static function fromPoints(p1 : Point, p2 : Point) {
    var direction = p2 - p1,
        normal = direction.normal().negate().normalize(),
        w = p1.dot(normal);
    return new Line(normal, w);
  }

  public var normal(default, null) : Point;
  public var w(default, null) : Float;
  public var isHorizontal(get, null) : Bool;
  public var isVertical(get, null) : Bool;

  public function new(normal : Point, w : Float) {
    var l = normal.length;
    this.w = w * l;
    this.normal = normal.divide(l);
  }

  public function offset(value : Float)
    return new Line(normal, w + value);

  public function reverse()
    return new Line(normal.negate(), -w);

  public function equals(other : Line)
    return normal.equals(other.normal) && w == other.w;

  public function origin()
    return normal.multiply(w);

  public function direction()
    return normal.normal();

  public function xAtY(y : Float)
    return (w - normal.y * y) / normal.x;

  public function absDistanceToPoint(point : Point)
    return Math.abs(point.dot(normal) - w);

  public function intersectionLine(line : Line) : Null<Point>
    return Point.solve2Linear(normal.x, normal.y, line.normal.x, line.normal.y, w, line.w);

  public function transform(matrix : Matrix4x4) {
    var origin = Point.create(0, 0),
        pointOnPlane = normal.multiply(w),
        neworigin = origin.transform(matrix),
        neworiginPlusNormal = normal.transform(matrix),
        newnormal = neworiginPlusNormal - neworigin,
        newpointOnPlane = pointOnPlane.transform(matrix),
        neww = newnormal.dot(newpointOnPlane);
    return new Line(newnormal, neww);
  }

  function get_isHorizontal()
    return normal.x == 0;

  function get_isVertical()
    return normal.y == 0;

  public function toString()
    return 'Line(${normal.x},${normal.y},w:$w)';
}