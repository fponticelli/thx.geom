package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;

class TestPath {
  public function new() {}

  public function testParseSVGPath() {
    var d = "M 80 80 A 45 45 0 0 0 125 125 L 125 80 L 80 80 Z",
        path = Path.fromSVGPath(d);
    Assert.equals(d, path.toSVGPath());
  }

  public function testParseSVGPathMultiClosing() {
    var d = "M 100 100 L 150 20 L 200 100 L 100 100 Z M 250 100 L 300 20 L 350 100 L 250 100 Z",
        path = Path.fromSVGPath(d);
    Assert.equals(d, path.toSVGPath());
  }
}
