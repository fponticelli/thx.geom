package thx.geom.d2;

import thx.geom.core.*;
using thx.Arrays;
using thx.Floats;

abstract Vector(XY) from XY to XY {
  public static var zero(default, null) : Vector = Vector.immutable(0, 0);

  @:from public static function fromFloats(arr : Array<Float>) {
    arr.resize(2, 0);
    return create(arr[0], arr[1]);
  }

  @:from static inline function fromObject(o : { x : Float, y : Float })
    return create(o.x, o.y);

  @:from static inline public function fromAngle(angle :  Float)
    return create(Math.cos(angle), Math.sin(angle));

  public static function linkedPoints(a : Point, b : Point)
    return linked(
      function() return b.x - a.x,
      function() return b.y - a.y,
      function(v) {
        b.x = a.x + v;
        return v;
      },
      function(v) {
        b.y = a.y + v;
        return v;
      }
    );

  inline public static function create(x : Float, y : Float) : Vector
    return new MutableXY(x, y);

  inline public static function linked(getX : Void -> Float, getY : Void -> Float, setX : Float -> Float, setY : Float -> Float) : Vector
    return new LinkedXY(getX, getY, setX, setY);

  inline public static function immutable(x : Float, y : Float) : Vector
    return new ImmutableXY(x, y);

  public var x(get, set) : Float;
  public var y(get, set) : Float;
  public var length(get, set) : Float;
  public var magnitude(get, set) : Float;

  inline public function new(xy : XY)
    this = xy;

  inline public function asPoint()
    return new Point(this);

  inline public function asSize()
    return new Size(this);

  @:op(A+=B) inline public function addVectorAssign(p : Vector) : Vector
    return set(x + p.x, y + p.y);

  @:op(A+B) inline public function addVector(p : Vector)
    return Vector.create(x + p.x, y + p.y);

  @:op(A+=B) inline public function addAssign(v : Float) : Vector
    return set(x + v, y + v);

  @:op(A+B) inline public function add(v : Float)
    return Vector.create(x + v, y + v);

  @:op(-A) inline public function negate()
    return Vector.create(-x, -y);

  @:op(A-=B) inline public function subtractVectorAssign(p : Vector) : Vector
    return set(x - p.x, y - p.y);

  @:op(A-B) inline public function subtractVector(p : Vector)
    return addVector(p.negate());

  @:op(A-=B) inline public function subtractAssign(v : Float) : Vector
    return set(x - v, y - v);

  @:op(A-B) inline public function subtract(v : Float)
    return add(-v);

  @:op(A*=B) inline public function multiplyVectorAssign(p : Vector) : Vector
    return set(x * p.x, y * p.y);

  @:op(A*B) inline public function multiplyVector(p : Vector)
    return Vector.create(x * p.x, y * p.y);

  @:op(A*=B) inline public function multiplyAssign(v : Float) : Vector
    return set(x * v, y * v);

  @:commutative
  @:op(A*B) inline public function multiply(v : Float)
    return Vector.create(x * v, y * v);

  @:op(A/=B) inline public function divideVectorAssign(p : Vector) : Vector
    return set(x / p.x, y / p.y);

  @:op(A/B) inline public function divideVector(p : Vector)
    return Vector.create(x / p.x, y / p.y);

  @:op(A/=B) inline public function divideAssign(v : Float) : Vector
    return set(x / v, y / v);

  @:op(A/B) inline public function divide(v : Float)
    return Vector.create(x / v, y / v);

  @:op(A==B)
  inline public function equals(p : Vector)
    return (x == p.x) && (y == p.y);

  @:op(A!=B)
  inline public function notEquals(p : Vector)
    return !equals(p);

  inline public function abs() : Vector
    return Vector.create(Math.abs(x), Math.abs(y));

  inline public function copyTo(other : Vector)
    return other.set(x, y);

  public function nearEquals(p : Vector)
    return Math.abs(x - p.x) <= Floats.EPSILON && Math.abs(y - p.y) <= Floats.EPSILON;

  inline public function notNearEquals(p : Vector)
    return !nearEquals(p);

  inline public function isZero()
    return equals(zero);

  public function isNearZero()
    return nearEquals(zero);

  public function angleTo(other : Vector) {
    var cos = dot(other) / (length / other.length);
    if(cos < -1)
      cos = -1;
    else if(cos > 1)
      cos = 1;
    var radians = Math.acos(cos);
    return cross(other) < 0 ? -radians : radians;
  }

  inline public function clone() : Vector
    return this.clone();

  inline public function dot(p : Vector) : Float
    return x * p.x + y * p.y;

  inline public function normal()
    return Vector.create(y, -x);

  inline public function unit()
    return divide(length);

  inline public function perpendicular(other : Vector)
    return subtract(project(other));

  public function project(other : Vector) {
    var f = dot(other) / other.dot(other);
    return multiply(f);
  }

  inline public function cross(p : Vector)
    return x * p.y - y * p.x;

  inline public function min(p : Vector)
    return Vector.create(
      Math.min(x, p.x),
      Math.min(y, p.y)
    );

  inline public function minX(p : Vector)
    return Vector.create(
      Math.min(x, p.x),
      y
    );

  inline public function minY(p : Vector)
    return Vector.create(
      x,
      Math.min(y, p.y)
    );

  inline public function max(p : Vector)
    return Vector.create(
      Math.max(x, p.x),
      Math.max(y, p.y)
    );

  inline public function maxX(p : Vector)
    return Vector.create(
      Math.max(x, p.x),
      y
    );

  inline public function maxY(p : Vector)
    return Vector.create(
      x,
      Math.max(y, p.y)
    );

  public function vectorAt(angle :  Float, distance : Float)
    return (this : Vector) + Vector.fromAngle(angle).multiply(distance);

  public function set(nx : Float, ny : Float) : Vector {
    x = nx;
    y = ny;
    return this;
  }

  @:to inline public function toAngle() : Float
    return Math.atan2(y, x);

  @:to inline function toArray() : Array<Float>
    return [x, y];

  @:to inline function toObject() : { x : Float, y : Float }
    return { x : x, y : y };

  @:to inline public function toString()
    return 'Vector($x,$y)';

  public function transform(matrix : Matrix23) : Vector {
    return create(
      matrix.a * this.x + matrix.c * this.y,
      matrix.b * this.x + matrix.d * this.y
    );
  }

  public function apply(matrix : Matrix23) : Vector {
    return set(
      matrix.a * this.x + matrix.c * this.y,
      matrix.b * this.x + matrix.d * this.y
    );
  }

  public static function solve2Linear(a : Float, b : Float, c : Float, d : Float, u : Float, v : Float) : Null<Vector> {
    var det = a * d - b * c;
    if(det == 0)
      return null;

    var invdet = 1.0 / det,
      x =  u * d - b * v,
      y = -u * c + a * v;
    return Vector.create(x * invdet, y * invdet);
  }

  inline function get_x() return this.x;
  inline function get_y() return this.y;
  inline function set_x(v : Float) return this.x = v;
  inline function set_y(v : Float) return this.y = v;
  inline function get_length() return Math.sqrt(magnitude);
  function set_length(l : Float) {
    var d = l / length;
    x *= d;
    y *= d;
    return l;
  }
  inline function get_magnitude() return x * x + y * y;
  function set_magnitude(m : Float) {
    length = Math.sqrt(m);
    return m;
  }
}
