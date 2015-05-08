package thx.geom.d2;

import thx.geom.core.*;

abstract Flag(DimBool) from DimBool to DimBool {
  @:from inline public static function fromInt(r : Int) : Flag
    return create(r != 0);

  @:from inline public static function create(r : Bool) : Flag
    return new Flag(new MutableDimBool(r));

  inline public static function linked(getFlag : Void -> Bool, setFlag : Bool -> Bool) : Flag
    return new LinkedDimBool(getFlag, setFlag);

  inline public static function immutable(r : Bool) : Flag
    return new ImmutableDimBool(r);

  public var int(get, set) : Int;
  public var value(get, set) : Bool;

  inline public function new(r : DimBool)
    this = r;

  @:op(A==B)
  inline public function equals(p : Flag)
    return value == p.value;

  @:op(A!=B)
  inline public function notEquals(p : Flag)
    return !equals(p);

  inline public function isTrue()
    return value == true;

  inline public function isFalse()
    return value == false;

  inline public function clone() : Flag
    return this.clone();

  @:to inline public function toString()
    return 'Flag(${value})';

  @:to inline public function toInt() : Int
    return this.value ? 1 : 0;

  @:to inline public function toBool() : Bool
    return this.value;

  inline function get_int() return toInt();
  inline function set_int(v : Int) {
    this.value = v != 0;
    return v;
  }

  inline function get_value() return this.value;
  inline function set_value(v : Bool) return this.value = v;
}
