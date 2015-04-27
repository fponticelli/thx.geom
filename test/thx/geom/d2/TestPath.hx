package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;

class TestPath {
  public function new() {}

  public function testParseSVGPath() {
    var d = "M 80 80 A 45 45 0 0 0 125 125 L 125 80 Z",
        path = Path.fromSVGPath(d);
    Assert.equals(d, path.toSVGPath());
  }
}
