package thx.geom.d2;

using thx.core.Floats;
import thx.geom.core.*;
import thx.math.Const;

abstract Radius(Dim) from Dim to Dim {
  @:from inline public static function fromFloat(r : Float) : Radius
    return create(r);

  inline public static function create(r : Float) : Radius
    return new MutableDim(Math.abs(r));

  inline public static function linked(getRadius : Void -> Float, setRadius : Float -> Float) : Radius
    return new LinkedDim(getRadius, setRadius);

  inline public static function immutable(r : Float) : Radius
    return new ImmutableDim(r);

  public var coord(get, set) : Float;
  public var area(get, set) : Float;
  public var perimeter(get, set) : Float;

  inline public function new(r : Dim)
    this = r;

  @:op(A==B)
  inline public function equals(p : Radius)
    return coord == p.coord;

  @:op(A!=B)
  inline public function notEquals(p : Radius)
    return !equals(p);

  public function nearEquals(p : Radius)
    return coord.nearEquals(p.coord);

  inline public function notNearEquals(p : Radius)
    return !nearEquals(p);

  inline public function isZero()
    return coord == 0;

  public function isNearZero()
    return coord.nearZero();

  inline public function clone() : Radius
    return this.clone();

  @:to inline public function toString()
    return 'Radius($coord)';

  @:to inline public function toFloat() : Float
    return this.coord;

  inline function get_coord() return this.coord;
  inline function set_coord(v : Float) return this.coord = v;
  inline function get_area()
    return this.coord * this.coord * Const.PI;

  function set_area(v : Float) {
    this.coord = Math.sqrt(v / Const.PI);
    return v;
  }

  inline function get_perimeter()
    return this.coord * Const.TWO_PI;

  function set_perimeter(v : Float) {
    this.coord = v / Const.TWO_PI;
    return v;
  }
}
