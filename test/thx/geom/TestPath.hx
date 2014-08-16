package thx.geom;

import thx.geom.shape.Box;

class TestPath {
	public function new() {}

	public function testLength() {
		var box  = new Box(new Point(0, 0), new Point(10, 10)),
			path = box.toSpline();

		
	}
}