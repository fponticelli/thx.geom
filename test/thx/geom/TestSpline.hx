package thx.geom;

import utest.Assert;
import thx.geom.shape.Box;
import thx.geom.shape.Circle;

class TestSpline {
	public function new() {}

	public function testLength() {
		var box    = new Box(new Point(0, 0), new Point(10, 10)),
			spline = box.toSpline();
		Assert.equals(40, spline.length);
	}

	public function testArea() {
		var box    = new Box(new Point(10, 10), new Point(20, 20)),
			spline = box.toSpline();
		Assert.equals(100, spline.area);
	}

	public function testBox() {
		var test   = new Box(new Point(10, 20), new Point(30, 40)),
			spline = new Circle(new Point(20, 30), 10),
			box    = spline.toSpline().box;
		Assert.isTrue(box.equals(test), 'expected $test doesn\'t match $box');
	}
}