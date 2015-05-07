package thx.geom.d2;

using thx.Floats;
import thx.geom.core.*;
import thx.math.Const;

abstract Angle(Dim) from Dim to Dim {
  @:from inline public static function fromFloat(r : Float) : Angle
    return create(r);

  inline public static function create(r : Float) : Angle
    return new Angle(new MutableDim(r));

  inline public static function linked(getAngle : Void -> Float, setAngle : Float -> Float) : Angle
    return new LinkedDim(getAngle, setAngle);

  inline public static function immutable(r : Float) : Angle
    return new ImmutableDim(r);

  public var radians(get, set) : Float;
  public var degrees(get, set) : Float;

  inline public function new(r : Dim)
    this = r;

  @:op(A==B)
  inline public function equals(p : Angle)
    return radians == p.radians;

  @:op(A!=B)
  inline public function notEquals(p : Angle)
    return !equals(p);

  public function nearEquals(p : Angle)
    return radians.nearEquals(p.radians);

  inline public function notNearEquals(p : Angle)
    return !nearEquals(p);

  inline public function isZero()
    return radians == 0;

  public function isNearZero()
    return radians.nearZero();

  inline public function clone() : Angle
    return this.clone();

  @:to inline public function toString()
    return 'Angle(${degrees}°)';

  @:to inline public function toFloat() : Float
    return this.coord;

  inline function get_radians() return this.coord;
  inline function set_radians(v : Float) return this.coord = v;

  inline function get_degrees() return this.coord * Const.TO_DEGREE;
  inline function set_degrees(v : Float) return this.coord = v * Const.TO_RADIAN;
}
