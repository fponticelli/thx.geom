package thx.geom.core;

class ImmutableDim implements Dim {
  public var coord(get, set) : Float;
  var _coord : Float;

  public function new(coord : Float)
    _coord = coord;

  public function clone() : Dim
    return new MutableDim(_coord);

  function get_coord() return _coord;
  function set_coord(v : Float) return throw 'this instance of Dim cannot be modified';
}
