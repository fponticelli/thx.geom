package thx.geom;

typedef Transformable<T> = {
	public function transform(matrix : Matrix4x4) : T;
};

class Transformables {
	public static inline function mirror<T>(t : Transformable<T>, plane : Plane) : T
		return t.transform(Matrix4x4.mirroring(plane));

	public static var MX(default, null) : Plane = new Plane(new Point3D(1, 0, 0), 0);
	public static inline function mirrorX<T>(t : Transformable<T>) : T
		return mirror(t, MX);

	public static var MY(default, null) : Plane = new Plane(new Point3D(0, 1, 0), 0);
	public static inline function mirrorY<T>(t : Transformable<T>) : T
		return mirror(t, MY);

	public static var MZ(default, null) : Plane = new Plane(new Point3D(0, 0, 1), 0);
	public static inline function mirrorZ<T>(t : Transformable<T>) : T
		return mirror(t, MZ);

	public static inline function translate<T>(t : Transformable<T>, v : Point3D) : T
		return t.transform(Matrix4x4.translation(v));

	public static inline function translateX<T>(t : Transformable<T>, x : Float) : T
		return t.transform(Matrix4x4.translation(new Point3D(x, 0, 0)));

	public static inline function translateY<T>(t : Transformable<T>, y : Float) : T
		return t.transform(Matrix4x4.translation(new Point3D(0, y, 0)));

	public static inline function translateZ<T>(t : Transformable<T>, z : Float) : T
		return t.transform(Matrix4x4.translation(new Point3D(0, 0, z)));

	public static inline function scale<T>(t : Transformable<T>, f : Point3D) : T
		return t.transform(Matrix4x4.scaling(f));

	public static inline function rotateX<T>(t : Transformable<T>, angle : Angle) : T
		return t.transform(Matrix4x4.rotationX(angle));

	public static inline function rotateY<T>(t : Transformable<T>, angle : Angle) : T
		return t.transform(Matrix4x4.rotationY(angle));

	public static inline function rotateZ<T>(t : Transformable<T>, angle : Angle) : T
		return t.transform(Matrix4x4.rotationZ(angle));

	public static inline function rotateOnAxis<T>(t : Transformable<T>, center : Point3D, axis : Point3D, angle : Angle) : T
		return t.transform(Matrix4x4.rotation(center, axis, angle));
}