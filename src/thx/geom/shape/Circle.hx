package thx.geom.shape;

import thx.geom.Matrix4x4;
import thx.geom.Point;
import thx.geom.Const;
using thx.geom.Transformable.Transformables;

abstract Circle({ center : Point, radius : Float }) {
  inline public function new(center : Point, radius : Float)
    this = { center : center, radius : radius };

  public var center(get, never) : Point;
  public var radius(get, never) : Float;

  inline function get_center() return this.center;
  inline function get_radius() return this.radius;

  @:to public function toString()
    return 'Circle(${center.x},${center.y},$radius)';

  public static var unitaryCircle(default, null) : Spline = new Spline([
    new SplineNode(new Point( 1,  0), new Point(1,-Const.KAPPA), new Point(1,Const.KAPPA)),
    new SplineNode(new Point( 0, -1), new Point(-Const.KAPPA,-1), new Point(Const.KAPPA,-1)),
    new SplineNode(new Point(-1,  0), new Point(-1,Const.KAPPA), new Point(-1,-Const.KAPPA)),
    new SplineNode(new Point( 0,  1), new Point(Const.KAPPA,1), new Point(-Const.KAPPA,1))
  ], true);
  @:to public function toSpline() {
    return unitaryCircle
      .scale(new Point3D(radius, radius, 1))
      .translate(new Point3D(center.x, center.y, 0));
  }
}