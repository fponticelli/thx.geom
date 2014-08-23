package thx.geom;

import thx.geom.PathBoolean;
import thx.geom.shape.Box;

class TestPath {
	public function new() {}

	public function testBoolean() {
		var b1 = new Box(new Point(10, 10), new Point(20, 20)),
			b2 = new Box(new Point(15, 15), new Point(25, 25)),
			b = new PathBoolean(b1.toPath(), b2.toPath());
	}
}