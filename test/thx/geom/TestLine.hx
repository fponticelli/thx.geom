package thx.geom;

import thx.geom.Line;
import utest.Assert;

class TestLine {
	var a : Point;
	var b : Point;
	var line : Line;
	var h : Line;
	var v : Line;
	public function new() {
		a = new Point(10, 10);
		b = new Point(50, 20);
		line = Line.fromPoints(a, b);

		h = Line.fromPoints(new Point(0,20), new Point(10,20));
		v = Line.fromPoints(new Point(10,0), new Point(10,10));
	}

	public function testXAtY() {
		Assert.floatEquals(30, line.xAtY(15));
		Assert.equals(Math.NEGATIVE_INFINITY, h.xAtY(15));
		Assert.floatEquals(10, v.xAtY(15));
	}

	public function testAbsDistanceToPoint() {
		Assert.equals(0, line.absDistanceToPoint(a));
		Assert.equals(20, h.absDistanceToPoint(Point.zero));
		Assert.equals(10, v.absDistanceToPoint(Point.zero));
	}

	public function testIntersectionWithLine() {
		Assert.isTrue(new Point(50,20).equals(line.intersectionWithLine(h)));
		Assert.isTrue(new Point(10,10).equals(line.intersectionWithLine(v)));
		Assert.isTrue(new Point(10,20).equals(v.intersectionWithLine(h)));
		Assert.isTrue(new Point(10,20).equals(h.intersectionWithLine(v)));
		var off = line.offset(10);
		Assert.isNull(line.intersectionWithLine(off));
	}
}