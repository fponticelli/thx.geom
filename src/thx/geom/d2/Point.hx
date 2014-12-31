package thx.geom.d2;

using thx.core.Arrays;
using thx.core.Floats;

abstract Point(XY) from XY to XY {
  public static var zero(default, null) : Point = Point.linked(function() return 0, function() return 0, function(_) return 0, function(_) return 0);

  @:from public static function fromFloats(arr : Array<Float>) {
    arr.resize(2, 0);
    return create(arr[0], arr[1]);
  }

  @:from static inline function fromObject(o : { x : Float, y : Float })
    return create(o.x, o.y);

  @:from static inline public function fromAngle(angle :  Float)
    return create(Math.cos(angle), Math.sin(angle));

  inline public static function linked(getX : Void -> Float, getY : Void -> Float, setX : Float -> Float, setY : Float -> Float)
    return new Point(new LinkedXY(getX, getY, setX, setY));

  inline public static function create(x : Float, y : Float)
    return new Point(new PointXY(x, y));

  public var x(get, set) : Float;
  public var y(get, set) : Float;
  public var length(get, never) : Float;
  public var lengthSquared(get, never) : Float;

  inline public function new(xy : XY)
    this = xy;

  @:op(A+B) inline public function addPoint(p : Point)
    return Point.create(x + p.x, y + p.y);

  @:op(A+B) inline public function add(v : Float)
    return Point.create(x + v, y + v);

  @:op(-A) inline public function negate()
    return Point.create(-x, -y);

  @:op(A-B) inline public function subtractPoint(p : Point)
    return addPoint(p.negate());

  @:op(A-B) inline public function subtract(v : Float)
    return add(-v);

  @:op(A*B) inline public function multiplyPoint(p : Point)
    return Point.create(x * p.x, y * p.y);

  @:commutative
  @:op(A*B) inline public function multiply(v : Float)
    return Point.create(x * v, y * v);

  @:op(A/B) inline public function dividePoint(p : Point)
    return Point.create(x / p.x, y / p.y);

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

  public function nearEquals(p : Point)
    return Math.abs(x - p.x) <= Floats.EPSILON && Math.abs(y - p.y) <= Floats.EPSILON;

  inline public function notNearEquals(p : Point)
    return !nearEquals(p);

  public function interpolate(p : Point, f : Float)
    return addPoint(p.subtractPoint(this).multiply(f));

  inline public function isZero()
    return equals(zero);

  public function isNearZero()
    return nearEquals(zero);

  inline public function dot(p : Point) : Float
    return x * p.x + y * p.y;

  inline public function normal()
    return Point.create(y, -x);

  inline public function normalize()
    return divide(length);

  public function distanceTo(p : Point)
    return Math.abs(subtractPoint(p).length);

  public function distanceToSquared(p : Point)
    return subtractPoint(p).lengthSquared;

//  inline public function transform(matrix : Matrix4x4)
//    return matrix.leftMultiplyPoint((this : Point));

  inline public function cross(p : Point)
    return x * p.y - y * p.x;

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

  public function isOnLine(line : Line) : Bool {
    if(line.isHorizontal)
      return Floats.nearEquals(y, line.w);
    return Floats.nearEquals(line.xAtY(y), x);
  }

  @:to inline public function toAngle() : Float
    return Math.atan2(y, x);

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

  public static function interpolateBetween2DPointsForY(p1 : Point, p2 : Point, y : Float) {
    var f1 = y - p1.y,
      f2 = p2.y - p1.y,
      t;
    if(f2 < 0) {
      f1 = -f1;
      f2 = -f2;
    }
    if(f1 <= 0)
      t = 0.0;
    else if(f1 >= f2)
      t = 1.0;
    else if(f2 < 1e-10)
      t = 0.5;
    else
      t = f1 / f2;
    return p1.x + t * (p2.x - p1.x);
  }

  inline function get_x() return this.x;
  inline function get_y() return this.y;
  inline function set_x(v : Float) return this.x = v;
  inline function set_y(v : Float) return this.y = v;
  inline function get_length() return Math.sqrt(lengthSquared);
  inline function get_lengthSquared() return x * x + y * y;
}