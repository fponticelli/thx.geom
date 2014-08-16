package thx.geom;

import thx.geom.EdgeCubic;
import thx.geom.Vertex;
import utest.Assert;

class TestEdgeCubic {
	var edge : EdgeCubic;
	public function new() {
		edge = new EdgeCubic(
			new Point(10, 10),
			new Point(60, 60),
			new Point(110, 10)
		);
	}

	public function testIsLinear() {
		Assert.isFalse(edge.isLinear);
	}

	public function testArea() {

	}

	public function testLength() {

	}

	public function testSplit() {

	}

	public function testSplitLength() {

	}

	public function testInterpolate() {

	}

	public function testInterpolateLength() {

	}

	public function testTangent() {

	}

	public function testTangentLength() {

	}

	public function testIntersectionsWithEdgeLinear() {

	}

	public function testIntersectionsWithEdgeCubic() {

	}

	public function testIntersectionsWithEdgeQuadratic() {

	}

	public function testIntersectionsWithNonCrossingEdge() {

	}

	public function testIntersectionsWithLine() {

	}
}