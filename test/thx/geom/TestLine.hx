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

	public function testIntersectionLine() {
		Assert.isTrue(new Point(50,20).equals(line.intersectionLine(h)));
		Assert.isTrue(new Point(10,10).equals(line.intersectionLine(v)));
		Assert.isTrue(new Point(10,20).equals(v.intersectionLine(h)));
		Assert.isTrue(new Point(10,20).equals(h.intersectionLine(v)));
		var off = line.offset(10);
		Assert.isNull(line.intersectionLine(off));
	}

	function horiz() return Line.fromPoints(new Point(100, 10), new Point(200, 10));
	function vert() return Line.fromPoints(new Point(10, 100), new Point(10, 200));

	public function testIsHorizontal() {
		Assert.isTrue(horiz().isHorizontal);
		Assert.isFalse(vert().isHorizontal);
		Assert.isFalse(line.isHorizontal);
	}

	public function testIsVertical() {
		Assert.isTrue(vert().isVertical);
		Assert.isFalse(horiz().isVertical);
		Assert.isFalse(line.isVertical);
	}
}