package thx.geom;

import thx.geom.shape.Box;
using thx.core.Arrays;

class EdgeCubic implements Edge {
	public static var NEAR_FLAT : Float = 1.001; //1.0 + Const.EPSILON;
	@:isVar public var box(get, null) : Box;
	@:isVar public var area(get, null) : Float;
	@:isVar public var length(get, null) : Float;
	@:isVar public var lengthSquared(get, null) : Float;
	@:isVar public var linearSegments(get, null) : Array<EdgeLinear>;
	@:isVar public var linearSpline(get, null) : Spline;
	public var isLinear(default, null) : Bool;
	public var p0(default, null) : Point;
	public var p1(default, null) : Point;
	public var p2(default, null) : Point;
	public var p3(default, null) : Point;
	public var first(default, null) : Point;
	public var last(default, null) : Point;
	public var normalIn(default, null) : Point;
	public var normalOut(default, null) : Point;

	public function new(p0 : Point, p1 : Point, p2 : Point, p3 : Point) {
		isLinear = false;
		first = this.p0 = p0;
		normalOut = this.p1 = p1;
		normalIn = this.p2 = p2;
		last = this.p3 = p3;
	}
	public function equals(other : Edge) : Bool {
		if(!Std.is(other, EdgeCubic)) return false;
		var t : EdgeCubic = cast other;
		return p0.nearEquals(t.p0) && p1.nearEquals(t.p1) && p2.nearEquals(t.p2) && p3.nearEquals(t.p3);
	}

	public function matches(other : Edge) : Bool
		return first.nearEquals(other.first) && last.nearEquals(other.last);

	public function transform(matrix : Matrix4x4) : EdgeCubic
		return new EdgeCubic(p0.transform(matrix), p1.transform(matrix), p2.transform(matrix), p3.transform(matrix));

	public function flip() : Edge
		return new EdgeCubic(p3, p2, p1, p0);

	public function direction() : Point
		return last - first;

	public function intersects(other : Edge) : Bool
		return intersections(other).length > 0;

	public function intersections(other : Edge) : Array<Point>
		if(Std.is(other, EdgeLinear))
			return intersectionsEdgeLinear(cast other);
		else
			return intersectionsEdgeCubic(cast other);

	public function intersectionsEdgeLinear(other : EdgeLinear) : Array<Point>
		return linearSegments.map(function(edge : EdgeLinear)
			return edge.intersectionsEdgeLinear(other)
		).flatten();

	public function intersectionsEdgeCubic(other : EdgeCubic) : Array<Point>
		return linearSpline.intersectionsSpline(other.linearSpline);

	public function intersectsLine(line : Line) : Bool
		return intersectionsLine(line).length > 0;

	public function intersectionsLine(line : Line) : Array<Point>
		return throw "not implemented";

	public function split(v : Float) : Array<Edge> {
		var node = interpolateNode(v);
		if(null == node)
			return [];
		return [
			new EdgeCubic(p0, p1, node.normalIn, node.position),
			new EdgeCubic(node.position, node.normalOut, p2, p3)
		];
	}

	public function interpolate(v : Float) : Point {
		var n = interpolateNode(v);
		if(null == n)
			return null;
		return n.position;
	}

	public function interpolateNode(v : Float) : SplineNode
		return throw "not implemented";

	public function toEdgeLinear()
		return new EdgeLinear(first, last);

	public function toArray()
		return [p0,p1,p2,p3];

	public function toString() : String
		return 'Edge($p0,$p1,$p2,$p3)';

	public function toSpline()
		return Spline.fromEdges([this], false);

	public function isNearFlat() : Bool {
		var sum = p0.distanceTo(p1) + p1.distanceTo(p2) + p2.distanceTo(p3),
			len = p0.distanceTo(p3);
		return (sum / len) <= NEAR_FLAT;
	}

	public function subdivide() {
		var l1 = (p0 + p1) / 2,
			m  = (p1 + p2) / 2,
			r2 = (p2 + p3) / 2,
			l2 = (l1 +  m) / 2,
			r1 = ( m + r2) / 2,
			l3 = (l2 + r1) / 2;
		return [
			new EdgeCubic(p0, l1, l2, l3),
			new EdgeCubic(l3, r1, r2, p3)
		];
	}

	function get_area() : Float {
		if(null == area)
			area = linearSegments.reduce(function(acc, edge)
				return acc + edge.area, 0);
		return area;
	}

	function get_box() : Box {
		if(null == box)
			box = Box.fromPoints(p0, p1).expandByPoints([p2, p3]);
		return box;
	}

	function get_length() : Float {
		if(null == length)
			length = Math.sqrt(lengthSquared);
		return length;
	}

	function get_lengthSquared() : Float {
		if(null == lengthSquared)
			lengthSquared = linearSegments.reduce(function(acc, edge)
				return acc + edge.lengthSquared, 0);
		return lengthSquared;
	}

	function get_linearSegments() {
		if(null == linearSegments) {
			var tosplit = [this],
				edge;
			linearSegments = [];
			while(tosplit.length > 0) {
				edge = tosplit.shift();
				if(edge.isNearFlat()) {
					linearSegments.push(edge.toEdgeLinear());
				} else {
					tosplit = edge.subdivide().concat(tosplit);
				}
			}
		}
		return linearSegments;
	}

	function get_linearSpline() {
		if(null == linearSpline)
			linearSpline = Spline.fromEdges(cast linearSegments, false);
		return linearSpline;
	}
}