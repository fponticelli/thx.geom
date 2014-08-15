package thx.geom;

import utest.Assert;
import thx.geom.Point;

using thx.unit.angle.Degree;

class TestPoint {
	public function new() {}

	public function testInterpolate() {
		var a = new Point(10, 20),
			b = new Point(20, 40);

		Assert.isTrue(a != b);
		Assert.isTrue(a.interpolate(b, 0) == a);
		Assert.isTrue(a.interpolate(b, 1) == b);
		Assert.isTrue(a.interpolate(b, 0.5) == new Point(15, 30));
	}

	#if thx_unit
	public function testFromAngle() {
		var p = Point.fromAngle(90.toDegrees());
		Assert.isTrue(new Point(0, 1).nearEquals(p));
	}
	#end
}