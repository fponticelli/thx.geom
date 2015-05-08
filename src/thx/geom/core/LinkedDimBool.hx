package thx.geom.core;

class LinkedDimBool implements DimBool {
  public var value(get, set) : Bool;

  var getValue : Void -> Bool;
  var setValue : Bool -> Bool;

  public function new(getValue : Void -> Bool, setValue : Bool -> Bool) {
    this.getValue = getValue;
    this.setValue = setValue;
  }

  public function clone() : DimBool
    return new MutableDimBool(getValue());

  function get_value() return getValue();
  function set_value(v : Bool) return setValue(v);
}
