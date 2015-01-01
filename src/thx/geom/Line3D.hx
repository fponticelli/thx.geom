package thx.geom;

import thx.geom.d2.Point in Point2D;
import thx.geom.d3.Point in Point3D;

class Line3D {
  public static function fromPoints(p1 : Point3D, p2 : Point3D)
    return new Line3D(p1, p2.subtractPoint(p1).normalize());

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
      origin = Point3D.create(0, r.x, r.y);
    } else if((mabsy >= mabsx) && (mabsy >= mabsz)) {
      // find a point p for which y is zero:
      var r = Point2D.solve2Linear(p1.normal.x, p1.normal.z, p2.normal.x, p2.normal.z, p1.w, p2.w);
      origin = Point3D.create(r.x, 0, r.y);
    } else {
      // find a point p for which z is zero:
      var r = Point2D.solve2Linear(p1.normal.x, p1.normal.y, p2.normal.x, p2.normal.y, p1.w, p2.w);
      origin = Point3D.create(r.x, r.y, 0);
    }
    return new Line3D(origin, direction);
  }

  public var point(default, null) : Point3D;
  public var direction(default, null) : Point3D;

  public function new(point : Point3D, direction : Point3D) {
    this.point = point;
    this.direction = direction.normalize();
  }

  public function intersectWithPlane(plane : Plane) {
    var lambda = (plane.w - plane.normal.dot(this.point)) / plane.normal.dot(direction);
    return point.addPoint(direction.multiply(lambda));
  }

  public function reverse()
    return new Line3D(point, direction.negate());

  public function transform(matrix4x4) {
    var newpoint = point.transform(matrix4x4),
        pointaddDirection = point.addPoint(direction),
        newPointaddDirection = pointaddDirection.transform(matrix4x4),
       newdirection = newPointaddDirection.subtractPoint(newpoint);
    return new Line3D(newpoint, newdirection);
  }

  public function closestPointOnLine(point : Point3D) {
    var t = point.subtractPoint(point).dot(direction) / direction.dot(this.direction);
    return point.addPoint(direction.multiply(t));
  }

  public function distanceToPoint(point : Point3D) {
    var closestpoint = closestPointOnLine(point),
        distancevector = point.subtractPoint(closestpoint);
    return distancevector.length;
  }

  public function equals(line : Line3D) {
    if(!direction.equals(line.direction))
      return false;
    return distanceToPoint(line.point) <= 1e-8;
  }
}