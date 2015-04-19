package thx.geom.d2.xy;

interface XY {
  var x(get, set) : Float;
  var y(get, set) : Float;
  function clone() : XY;
}
