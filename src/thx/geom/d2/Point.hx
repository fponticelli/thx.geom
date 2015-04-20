package thx.geom.d2;

import thx.geom.d2.xy.*;
using thx.core.Arrays;
using thx.core.Floats;

abstract Point(XY) from XY to XY {
  public static var zero(default, null) : Point = Point.immutable(0, 0);

  @:from public static function fromFloats(arr : Array<Float>) {
    arr.resize(2, 0);
    return create(arr[0], arr[1]);
  }

  @:from static inline function fromObject(o : { x : Float, y : Float })
    return create(o.x, o.y);

  @:from static inline public function fromAngle(angle :  Float)
    return create(Math.cos(angle), Math.sin(angle));

  inline public static function create(x : Float, y : Float) : Point
    return new MutableXY(x, y);

  inline public static function linked(getX : Void -> Float, getY : Void -> Float, setX : Float -> Float, setY : Float -> Float) : Point
    return new LinkedXY(getX, getY, setX, setY);

  inline public static function immutable(x : Float, y : Float) : Point
    return new ImmutableXY(x, y);

  public var x(get, set) : Float;
  public var y(get, set) : Float;

  inline public function new(xy : XY)
    this = xy;

  inline public function asVector()
    return new Vector(this);

  @:op(A+=B) inline public function addPointAssign(p : Point) : Point
    return set(x + p.x, y + p.y);

  @:op(A+B) inline public function addPoint(p : Point)
    return Point.create(x + p.x, y + p.y);

  @:op(A+=B) inline public function addAssign(v : Float) : Point
    return set(x + v, y + v);

  @:op(A+B) inline public function add(v : Float)
    return Point.create(x + v, y + v);

  @:op(-A) inline public function negate()
    return Point.create(-x, -y);

  @:op(A-=B) inline public function subtractPointAssign(p : Point) : Point
    return set(x - p.x, y - p.y);

  @:op(A-B) inline public function subtractPoint(p : Point)
    return addPoint(p.negate());

  @:op(A-=B) inline public function subtractAssign(v : Float) : Point
    return set(x - v, y - v);

  @:op(A-B) inline public function subtract(v : Float)
    return add(-v);

  @:op(A*=B) inline public function multiplyPointAssign(p : Point) : Point
    return set(x * p.x, y * p.y);

  @:op(A*B) inline public function multiplyPoint(p : Point)
    return Point.create(x * p.x, y * p.y);

  @:op(A*=B) inline public function multiplyAssign(v : Float) : Point
    return set(x * v, y * v);

  @:commutative
  @:op(A*B) inline public function multiply(v : Float)
    return Point.create(x * v, y * v);

  @:op(A/=B) inline public function dividePointAssign(p : Point) : Point
    return set(x / p.x, y / p.y);

  @:op(A/B) inline public function dividePoint(p : Point)
    return Point.create(x / p.x, y / p.y);

  @:op(A/=B) inline public function divideAssign(v : Float) : Point
    return set(x / v, y / v);

  @:op(A/B) inline public function divide(v : Float)
    return Point.create(x / v, y / v);

  @:op(A==B)
  inline public function equals(p : Point)
    return (x == p.x) && (y == p.y);

  @:op(A!=B)
  inline public function notEquals(p : Point)
    return !equals(p);

  inline public function abs() : Point
    return Point.create(Math.abs(x), Math.abs(y));

  inline public function copyTo(other : Point)
    return other.set(x, y);

  public function nearEquals(p : Point)
    return Math.abs(x - p.x) <= Floats.EPSILON && Math.abs(y - p.y) <= Floats.EPSILON;

  inline public function notNearEquals(p : Point)
    return !nearEquals(p);

  public function lerp(p : Point, f : Float)
    return addPoint(p.subtractPoint(this).multiply(f));

  inline public function isZero()
    return equals(zero);

  public function isNearZero()
    return nearEquals(zero);

  inline public function clone() : Point
    return this.clone();

  public function distanceTo(p : Point)
    return Math.abs(subtractPoint(p).asVector().length);

  public function magnitudeTo(p : Point)
    return subtractPoint(p).asVector().magnitude;

  inline public function min(p : Point)
    return Point.create(
      Math.min(x, p.x),
      Math.min(y, p.y)
    );

  inline public function minX(p : Point)
    return Point.create(
      Math.min(x, p.x),
      y
    );

  inline public function minY(p : Point)
    return Point.create(
      x,
      Math.min(y, p.y)
    );

  inline public function max(p : Point)
    return Point.create(
      Math.max(x, p.x),
      Math.max(y, p.y)
    );

  inline public function maxX(p : Point)
    return Point.create(
      Math.max(x, p.x),
      y
    );

  inline public function maxY(p : Point)
    return Point.create(
      x,
      Math.max(y, p.y)
    );

  public function pointAt(angle :  Float, distance : Float)
    return (this : Point) + Point.fromAngle(angle).multiply(distance);

  public function set(nx : Float, ny : Float) : Point {
    x = nx;
    y = ny;
    return this;
  }

  @:to inline function toArray() : Array<Float>
    return [x, y];

  @:to inline function toObject() : { x : Float, y : Float }
    return { x : x, y : y };

  @:to inline public function toString()
    return 'Point($x,$y)';

  public static function solve2Linear(a : Float, b : Float, c : Float, d : Float, u : Float, v : Float) : Null<Point> {
    var det = a * d - b * c;
    if(det == 0)
      return null;

    var invdet = 1.0 / det,
      x =  u * d - b * v,
      y = -u * c + a * v;
    return Point.create(x * invdet, y * invdet);
  }

  public function transform(matrix : Matrix23) : Point {
    return create(
      matrix.a * x + matrix.c * y,
      matrix.b * x + matrix.d * y
    );
  }

  public function apply(matrix : Matrix23) : Point {
    return set(
      matrix.a * x + matrix.c * y,
      matrix.b * x + matrix.d * y
    );
  }

  public function lerpAtY(other : Point, y : Float) {
    var f1 = y - this.y,
        f2 = other.y - this.y,
        t;
    if(f2 < 0) {
      f1 = -f1;
      f2 = -f2;
    }
    if(f1 <= 0)
      t = 0.0;
    else if(f1 >= f2)
      t = 1.0;
    else if(f2 < thx.math.Const.E)
      t = 0.5;
    else
      t = f1 / f2;
    return this.x + t * (other.x - this.x);
  }

  inline function get_x() return this.x;
  inline function get_y() return this.y;
  inline function set_x(v : Float) return this.x = v;
  inline function set_y(v : Float) return this.y = v;
}
