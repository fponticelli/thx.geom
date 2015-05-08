package thx.geom.core;

class ImmutableDimBool implements DimBool {
  public var value(get, set) : Bool;
  var _value : Bool;

  public function new(value : Bool)
    _value = value;

  public function clone() : DimBool
    return new MutableDimBool(_value);

  function get_value() : Bool return _value;
  function set_value(v : Bool) : Bool return throw 'this instance of DimBool cannot be modified';
}
