package thx.geom;

import thx.core.Floats;

abstract Point3D(Array<Float>) {
  public static var zero(default, null) : Point3D = new Point3D(0, 0, 0);

  @:from inline static public function fromObject(o : {x : Float, y : Float, z : Float})
    return new Point3D(o.x, o.y, o.z);

  @:from inline static public function fromArray(arr : Array<Float>)
    return new Point3D(arr[0],arr[1],arr[2]);

  inline public function new(x : Float, y : Float, z : Float)
    this = [x,y,z];

  public var x(get, never) : Float;
  public var y(get, never) : Float;
  public var z(get, never) : Float;
  public var length(get, never) : Float;
  public var lengthSquared(get, never) : Float;
  private var inst(get, never) : Point3D;

  inline function get_x() return this[0];
  inline function get_y() return this[1];
  inline function get_z() return this[2];
  inline function get_length()
    return Math.sqrt(lengthSquared);
  inline function get_lengthSquared()
    return dot(this);
  inline function get_inst() : Point3D return cast this;

  @:op(A+B)
  inline public function addPoint3D(p : Point3D) : Point3D
    return new Point3D(x+p.x, y+p.y, z+p.z);

  @:op(A+B)
  inline public function add(v : Float) : Point3D
    return new Point3D(x+v, y+v, z+v);

  @:op(-A)
  inline public function negate() : Point3D
    return new Point3D(-x, -y, -z);

  @:op(A-B)
  inline public function subtractPoint3D(p : Point3D) : Point3D
    return addPoint3D(p.negate());

  @:op(A-B)
  inline public function subtract(v : Float) : Point3D
    return add(-v);

  @:op(A*B) inline function multiplyPoint3D(p : Point3D)
    return new Point3D(x * p.x, y * p.y, z * p.z);

  @:commutative
  @:op(A*B)
  inline public function multiply(v : Float) : Point3D
    return new Point3D(x * v, y * v, z * v);

  @:op(A/B) inline function dividePoint3D(p : Point3D)
    return new Point3D(x / p.x, y / p.y, z / p.z);

  @:op(A/B)
  inline public function divide(v : Float) : Point3D
    return new Point3D(x / v, y / v, z / v);

  @:op(A==B)
  public function equals(p : Point3D)
    return (x == p.x) && (y == p.y) && (z == p.z);

  @:op(A!=B)
  inline public function notEquals(p : Point3D)
    return !equals(p);

  public function abs() : Point3D
    return new Point3D(Math.abs(x), Math.abs(y), Math.abs(z));

  public function nearEquals(p : Point3D)
    return Math.abs(x - p.x) <= Floats.EPSILON && Math.abs(y - p.y) <= Floats.EPSILON && Math.abs(z - p.z) <= Floats.EPSILON;

  public function interpolate(p : Point3D, f : Float) : Point3D
    return addPoint3D(p.subtractPoint3D(this).multiply(f));

  inline public function isZero()
    return equals(zero);

  inline public function isNearZero()
    return nearEquals(zero);

  public function dot(prod : Point3D) : Float
    return x * prod.x + y * prod.y + z * prod.z;

  inline public function normalize() : Point3D
    return divide(length);

  public function distanceTo(p : Point3D)
    return subtractPoint3D(p).length;

  public function distanceToSquared(p : Point3D)
    return subtractPoint3D(p).lengthSquared;

  // Right multiply by a 4x4 matrix (the vector is interpreted as a row vector)
  // Returns a new Point3D
  inline public function multiply4x4(matrix4x4 : Matrix4x4) : Point3D
    return matrix4x4.leftMultiplyPoint3D(this);

  inline public function transform(matrix4x4 : Matrix4x4) : Point3D
    return matrix4x4.leftMultiplyPoint3D(this);

  // find a vector that is somewhat perpendicular to this one
  public function randomNonParallelVector() : Point3D {
    var a = abs();
    if((a.x <= a.y) && (a.x <= a.z)) {
      return new Point3D(1, 0, 0);
    } else if((a.y <= a.x) && (a.y <= a.z)) {
      return new Point3D(0, 1, 0);
    } else {
      return new Point3D(0, 0, 1);
    }
  }

  inline public function cross(p : Point3D) : Point3D
    return new Point3D(
      y * p.z - z * p.y,
      z * p.x - x * p.z,
      x * p.y - y * p.x
    );

  inline public function min(p : Point3D) : Point3D
    return new Point3D(
      Math.min(x, p.x),
      Math.min(y, p.y),
      Math.min(z, p.z)
    );

  inline public function max(p : Point3D) : Point3D
    return new Point3D(
      Math.max(x, p.x),
      Math.max(y, p.y),
      Math.max(z, p.z)
    );

  @:to inline public function toArray() : Array<Float>
    return this.copy();

  @:to inline public function toObject()
    return { x : x, y : y, z : z };

  @:to inline public function toString()
    return 'Point3D($x,$y,$z)';
}