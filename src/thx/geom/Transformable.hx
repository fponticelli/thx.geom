package thx.geom;

import thx.geom.d2.Point in Point2D;
import thx.geom.d3.Point in Point3D;
import thx.geom.d3.Plane;

class Transformables44 {
  public static inline function applyMirror<T : ITransformable44<Dynamic>>(o : T, plane : Plane) : T
    return o.apply44(Matrix44.mirroring(plane));

  public static inline function applyMirrorX<T : ITransformable44<Dynamic>>(o : T) : T
    return o.apply44(MX);

  public static inline function applyMirrorY<T : ITransformable44<Dynamic>>(o : T) : T
    return o.apply44(MY);

  public static inline function applyMirrorZ<T : ITransformable44<Dynamic>>(o : T) : T
    return o.apply44(MZ);

  public static function applyTranslation<T : ITransformable44<Dynamic>>(o : T, x : Float, y : Float, z : Float) : T
    return o.apply44(Matrix44.translation(x, y, z));

  inline public static function applyTranslationX<T : ITransformable44<Dynamic>>(o : T, x : Float) : T
    return applyTranslation(o, x, 0, 0);

  inline public static function applyTranslationY<T : ITransformable44<Dynamic>>(o : T, y : Float) : T
    return applyTranslation(o, 0, y, 0);

  inline public static function applyTranslationZ<T : ITransformable44<Dynamic>>(o : T, z : Float) : T
    return applyTranslation(o, 0, 0, z);

  public static inline function mirror<T : ITransformable44<Dynamic>>(o : T, plane : Plane) : T
    return applyMirror(o.clone(), plane);

  public static inline function mirrorX<T : ITransformable44<Dynamic>>(o : T) : T
    return applyMirrorX(o.clone());

  public static inline function mirrorY<T : ITransformable44<Dynamic>>(o : T) : T
    return applyMirrorY(o.clone());

  public static inline function mirrorZ<T : ITransformable44<Dynamic>>(o : T) : T
    return applyMirrorZ(o.clone());

  public static function translate<T : ITransformable44<Dynamic>>(o : T, x : Float, y : Float, z : Float) : T
    return applyTranslation(o.clone(), x, y, z);

  inline public static function translateX<T : ITransformable44<Dynamic>>(o : T, x : Float) : T
    return translate(o, x, 0, 0);

  inline public static function translateY<T : ITransformable44<Dynamic>>(o : T, y : Float) : T
    return translate(o, 0, y, 0);

  inline public static function translateZ<T : ITransformable44<Dynamic>>(o : T, z : Float) : T
    return translate(o, 0, 0, z);

  public static var MX(default, null) : Matrix44 = Matrix44.mirroring(Plane.PX);
  public static var MY(default, null) : Matrix44 = Matrix44.mirroring(Plane.PY);
  public static var MZ(default, null) : Matrix44 = Matrix44.mirroring(Plane.PZ);
}

// TODO REMOVE
typedef Transformable<T> = {
  public function transform(matrix : Matrix44) : T;
};

// TODO REMOVE
class Transformables {
  public static inline function translate<T>(t : Transformable<T>, v : Point3D) : T
    return t.transform(Matrix44.translation(v.x, v.y, v.z));

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