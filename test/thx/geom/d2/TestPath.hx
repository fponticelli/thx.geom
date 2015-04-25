package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;

class TestPath {
  public function new() {}

  public function testBasics() {
    var path = new Path();
    trace(path.toString());
  }
}
