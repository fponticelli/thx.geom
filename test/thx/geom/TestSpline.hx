package thx.geom;

import utest.Assert;
import thx.geom.shape.Box;
import thx.geom.shape.Circle;

class TestSpline {
	public function new() {}

	public function testLength() {
		/*
		var box  = new Box(new Point(0, 0), new Point(10, 10)),
			path = box.toSpline();
		Assert.equals(40, path.length);
		*/
	}

	public function testBox() {
		/*
		var test = new Box(new Point(10, 20), new Point(30, 40)),
			path = new Circle(new Point(20, 30), 10),
			box  = path.toSpline().box;
		Assert.isTrue(box.equals(test), 'expected $test doesn\'t match $box');
		*/
	}

	public function testArea() {

	}

	public function testIsSelfIntersecting() {

	}

	public function testIsNotSelfIntersecting() {

	}

	public function testIsPolygon() {

	}

	public function testIsNotPolygon() {

	}

	public function testAt() {

	}

	public function testInterpolate() {

	}

	public function testIntersection() {

	}

	public function testTangent() {

	}

	public function testInterpolateTangent() {

	}

	public function testContains() {

	}
}