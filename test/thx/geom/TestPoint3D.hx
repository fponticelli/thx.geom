package thx.geom;

import utest.Assert;
import thx.geom.Point3D;

class TestPoint3D {
	public function new() {}

	public function testInterpolate3D() {
		var a = new Point3D(10, 20, 30),
			b = new Point3D(20, 40, 60);

		Assert.isTrue(a != b);
		Assert.isTrue(a.interpolate(b, 0) == a);
		Assert.isTrue(a.interpolate(b, 1) == b);
		Assert.isTrue(a.interpolate(b, 0.5) == new Point3D(15, 30, 45));
	}
}