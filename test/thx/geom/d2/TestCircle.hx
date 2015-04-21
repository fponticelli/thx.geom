package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;

class TestCircle {
  public function new() {}

  public function testBasics() {
    var center = Point.create(10, 20),
        radius = 5,
        circle = new Circle(center, radius);
    Assert.equals(10, circle.x);
    Assert.equals(20, circle.y);
    Assert.equals( 5, circle.left);
    Assert.equals(15, circle.right);
    Assert.equals(15, circle.top);
    Assert.equals(25, circle.bottom);
    Assert.equals( 5, (circle.radius : Float));
    Assert.floatEquals(78.53981633974483, circle.area);
    Assert.floatEquals(31.41592653589793, circle.circumference);
  }
}
