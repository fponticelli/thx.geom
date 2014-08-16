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
			new Point(110, 60),
			new Point(160, 10)
		);
	}

	public function testIsLinear() {
		Assert.isFalse(edge.isLinear);
	}

	static function areaPoint(p : Point)
		return p.x * p.y / 2;

	public function testArea() {
		var max = areaPoint(edge.p1 - edge.p0)
				+ areaPoint(edge.p2 - edge.p1)
				+ areaPoint(edge.p3 - edge.p2),
			min = areaPoint(edge.p3 - edge.p0),
			area = edge.area;
		Assert.isTrue(area > min);
		Assert.isTrue(area < max);
	}

	public function testLength() {
		var max = (edge.p1 - edge.p0).length
				+ (edge.p2 - edge.p1).length
				+ (edge.p3 - edge.p2).length,
			min = (edge.p3 - edge.p0).length,
			length = edge.length;
		Assert.isTrue(length > min);
		Assert.isTrue(length < max);
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

	public function testIntersectionsWithNonCrossingEdge() {

	}

	public function testIntersectionsWithLine() {

	}
}