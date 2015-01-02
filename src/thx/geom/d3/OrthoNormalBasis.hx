package thx.geom.d3;

import thx.geom.d2.Line in Line2D;
import thx.geom.d3.Line in Line3D;
import thx.geom.d2.Point in Point2D;
import thx.geom.d3.Point in Point3D;
import thx.geom.Matrix44;

class OrthoNormalBasis {
  public static inline function fromPlane(plane : Plane)
    return new OrthoNormalBasis(plane, plane.normal.randomNonParallelVector());

  public var v(default, null) : Point3D;
  public var u(default, null) : Point3D;
  public var plane(default, null) : Plane;
  public var planeOrigin(default, null) : Point3D;
  public function new(plane : Plane, rightvector : Point3D) {
    this.v = plane.normal.cross(rightvector).normalize();
    this.u = v.cross(plane.normal);
    this.plane = plane;
    this.planeOrigin = plane.normal.multiply(plane.w);
  }

  public static var z0Plane(default, null) : OrthoNormalBasis =
    new OrthoNormalBasis(
      new Plane(Point3D.create(0, 0, 1), 0),
      Point3D.create(1, 0, 0)
    );

  public function getProjectionMatrix() {
    return new Matrix44(
      u.x, v.x, plane.normal.x, 0,
      u.y, v.y, plane.normal.y, 0,
      u.z, v.z, plane.normal.z, 0,
      0, 0, -plane.w, 1
    );
  }

  public function getInverseProjectionMatrix() {
    var p = plane.normal.multiply(plane.w);
    return new Matrix44(
      u.x, u.y, u.z, 0,
      v.x, v.y, v.z, 0,
      plane.normal.x, plane.normal.y, plane.normal.z, 0,
      p.x, p.y, p.z, 1);
  }

  public function to2D(vec3 : Point3D)
    return Point2D.create(vec3.dot(u), vec3.dot(v));

  public function to3D(vec2 : Point2D)
    return planeOrigin
      .addPoint(u.multiply(vec2.x))
      .addPoint(v.multiply(vec2.y));

  public function line3Dto2D(line : Line3D)
    return Line2D.fromPoints(
      to2D(line.point),
      to2D(line.direction.addPoint(line.point))
    );

  public function line2Dto3D(line : Line2D) {
    var a = line.origin(),
      b = line.direction().addPoint(a);
    return Line3D.fromPoints(to3D(a), to3D(b));
  }

  public function transform(matrix : Matrix44) {
    // todo: may not work properly in case of mirroring
    var newplane = plane.transform(matrix),
        rightpoint_transformed = u.transform(matrix),
        origin_transformed = Point3D.create(0, 0, 0).transform(matrix),
        newrighthandvector = rightpoint_transformed.subtractPoint(origin_transformed);
    return new OrthoNormalBasis(newplane, newrighthandvector);
  }
}