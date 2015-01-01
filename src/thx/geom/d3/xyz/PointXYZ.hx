package thx.geom.d3.xyz;

class PointXYZ implements XYZ {
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

  function get_x() return _x;
  function get_y() return _y;
  function get_z() return _z;
  function set_x(v : Float) return _x = v;
  function set_y(v : Float) return _y = v;
  function set_z(v : Float) return _z = v;
}