package thx.geom.d3;

import thx.geom.d3.xyz.*;
using thx.core.Arrays;
using thx.core.Floats;

import thx.geom.d2.Point in Point2D;

abstract Point(XYZ) from XYZ to XYZ {
  public static var zero(default, null) : Point = Point.immutable(0, 0, 0);

  @:from public static function fromFloats(arr : Array<Float>) {
    arr.resize(3, 0);
    return create(arr[0], arr[1], arr[2]);
  }

  @:from static inline function fromObject(o : { x : Float, y : Float, z : Float })
    return create(o.x, o.y, o.z);

  inline public static function create(x : Float, y : Float, z : Float) : Point
    return new PointXYZ(x, y, z);

  inline public static function linked(getX : Void -> Float, getY : Void -> Float, getZ : Void -> Float, setX : Float -> Float, setY : Float -> Float, setZ : Float -> Float) : Point
    return new LinkedXYZ(getX, getY, getZ, setX, setY, setZ);

  inline public static function immutable(x : Float, y : Float, z : Float) : Point
    return new ImmutableXYZ(x, y, z);

  public var x(get, set) : Float;
  public var y(get, set) : Float;
  public var z(get, set) : Float;
  public var length(get, never) : Float;
  public var lengthSquared(get, never) : Float;

  inline public function new(xyz : XYZ)
    this = xyz;

  @:op(A+=B) inline public function addPointAssign(p : Point) : Point
    return set(x + p.x, y + p.y, z + p.z);

  @:op(A+B) inline public function addPoint(p : Point)
    return Point.create(x + p.x, y + p.y, z + p.z);

  @:op(A+=B) inline public function addAssign(v : Float) : Point
    return set(x + v, y + v, z + v);

  @:op(A+B) inline public function add(v : Float)
    return Point.create(x + v, y + v, z + v);

  @:op(-A) inline public function negate()
    return Point.create(-x, -y, -z);

  @:op(A-=B) inline public function subtractPointAssign(p : Point) : Point
    return set(x - p.x, y - p.y, z - p.z);

  @:op(A-B) inline public function subtractPoint(p : Point)
    return addPoint(p.negate());

  @:op(A-=B) inline public function subtractAssign(v : Float) : Point
    return set(x - v, y - v, z - v);

  @:op(A-B) inline public function subtract(v : Float)
    return add(-v);

  @:op(A*=B) inline public function multiplyPointAssign(p : Point) : Point
    return set(x * p.x, y * p.y, z * p.z);

  @:op(A*B) inline public function multiplyPoint(p : Point)
    return Point.create(x * p.x, y * p.y, z * p.z);

  @:op(A*=B) inline public function multiplyAssign(v : Float) : Point
    return set(x * v, y * v, z * v);

  @:commutative
  @:op(A*B) inline public function multiply(v : Float)
    return Point.create(x * v, y * v, z * v);

  @:op(A/=B) inline public function dividePointAssign(p : Point) : Point
    return set(x / p.x, y / p.y, z / p.z);

  @:op(A/B) inline public function dividePoint(p : Point)
    return Point.create(x / p.x, y / p.y, z / p.z);

  @:op(A/=B) inline public function divideAssign(v : Float) : Point
    return set(x / v, y / v, z / v);

  @:op(A/B) inline public function divide(v : Float)
    return Point.create(x / v, y / v, z / v);

  @:op(A==B)
  inline public function equals(p : Point)
    return (x == p.x) && (y == p.y) && (z == p.z);

  @:op(A!=B)
  inline public function notEquals(p : Point)
    return !equals(p);

  inline public function abs() : Point
    return Point.create(Math.abs(x), Math.abs(y), Math.abs(z));

  public function nearEquals(p : Point)
    return Math.abs(x - p.x) <= Floats.EPSILON && Math.abs(y - p.y) <= Floats.EPSILON && Math.abs(z - p.z) <= Floats.EPSILON;

  inline public function notNearEquals(p : Point)
    return !nearEquals(p);

  public function interpolate(p : Point, f : Float)
    return addPoint(p.subtractPoint(this).multiply(f));

  inline public function isZero()
    return equals(zero);

  public function isNearZero()
    return nearEquals(zero);

  inline public function dot(p : Point) : Float
    return x * p.x + y * p.y + z * p.z;

  inline public function normalize()
    return divide(length);

  public function distanceTo(p : Point)
    return Math.abs(subtractPoint(p).length);

  public function distanceToSquared(p : Point)
    return subtractPoint(p).lengthSquared;

  // Right multiply by a 4x4 matrix (the vector is interpreted as a row vector)
  // Returns a new Point3D
  inline public function transform(matrix : Matrix4x4)
    return matrix.leftMultiplyPoint3D((this : Point));

  // find a vector that is somewhat perpendicular to this one
  public function randomNonParallelVector() : Point {
    var a = abs();
    if((a.x <= a.y) && (a.x <= a.z)) {
      return Point.create(1, 0, 0);
    } else if((a.y <= a.x) && (a.y <= a.z)) {
      return Point.create(0, 1, 0);
    } else {
      return Point.create(0, 0, 1);
    }
  }

  public function cross(p : Point)
    return Point.create(
      y * p.z - z * p.y,
      z * p.x - x * p.z,
      x * p.y - y * p.x
    );

  inline public function min(p : Point)
    return Point.create(
      Math.min(x, p.x),
      Math.min(y, p.y),
      Math.min(z, p.z)
    );

  inline public function max(p : Point)
    return Point.create(
      Math.max(x, p.x),
      Math.max(y, p.y),
      Math.max(z, p.z)
    );
/*
  public function isOnLine(line : Line3D) : Bool {
    if(line.isHorizontal)
      return Floats.nearEquals(y, line.w);
    return Floats.nearEquals(line.xAtY(y), x);
  }
*/
  public function set(nx : Float, ny : Float, nz : Float) : Point {
    x = nx;
    y = ny;
    z = nz;
    return this;
  }

  @:to inline public function toPoint() : Point2D
    return new Point2D(this);

  @:to inline public function toArray() : Array<Float>
    return [x, y, z];

  @:to inline public function toObject() : { x : Float, y : Float, z : Float }
    return { x : x, y : y, z : z };

  @:to inline public function toString()
    return 'Point($x,$y,$z)';

  inline function get_x() return this.x;
  inline function get_y() return this.y;
  inline function get_z() return this.z;
  inline function set_x(v : Float) return this.x = v;
  inline function set_y(v : Float) return this.y = v;
  inline function set_z(v : Float) return this.z = v;
  inline function get_length() return lengthSquared.sqrt();
  inline function get_lengthSquared() return x * x + y * y + z * z;
}