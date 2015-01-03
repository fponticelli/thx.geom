package thx.geom.shape;

import thx.geom.Matrix44;
import thx.geom.d2.Point in Point2D;
import thx.geom.d2.Spline;
import thx.geom.d2.SplineNode;
import thx.geom.d3.Point in Point3D;
import thx.math.Const;
using thx.geom.Transformable;

abstract Circle({ center : Point2D, radius : Float }) {
  inline public function new(center : Point2D, radius : Float)
    this = { center : center, radius : radius };

  public var center(get, never) : Point2D;
  public var radius(get, never) : Float;

  inline function get_center() return this.center;
  inline function get_radius() return this.radius;

  @:to public function toString()
    return 'Circle(${center.x},${center.y},$radius)';

  public static var unitaryCircle(default, null) : Spline = new Spline([
    new SplineNode(Point2D.create( 1,  0), Point2D.create(1,-Const.KAPPA), Point2D.create(1,Const.KAPPA)),
    new SplineNode(Point2D.create( 0, -1), Point2D.create(-Const.KAPPA,-1), Point2D.create(Const.KAPPA,-1)),
    new SplineNode(Point2D.create(-1,  0), Point2D.create(-1,Const.KAPPA), Point2D.create(-1,-Const.KAPPA)),
    new SplineNode(Point2D.create( 0,  1), Point2D.create(Const.KAPPA,1), Point2D.create(-Const.KAPPA,1))
  ], true);

  @:to public function toSpline() {
    return unitaryCircle
      .scale(radius, radius, 1)
      .translate(center.x, center.y, 0);
  }

  @:to public function toPath()
    return toSpline().toPath();
}