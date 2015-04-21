package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;

class TestVector {
  public function new() {}

  public function testLength() {
    var a = Vector.create(10, 20);
    Assert.equals(Math.sqrt(10*10+20*20), a.length);
  }

  public function testUnit() {
    var a = Vector.create(2, 0);
    Assert.equals(1, a.unit().x);
    Assert.equals(0, a.unit().y);
    a = Vector.create(0, 5);
    Assert.equals(0, a.unit().x);
    Assert.equals(1, a.unit().y);
  }

  public function testDistanceTo() {
    Assert.equals(10, Vector.create(10, 10).distanceTo(Vector.create(0, 10)));
  }

  public function testToAngle() {
    Assert.floatEquals(Math.PI / 4, Vector.create(1, 1).toAngle());
  }
}
