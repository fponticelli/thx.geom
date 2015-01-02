package thx.geom;

import thx.geom.d2.Point in Point2D;
import thx.geom.d3.Point in Point3D;
import thx.geom.d3.Plane;

typedef Transformable<T> = {
  public function transform(matrix : Matrix44) : T;
};

class Transformables {
  public static inline function mirror<T>(t : Transformable<T>, plane : Plane) : T
    return t.transform(Matrix44.mirroring(plane));

  public static var MX(default, null) : Plane = new Plane(Point3D.create(1, 0, 0), 0);
  public static inline function mirrorX<T>(t : Transformable<T>) : T
    return mirror(t, MX);

  public static var MY(default, null) : Plane = new Plane(Point3D.create(0, 1, 0), 0);
  public static inline function mirrorY<T>(t : Transformable<T>) : T
    return mirror(t, MY);

  public static var MZ(default, null) : Plane = new Plane(Point3D.create(0, 0, 1), 0);
  public static inline function mirrorZ<T>(t : Transformable<T>) : T
    return mirror(t, MZ);

  public static inline function translate<T>(t : Transformable<T>, v : Point3D) : T
    return t.transform(Matrix44.translation(v.x, v.y, v.z));

  public static inline function translateX<T>(t : Transformable<T>, x : Float) : T
    return t.transform(Matrix44.translation(x, 0, 0));

  public static inline function translateY<T>(t : Transformable<T>, y : Float) : T
    return t.transform(Matrix44.translation(0, y, 0));

  public static inline function translateZ<T>(t : Transformable<T>, z : Float) : T
    return t.transform(Matrix44.translation(0, 0, z));

  public static inline function scale<T>(t : Transformable<T>, f : Point3D) : T
    return t.transform(Matrix44.scaling(f));

  public static inline function rotateX<T>(t : Transformable<T>, angle :  Float) : T
    return t.transform(Matrix44.rotationX(angle));

  public static inline function rotateY<T>(t : Transformable<T>, angle :  Float) : T
    return t.transform(Matrix44.rotationY(angle));

  public static inline function rotateZ<T>(t : Transformable<T>, angle :  Float) : T
    return t.transform(Matrix44.rotationZ(angle));

  public static inline function rotateOnAxis<T>(t : Transformable<T>, center : Point3D, axis : Point3D, angle :  Float) : T
    return t.transform(Matrix44.rotation(center, axis, angle));
}