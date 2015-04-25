package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;

class TestLineSegment {
  public function new() {}

  public function testBasics() {
    var a = Point.create(10, 10),
        b = Point.create(100, 100),
        ab = new LineSegment(a, b);

    trace(ab.toString());
  }
}
