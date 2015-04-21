package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;

class TestRadius {
  public function new() {}

  public function testBasics() {
    var r : Radius = -5;
    Assert.equals(5, r.coord);
    Assert.floatEquals(78.53981633974483, r.area);
    Assert.floatEquals(31.41592653589793, r.circumference);
  }
}
