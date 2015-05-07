package thx.geom.core;

class MutableDim implements Dim {
  public var coord(get, set) : Float;
  var _coord : Float;

  public function new(coord : Float)
    _coord = coord;

  public function clone() : Dim
    return new MutableDim(_coord);

  function get_coord() : Float return _coord;
  function set_coord(v : Float) : Float return _coord = v;
}
