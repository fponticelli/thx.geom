package thx.geom;

import thx.geom.EdgeLinear;
import thx.geom.Vertex;
import utest.Assert;

class TestEdgeLinear {
	var edge : EdgeLinear;
	var a : Float;
	var b : Float;
	public function new() {
		var p0 = new Point(10, 10),
			p1 = new Point(60, 60);
		edge = new EdgeLinear(p0, p1);
		a = (p1 - p0).x;
		b = (p1 - p0).y;
	}

	public function testIsLinear() {
		Assert.isTrue(edge.isLinear);
	}

	public function testArea() {
		Assert.equals(a*b/2, edge.area);
	}

	public function testLength() {
		Assert.equals(Math.sqrt(a*a+b*b), edge.length);
	}

	public function testSplit() {
		var edges = edge.split(0.2),
			a = new Point(10, 10),
			b = new Point(20, 20),
			c = new Point(60, 60);
		Assert.isTrue(edges[0].equals(new EdgeLinear(a, b)));
		Assert.isTrue(edges[1].equals(new EdgeLinear(b, c)));
	}

	public function testInterpolate() {
		var point = edge.interpolate(0.2);
		Assert.isTrue(point.equals(new Point(20, 20)));
	}

	public function testIntersectionsWithEdgeLinear() {
		var a = new Point(10, 10),
			b = new Point(50, 50),
			c = new Point( 0, 60),
			d = new Point(60,  0);

		var e0 = new EdgeLinear(a, b),
			e1 = new EdgeLinear(c, d),
			e2 = new EdgeLinear(b, c),
			e3 = new EdgeLinear(a, d);

		Assert.isTrue(e0.intersects(e1));
		var ps = e0.intersections(e1);
		Assert.equals(1, ps.length);
		Assert.isTrue(ps[0].nearEquals(new Point(30, 30)));
		Assert.isFalse(e2.intersects(e3));
		Assert.same([], e2.intersections(e3));
	}

	public function testIntersectionsWithEdgeCubic() {

	}
}