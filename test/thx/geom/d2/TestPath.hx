package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;
using thx.Iterables;

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

  public function testIssue20160429() {
    var d = "M 0 9 L 9 0 18 0 0 18 Z M 9 18 L 18 9 18 18 Z",
        path = Path.fromSVGPath(d),
        od = path.toSVGPath();
    Assert.equals(od, Path.fromSVGPath(od).toSVGPath());
  }
}
