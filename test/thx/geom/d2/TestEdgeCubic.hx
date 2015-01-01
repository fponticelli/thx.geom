package thx.geom;

import thx.geom.d2.Point;
import thx.geom.EdgeCubic;
import thx.geom.Vertex;
import utest.Assert;

class TestEdgeCubic {
  var edge : EdgeCubic;
  public function new() {
    edge = new EdgeCubic(
      Point.create(0, 0),
      Point.create(0, 100),
      Point.create(100, 100),
      Point.create(100, 0)
    );
  }

  public function testIsLinear() {
    Assert.isFalse(edge.isLinear);
  }

  static function areaPoints(p0 : Point, p1 : Point) {
    var p = p1 - p0;
    return p0.y * (p1.x - p0.x) + (p.x * p.y) / 2;
  }

  public function testArea() {
    var max = areaPoints(edge.p0, edge.p1)
	          + areaPoints(edge.p1, edge.p2)
	          + areaPoints(edge.p2, edge.p3),
        min = areaPoints(edge.p0, edge.p3),
        area = edge.area;
    Assert.isTrue(area > min);
    Assert.isTrue(area < max);
  }

  public function testLength() {
    var max = (edge.p1 - edge.p0).length
	          + (edge.p2 - edge.p1).length
	          + (edge.p3 - edge.p2).length,
        min = (edge.p3 - edge.p0).length,
        length = edge.length;
    Assert.isTrue(length > min);
    Assert.isTrue(length < max);
  }
}