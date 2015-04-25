package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;

class TestPolyline {
  public function new() {}

  public function testBasics() {
    var poly = new Polyline();
    trace(poly.toString());
  }
}
