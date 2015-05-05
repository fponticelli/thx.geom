package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;

class TestPolyline {
  public function new() {}

  public function testBasics() {
    var poly = new Polyline([
            Point.create(10, 10),
            Point.create(10, 20),
            Point.create(20, 10)
          ]);


    Assert.isTrue(poly.box.bottomLeft == Point.create(10, 10));
    Assert.isTrue(poly.box.topRight == Point.create(20, 20));
  }
}
