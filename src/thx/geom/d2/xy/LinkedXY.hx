package thx.geom.d2.xy;

class LinkedXY implements XY {
  public var x(get, set) : Float;
  public var y(get, set) : Float;

  var getX : Void -> Float;
  var getY : Void -> Float;
  var setX : Float -> Float;
  var setY : Float -> Float;

  public function new(getX : Void -> Float, getY : Void -> Float, setX : Float -> Float, setY : Float -> Float) {
    this.getX = getX;
    this.getY = getY;
    this.setX = setX;
    this.setY = setY;
  }

  function get_x() return getX();
  function get_y() return getY();
  function set_x(v : Float) return setX(v);
  function set_y(v : Float) return setY(v);
}