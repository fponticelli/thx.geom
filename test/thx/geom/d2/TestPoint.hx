package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;

class TestPoint {
  public function new() {}

  public function testAddAssign() {
    var a = Point.create(10, 20),
        b = Point.create(20, 40),
        c = a;

    Assert.isTrue((a : XY) == (c : XY));
    a = a + b;
    Assert.isFalse((a : XY) == (c : XY));

    a = c;
    Assert.isTrue((a : XY) == (c : XY));
    a += b;
    Assert.isTrue((a : XY) == (c : XY));
  }

  public function testLerp() {
    var a = Point.create(10, 20),
        b = Point.create(20, 40);

    Assert.isTrue(a != b);
    Assert.isTrue(a.lerp(b, 0) == a);
    Assert.isTrue(a.lerp(b, 1) == b);
    Assert.isTrue(a.lerp(b, 0.5) == Point.create(15, 30));
  }

  public function testDistanceTo() {
    Assert.equals(10, Point.create(10, 10).distanceTo(Point.create(0, 10)));
  }

  public function testPointAt() {
    Assert.isTrue(Point.create(10, 30).equals(Point.create(10, 20).pointAt(Math.PI/2, 10)));
  }
}
