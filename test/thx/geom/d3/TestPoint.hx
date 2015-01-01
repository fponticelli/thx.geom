package thx.geom.d3;

import utest.Assert;
import thx.geom.d3.*;

class TestPoint {
  public function new() {}

  public function testInterpolate3D() {
    var a = Point.create(10, 20, 30),
        b = Point.create(20, 40, 60);

    Assert.isTrue(a != b);
    Assert.isTrue(a.interpolate(b, 0) == a);
    Assert.isTrue(a.interpolate(b, 1) == b);
    Assert.isTrue(a.interpolate(b, 0.5) == Point.create(15, 30, 45));
  }
}