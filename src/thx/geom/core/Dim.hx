package thx.geom.core;

interface Dim {
  var coord(get, set) : Float;
  function clone() : Dim;
}
