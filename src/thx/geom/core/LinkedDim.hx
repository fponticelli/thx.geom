package thx.geom.core;

class LinkedDim implements Dim {
  public var coord(get, set) : Float;

  var getCoord : Void -> Float;
  var setCoord : Float -> Float;

  public function new(getCoord : Void -> Float, setCoord : Float -> Float) {
    this.getCoord = getCoord;
    this.setCoord = setCoord;
  }

  public function clone() : Dim
    return new MutableDim(getCoord());

  function get_coord() return getCoord();
  function set_coord(v : Float) return setCoord(v);
}
