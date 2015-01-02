package thx.geom.d3;

using thx.core.Floats;
import thx.geom.d2.Point in Point2D;
import thx.geom.d3.Point;

class Line {
  public static function fromPoints(p1 : Point, p2 : Point)
    return new Line(p1, p2.subtractPoint(p1).normalize());

  public static function fromPlanes(p1 : Plane, p2 : Plane) {
    var direction = p1.normal.cross(p2.normal),
        l = direction.length;
    if(l < 1e-10)
      throw "Parallel planes";

    direction = direction.multiply(1.0 / l);

    var mabsx = Math.abs(direction.x),
        mabsy = Math.abs(direction.y),
        mabsz = Math.abs(direction.z),
        origin;
    if((mabsx >= mabsy) && (mabsx >= mabsz)) {
      // direction vector is mostly pointing towards x
      // find a point p for which x is zero:
      var r = Point2D.solve2Linear(p1.normal.y, p1.normal.z, p2.normal.y, p2.normal.z, p1.w, p2.w);
      origin = Point.create(0, r.x, r.y);
    } else if((mabsy >= mabsx) && (mabsy >= mabsz)) {
      // find a point p for which y is zero:
      var r = Point2D.solve2Linear(p1.normal.x, p1.normal.z, p2.normal.x, p2.normal.z, p1.w, p2.w);
      origin = Point.create(r.x, 0, r.y);
    } else {
      // find a point p for which z is zero:
      var r = Point2D.solve2Linear(p1.normal.x, p1.normal.y, p2.normal.x, p2.normal.y, p1.w, p2.w);
      origin = Point.create(r.x, r.y, 0);
    }
    return new Line(origin, direction);
  }

  public var point(default, null) : Point;
  public var direction(default, null) : Point;

  public function new(point : Point, direction : Point) {
    this.point = point;
    this.direction = direction.normalize();
  }

  public function intersectWithPlane(plane : Plane) {
    var lambda = (plane.w - plane.normal.dot(this.point)) / plane.normal.dot(direction);
    return point.addPoint(direction.multiply(lambda));
  }

  public function reverse()
    return new Line(point, direction.negate());

  public function transform(matrix44) {
    var newpoint = point.transform(matrix44),
        pointaddDirection = point.addPoint(direction),
        newPointaddDirection = pointaddDirection.transform(matrix44),
        newdirection = newPointaddDirection.subtractPoint(newpoint);
    return new Line(newpoint, newdirection);
  }

  public function closestPointOnLine(point : Point) {
    var t = point.subtractPoint(point).dot(direction) / direction.dot(this.direction);
    return point.addPoint(direction.multiply(t));
  }

  public function distanceToPoint(point : Point) {
    var closestpoint = closestPointOnLine(point),
        distancevector = point.subtractPoint(closestpoint);
    return distancevector.length;
  }

  public function equals(line : Line) {
    if(!direction.equals(line.direction))
      return false;
    return distanceToPoint(line.point).nearZero();
  }
}