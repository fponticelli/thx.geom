package thx.geom.d2.xy;

class ImmutableXY implements XY {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  var _x : Float;
  var _y : Float;

  public function new(x : Float, y : Float) {
    _x = x;
    _y = y;
  }

  public function apply44(matrix : Matrix44) {
    matrix.applyLeftMultiplyPoint(this);
    return this;
  }

  public function clone() : XY
    return new MutXY(_x, _y);

  function get_x() return _x;
  function get_y() return _y;
  function set_x(v : Float) return throw 'this instance of Point cannot be modified';
  function set_y(v : Float) return throw 'this instance of Point cannot be modified';
}