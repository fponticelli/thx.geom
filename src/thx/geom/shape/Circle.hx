package thx.geom.shape;

import thx.geom.Point;

abstract Circle({ center : Point, radius : Float }) {
	inline public function new(center : Point, radius : Float)
		this = { center : center, radius : radius };

	public var center(get, never) : Point;
	public var radius(get, never) : Float;

	inline function get_center() return this.center;
	inline function get_radius() return this.radius;

	@:to public function toString()
		return 'Circle(${center.x},${center.y},$radius)';

	// TODO this can probably be approximated with less segments
	@:to public function toSpline() {
		var segments = 32,
			angle    = Math.PI / segments,
			points   = [],
			nodes    = [],
			j;

		for(i in 0...segments * 2)
			points.push(center.pointAt(angle * i, radius));

		nodes.push(new SplineNode(points[0], points[1], points[points.length-1]));
		for(i in 1...segments-1) {
			j = i * 2;
			nodes.push(new SplineNode(points[j], points[j+1], points[j-1]));
		}
		nodes.push(new SplineNode(points[points.length-2], points[points.length-1], points[points.length-3]));
		return new Spline(nodes, true);
	}
}