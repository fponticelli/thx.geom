package thx.geom;

import thx.geom.shape.Box;

class EdgeLinear implements Edge {
	@:isVar public var area(get, null) : Float;
	@:isVar public var box(get, null) : Box;
	@:isVar public var length(get, null) : Float;
	@:isVar public var lengthSquared(get, null) : Float;
	@:isVar public var line(get, null) : Line;
	public var linearSegments(get, null) : Array<EdgeLinear>;
	public var linearSpline(get, null) : Spline;
	public var isLinear(get, null) : Bool;
	public var p0(default, null) : Point;
	public var p1(default, null) : Point;
	public var first(default, null) : Point;
	public var last(default, null) : Point;
	public var normalIn(default, null) : Point;
	public var normalOut(default, null) : Point;

	public function new(p0 : Point, p1 : Point) {
		first = this.p0 = p0;
		last = this.p1 = p1;
		normalIn = normalOut = null;
	}
	public function equals(other : Edge) : Bool {
		if(!Std.is(other, EdgeLinear)) return false;
		var t : EdgeLinear = cast other;
		return p0.nearEquals(t.p0) && p1.nearEquals(t.p1);
	}

	public function matches(other : Edge) : Bool
		return first.nearEquals(other.first) && last.nearEquals(other.last);

	public function transform(matrix : Matrix4x4) : EdgeLinear
		return new EdgeLinear(p0.transform(matrix), p1.transform(matrix));

	public function flip() : EdgeLinear
		return new EdgeLinear(p1, p0);

	public function direction() : Point
		return last - first;

	public function intersects(other : Edge) : Bool
		return intersections(other).length > 0;

	public function intersections(other : Edge) : Array<Point> {
		if(!box.intersects(other.box))
			return [];
		if(Std.is(other, EdgeLinear)) {
			return intersectionsEdgeLinear(cast other);
		} else {
			return intersectionsEdgeCubic(cast other);
		}
	}

	public function intersectionsEdgeLinear(other : EdgeLinear) : Array<Point> {
		var ps = intersectionsLine(other.line);
		if(ps.length == 0 || other.intersectsLine(line))
			return ps;
		else
			return [];
	}

	public function intersectionsEdgeCubic(other : EdgeCubic) : Array<Point>
		return other.intersectionsEdgeLinear(this);

	public function intersectsLine(line : Line) : Bool
		return intersectionsLine(line).length > 0;

	public function intersectionsLine(line : Line) : Array<Point> {
		var l = Line.fromPoints(p0, p1),
			p = l.intersectionLine(line);
		if(null != p) {
			if(p0.x == p1.x) { // vertical line
				if(p.y >= p0.min(p1).y && p.y <= p0.max(p1).y)
					return [p];
			} else if(p.x >= p0.min(p1).x && p.x <= p0.max(p1).x) {
				return [p];
			}
		}
		return [];
	}

	public function split(v : Float) : Array<Edge> {
		var mid = interpolate(v);
		return [
			new EdgeLinear(p0, mid),
			new EdgeLinear(mid, p1)
		];
	}

	public function interpolate(v : Float) : Point
		return p0.interpolate(p1, v);

	public function interpolateNode(v : Float) : SplineNode {
		var p = interpolate(v);
		if(null == v)
			return null;
		return new SplineNode(p, null, null);
	}

	public function toLinear()
		return this;

	public function toArray()
		return [p0,p1];

	public function toString() : String
		return 'Edge($p0,$p1)';

	public function toSpline()
		return Spline.fromEdges([this], false);

	var _area = false;
	function get_area() : Float {
		if(!_area) {
			_area = true;
			var p = p1 - p0;
			area = p0.y * (p1.x - p0.x) + (p.x * p.y) / 2;
		}
		return area;
	}

	function get_box() : Box {
		if(null == box) {
			box = Box.fromPoints(p0, p1);
		}
		return box;
	}

	function get_isLinear()
		return true;

	var _length = false;
	function get_length() : Float {
		if(!_length) {
			_length = true;
			length = Math.sqrt(lengthSquared);
		}
		return length;
	}

	var _lengthSquared = false;
	function get_lengthSquared() {
		if(!_lengthSquared) {
			_lengthSquared = true;
			lengthSquared = (p1-p0).lengthSquared;
		}
		return lengthSquared;
	}

	function get_line() : Line {
		if(null == line)
			line = Line.fromPoints(p0, p1);
		return line;
	}

	function get_linearSegments()
		return [this];

	function get_linearSpline()
		return linearSpline = Spline.fromEdges([this], false);
}