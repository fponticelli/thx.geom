package thx.geom.mut;

import utest.Assert;
import thx.geom.mut.Point;

class TestPoint {
  public function new() {}

  public function testLinkedPoint() {
    var p1 = Point.create(0, 0),
        p2 = p1.connect(Point.create(10, 20));
    Assert.equals(0, p1.x);
    Assert.equals(0, p1.y);

    Assert.equals(10, p2.x);
    Assert.equals(20, p2.y);

    p1.x = 5;
    p1.y = 10;

    Assert.equals(5, p1.x);
    Assert.equals(10, p1.y);

    Assert.equals(15, p2.x);
    Assert.equals(30, p2.y);

    p2.x = 5;
    p2.y = 10;

    Assert.equals(5, p2.x);
    Assert.equals(10, p2.y);

    Assert.equals(-5, p1.x);
    Assert.equals(-10, p1.y);
  }
}