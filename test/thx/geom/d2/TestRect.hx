package thx.geom.d2;

import thx.geom.d2.*;
import thx.geom.core.*;
import utest.Assert;

class TestRect {
  public function new() {}

  public function testBasics() {
    var position = Point.create(10, 20),
        size = Size.create(-40, 20),
        rect = new Rect(position, size);
    Assert.equals(-30, rect.left);
    Assert.equals( 10, rect.right);
    Assert.equals( 40, rect.top);
    Assert.equals( 20, rect.bottom);
    Assert.floatEquals(800, rect.area);
    Assert.floatEquals(120, rect.perimeter);
  }

  public function testAnchorPoints() {
    var rect = Rect.create(10, 20, 20, -40),
        tl = rect.topLeft(),
        br = rect.bottomRight(),
        c  = rect.center();
    Assert.equals( 10, tl.x);
    Assert.equals( 20, tl.y);
    Assert.equals( 30, br.x);
    Assert.equals(-20, br.y);
    Assert.equals( 20, c.x);
    Assert.equals(  0, c.y);

    rect.right = 60;
    rect.left = 20;
    rect.top = 40;
    rect.bottom = 10;

    Assert.equals( 20, tl.x);
    Assert.equals( 40, tl.y);
    Assert.equals( 60, br.x);
    Assert.equals( 10, br.y);
    Assert.equals( 40, c.x);
    Assert.equals( 25, c.y);

    c.x = 50;
    c.y = 30;

    Assert.equals( 30, tl.x);
    Assert.equals( 45, tl.y);
    Assert.equals( 70, br.x);
    Assert.equals( 15, br.y);
  }
}
