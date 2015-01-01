package thx.geom.d2;

import utest.Assert;
import thx.geom.d2.Point;
import thx.geom.shape.Box;
import thx.geom.shape.Circle;

class TestSpline {
  public function new() {}

  public function testLength() {
    var box    = new Box(Point.create(0, 0), Point.create(10, 10)),
        spline = box.toSpline();
    Assert.equals(40, spline.length);
  }

  public function testArea() {
    var box    = new Box(Point.create(10, 10), Point.create(20, 20)),
        spline = box.toSpline();
    Assert.equals(100, spline.area);
  }

  public function testBox() {
    var test   = new Box(Point.create(10, 20), Point.create(30, 40)),
        spline = new Circle(Point.create(20, 30), 10),
        box    = spline.toSpline().box;
    Assert.isTrue(box.equals(test), 'expected $test doesn\'t match $box');
  }
}