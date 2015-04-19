package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.d2.xy.*;
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

  public function testInterpolate() {
    var a = Point.create(10, 20),
        b = Point.create(20, 40);

    Assert.isTrue(a != b);
    Assert.isTrue(a.interpolate(b, 0) == a);
    Assert.isTrue(a.interpolate(b, 1) == b);
    Assert.isTrue(a.interpolate(b, 0.5) == Point.create(15, 30));
  }

  public function testLength() {
    var a = Point.create(10, 20);
    Assert.equals(Math.sqrt(10*10+20*20), a.length);
  }

  public function testNormalize() {
    var a = Point.create(2, 0);
    Assert.equals(1, a.normalize().x);
    Assert.equals(0, a.normalize().y);
    a = Point.create(0, 5);
    Assert.equals(0, a.normalize().x);
    Assert.equals(1, a.normalize().y);
  }

  public function testDistanceTo() {
    Assert.equals(10, Point.create(10, 10).distanceTo(Point.create(0, 10)));
  }

  public function testPointAt() {
    Assert.isTrue(Point.create(10, 30).equals(Point.create(10, 20).pointAt(Math.PI/2, 10)));
  }

  public function testToAngle() {
    Assert.floatEquals(Math.PI / 4, Point.create(1, 1).toAngle());
  }
}
