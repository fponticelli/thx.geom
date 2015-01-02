package thx.geom.d3.xyz;

class ImmutableXYZ implements XYZ {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  public var z(get, set) : Float;
  var _x : Float;
  var _y : Float;
  var _z : Float;

  public function new(x : Float, y : Float, z : Float) {
    _x = x;
    _y = y;
    _z = z;
  }

  public function apply44(matrix : Matrix44)
    matrix.applyLeftMultiplyPoint3D(this);

  public function clone() : XYZ return new MutXYZ(_x, _y, _z);


  function get_x() return _x;
  function get_y() return _y;
  function get_z() return _z;
  function set_x(v : Float) return throw 'this instance of Point cannot be modified';
  function set_y(v : Float) return throw 'this instance of Point cannot be modified';
  function set_z(v : Float) return throw 'this instance of Point cannot be modified';
}