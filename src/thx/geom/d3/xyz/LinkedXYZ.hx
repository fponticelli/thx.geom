package thx.geom.d3.xyz;

class LinkedXYZ implements XYZ {
  public var x(get, set) : Float;
  public var y(get, set) : Float;
  public var z(get, set) : Float;

  var getX : Void -> Float;
  var getY : Void -> Float;
  var getZ : Void -> Float;
  var setX : Float -> Float;
  var setY : Float -> Float;
  var setZ : Float -> Float;

  public function new(getX : Void -> Float, getY : Void -> Float, getZ : Void -> Float, setX : Float -> Float, setY : Float -> Float, setZ : Float -> Float) {
    this.getX = getX;
    this.getY = getY;
    this.getZ = getZ;
    this.setX = setX;
    this.setY = setY;
    this.setZ = setZ;
  }

  public function apply44(matrix : Matrix44) {
    matrix.applyLeftMultiplyPoint3D(this);
    return this;
  }

  public function clone() : XYZ return new MutXYZ(getX(), getY(), getZ());

  function get_x() return getX();
  function get_y() return getY();
  function get_z() return getZ();
  function set_x(v : Float) return setX(v);
  function set_y(v : Float) return setY(v);
  function set_z(v : Float) return setZ(v);
}