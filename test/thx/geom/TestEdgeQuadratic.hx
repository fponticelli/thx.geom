package thx.geom;

import thx.geom.EdgeQuadratic;
import thx.geom.Vertex;
import utest.Assert;

class TestEdgeQuadratic {
	var edge : EdgeQuadratic;
	public function new() {
		edge = new EdgeQuadratic(
			new Point(10, 10),
			new Point(60, 60),
			new Point(110, 60),
			new Point(160, 10)
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

	public function testInterpolate() {

	}

	public function testTangent() {

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