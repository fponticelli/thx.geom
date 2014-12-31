package thx.geom.mut;

using thx.core.Arrays;

@:forward(x, y)
abstract Point(XY) {
  @:from public static function fromFloats(arr : Array<Float>) {
    arr.resize(2, 0);
    return new Point(new PointXY(arr[0], arr[1]));
  }

  inline public static function createLinked(getX : Void -> Float, getY : Void -> Float, setX : Float -> Float, setY : Float -> Float)
    return new Point(new LinkedXY(getX, getY, setX, setY));

  inline public static function create(x : Float, y : Float)
    return new Point(new PointXY(x, y));

  public var x(get, set) : Float;
  public var y(get, set) : Float;

  inline public function new(xy : XY)
    this = xy;

  public function connect(p : Point) {
    return createLinked(
      function() return x + p.x,
      function() return y + p.y,
      function(v) return x = v - p.x,
      function(v) return y = v - p.y
    );
  }

  inline public function equals(other : Point)
    return x == other.x && y == other.y;

  inline function get_x() return this.x;
  inline function get_y() return this.y;
  inline function set_x(v : Float) return this.x = v;
  inline function set_y(v : Float) return this.y = v;
}

interface XY {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
}

class PointXY implements XY {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  var _x : Float;
  var _y : Float;

  public function new(x : Float, y : Float) {
    _x = x;
    _y = y;
  }

  function get_x() return _x;
  function get_y() return _y;
  function set_x(v : Float) return _x = v;
  function set_y(v : Float) return _y = v;
}

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

  public function set(x : Float, y : Float) : Void {
    this.x = x;
    this.y = y;
  }

  function get_x() return getX();
  function get_y() return getY();
  function set_x(v : Float) return setX(v);
  function set_y(v : Float) return setY(v);
}