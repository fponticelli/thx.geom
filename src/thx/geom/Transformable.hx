package thx.geom;

typedef Transformable<T> = {
	public function transform(matrix : Matrix4x4) : T;
};

class Transformables {
	public static inline function mirror<T>(t : Transformable<T>, plane : Plane) : T
		return t.transform(Matrix4x4.mirroring(plane));

	static var MX : Plane = new Plane(new Point3D(1, 0, 0), 0);
	public static inline function mirrorX<T>(t : Transformable<T>) : T
		return mirror(t, MX);

	static var MY : Plane = new Plane(new Point3D(0, 1, 0), 0);
	public static inline function mirrorY<T>(t : Transformable<T>) : T
		return mirror(t, MY);

	static var MZ : Plane = new Plane(new Point3D(0, 0, 1), 0);
	public static inline function mirrorZ<T>(t : Transformable<T>) : T
		return mirror(t, MZ);

	public static inline function translate<T>(t : Transformable<T>, v : Point3D) : T
		return t.transform(Matrix4x4.translation(v));

	public static inline function scale<T>(t : Transformable<T>, f : Point3D) : T
		return t.transform(Matrix4x4.scaling(f));

	public static inline function rotateX<T>(t : Transformable<T>, deg : Float) : T
		return t.transform(Matrix4x4.rotationX(deg));

	public static inline function rotateY<T>(t : Transformable<T>, deg : Float) : T
		return t.transform(Matrix4x4.rotationY(deg));

	public static inline function rotateZ<T>(t : Transformable<T>, deg : Float) : T
		return t.transform(Matrix4x4.rotationZ(deg));

	public static inline function rotateOnAxis<T>(t : Transformable<T>, center : Point3D, axis : Point3D, deg : Float) : T
		return t.transform(Matrix4x4.rotation(center, axis, deg));
}