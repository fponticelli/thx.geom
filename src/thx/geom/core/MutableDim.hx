package thx.geom.core;

class MutableDim implements Dim {
  public var coord(get, set) : Float;
  var _coord : Float;

  public function new(coord : Float, y : Float)
    _coord = coord;

  public function clone() : Dim
    return new MutableDim(_coord);

  function get_coord() return _coord;
  function set_coord(v : Float) return _coord = v;
}
