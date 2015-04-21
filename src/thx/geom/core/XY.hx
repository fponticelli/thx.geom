package thx.geom.core;

interface XY {
  var x(get, set) : Float;
  var y(get, set) : Float;
  function clone() : XY;
}
