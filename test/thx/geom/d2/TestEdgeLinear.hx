package thx.geom;

import thx.geom.d2.Point;
import thx.geom.EdgeLinear;
import thx.geom.Vertex;
import utest.Assert;

class TestEdgeLinear {
  var edge : EdgeLinear;
  var a : Float;
  var b : Float;
  var p0 : Point;
  var p1 : Point;
  public function new() {
    p0 = Point.create(10, 10);
    p1 = Point.create(60, 60);
    edge = new EdgeLinear(p0, p1);
    a = (p1 - p0).x;
    b = (p1 - p0).y;
  }

  public function testIsLinear() {
    Assert.isTrue(edge.isLinear);
  }

  public function testArea() {
    var p = p1 - p0;
    Assert.equals(p0.y * (p1.x-p0.x) + (p.x * p.y) / 2, edge.area);
  }

  public function testLength() {
    Assert.equals(Math.sqrt(a*a+b*b), edge.length);
  }

  public function testSplit() {
    var edges = edge.split(0.2),
        a = Point.create(10, 10),
        b = Point.create(20, 20),
        c = Point.create(60, 60);
    Assert.isTrue(edges[0].equals(new EdgeLinear(a, b)));
    Assert.isTrue(edges[1].equals(new EdgeLinear(b, c)));
  }

  public function testInterpolate() {
    var point = edge.interpolate(0.2);
    Assert.isTrue(point.equals(Point.create(20, 20)));
  }

  public function testIntersectionsWithEdgeLinear() {
    var a = Point.create(10, 10),
        b = Point.create(50, 50),
        c = Point.create( 0, 60),
        d = Point.create(60,  0);

    var e0 = new EdgeLinear(a, b),
        e1 = new EdgeLinear(c, d),
        e2 = new EdgeLinear(b, c),
        e3 = new EdgeLinear(a, d);

    Assert.isTrue(e0.intersects(e1));
    var ps = e0.intersections(e1);
    Assert.equals(1, ps.length);
    Assert.isTrue(ps[0].nearEquals(Point.create(30, 30)));
    Assert.isFalse(e2.intersects(e3));
    Assert.same([], e2.intersections(e3));
  }
}